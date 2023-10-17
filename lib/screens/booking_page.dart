import 'package:beauty_beyond_app/components/custom_appbar.dart';
import 'package:beauty_beyond_app/models/appointment_model.dart';
import 'package:beauty_beyond_app/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../components/button.dart';
import '../modals/booking_datatime_converted.dart';
import '../utils/authentication.dart';
import '../utils/config.dart';

class BookingPage extends StatefulWidget {
  final DoctorModel? doctor;
  final AppointmentModel? appointmentForReschedule;
  const BookingPage({Key? key, this.doctor, this.appointmentForReschedule})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final _auth = FirebaseAuth.instance;

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token;

  Future<void> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token') ?? '';
  }

  bool _lodingBook = false;

  List<AppointmentModel> doctorAppointments = [];

  Future loadDoctorAppointments() async {
    print("APPPPPP");
    final query = await FirebaseFirestore.instance
        .collection('booking')
        .where('doctorId',
            isEqualTo: widget.appointmentForReschedule != null
                ? widget.appointmentForReschedule?.doctorId
                : widget.doctor?.id)
        .where("status", isEqualTo: AppointmentStatus.upcoming.name)
        .get()
        .then((value) {
      final documents = value.docs;
      doctorAppointments =
          documents.map((e) => AppointmentModel.fromDocument(e)).toList();
    });
  }

  Future bookingAppointment() async {
    setState(() {
      _lodingBook = true;
    });
    if (widget.appointmentForReschedule == null) {
      final AppointmentModel appointment = AppointmentModel(
        date: DataConverted.getDate(_currentDay),
        day: DataConverted.getDay(_currentDay.weekday),
        time: DataConverted.getTime(_currentIndex!),
        userId: AthenticationData.userData!.id!,
        doctorId: widget.doctor!.id,
        doctorName: widget.doctor!.name,
        doctorCategory: widget.doctor!.category,
        status: AppointmentStatus.upcoming,
        token: token!,
      );
      await FirebaseFirestore.instance
          .collection('booking')
          .add(appointment.toDocument())
          .then((value) {
        print('Added Appointment Details successfully');
        setState(() {
          _lodingBook = false;
        });
      });
    } else {
      final newAppointment = widget.appointmentForReschedule!.reschedule(
        DataConverted.getDay(_currentDay.weekday),
        DataConverted.getDate(_currentDay),
        DataConverted.getTime(_currentIndex!),
      );
      await FirebaseFirestore.instance
          .collection('booking')
          .doc(widget.appointmentForReschedule!.id!)
          .update(newAppointment.toRescheduleUpdate());
    }
  }

  @override
  void initState() {
    getToken();
    loadDoctorAppointments();
    print(AthenticationData.userData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalender(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select The treatment  Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      'Weekend is not available, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          //when selected, update current index and set time selected yo true
                          _currentIndex = index;
                          _timeSelected = true;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.black),
                          borderRadius: BorderRadius.circular(15),
                          color: _currentIndex == index
                              ? Config.primaryColor
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 9} :00 ${index + 9 > 11 ? "PM" : "AM"}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _currentIndex == index ? Colors.white : null,
                          ),
                        ),
                      ),
                    );
                  }, childCount: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.5),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () async {
                  if (doctorAppointments.any((e) =>
                      e.date == DataConverted.getDate(_currentDay) &&
                      e.time == DataConverted.getTime(_currentIndex!))) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            alignment: Alignment.center,
                            title: Text('Sorry, this time is already booked !, try another time'),
                            backgroundColor: Colors.pinkAccent,
                          );
                        });
                  } else {
                    await bookingAppointment();

                    Navigator.of(context).pushNamed('success_booking');
                  }
                },
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          )
        ],
      ),
    );
  }

  // table calendar
  Widget _tableCalender() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          // ckeck if weekend is selected 6
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}
