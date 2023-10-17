import 'dart:convert';

import 'package:beauty_beyond_app/models/appointment_model.dart';
import 'package:beauty_beyond_app/screens/booking_page.dart';
import 'package:beauty_beyond_app/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  AppointmentStatus _status = AppointmentStatus.upcoming; // initial status
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  //get appointments details
  // Future<void> getAppointments() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final token = preferences.getString('token') ?? '';
  //   //final appointment = ;

  //   setState(() {
  //     //schedules= json.decoder(appointment);
  //   });
  // }

  @override
  void initState() {
    getAppointments();
    super.initState();
  }

  bool _loadingAppointmnets = false;
  List<AppointmentModel> appointments = [];

  getAppointments() async {
    setState(() {
      _loadingAppointmnets = true;
    });
    Future<QuerySnapshot<Map<String, dynamic>>> query =
        AthenticationData.userData!.type == 'user'
            ? FirebaseFirestore.instance
                .collection('booking')
                .where("userId", isEqualTo: AthenticationData.userData!.id)
                .get()
            : FirebaseFirestore.instance
                .collection('booking')
                .where("doctorId",
                    isEqualTo: AthenticationData.userData!.doctorId)
                .get();
    await query.then((value) {
      final documents = value.docs;
      appointments =
          (documents.map((e) => AppointmentModel.fromDocument(e)).toList());
      setState(() {
        _loadingAppointmnets = false;
      });
    });
  }

  cancelAppointment(String appointmentId) async {
    await FirebaseFirestore.instance
        .collection('booking')
        .doc(appointmentId)
        .update({"status": AppointmentStatus.canceled.name});
    setState(() {
      getAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AppointmentModel> filteredSchedules =
        appointments.where((appointment) {
      /*
      switch(schedule ['status']){
        case'upcoming':
          schedule['status'] = FilterStatus.upcoming;
      break;
        case'complete':
          schedule['status'] = FilterStatus.complete;
          break;
        case'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }

       */
      return appointment.status == _status;
    }).toList();

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Appointment Schedule',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // the filter tabs
                    for (AppointmentStatus appointmentStatus
                        in AppointmentStatus.values)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (appointmentStatus ==
                                  AppointmentStatus.upcoming) {
                                _status = AppointmentStatus.upcoming;
                                _alignment = Alignment.centerLeft;
                              } else if (appointmentStatus ==
                                  AppointmentStatus.completed) {
                                _status = AppointmentStatus.completed;
                                _alignment = Alignment.center;
                              } else if (appointmentStatus ==
                                  AppointmentStatus.canceled) {
                                _status = AppointmentStatus.canceled;
                                _alignment = Alignment.centerRight;
                              }
                            });
                          },
                          child: Center(
                            child: Text(appointmentStatus.name),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedAlign(
                alignment: _alignment,
                duration: const Duration(microseconds: 200),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Config.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        _status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Config.spaceSmall,
          Expanded(
              child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder: (context, index) {
                    var _schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length + 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: !isLastElement
                          ? const EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                // CircleAvatar(
                                //   backgroundImage:
                                //       AssetImage(_schedule.),
                                // ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _schedule.doctorName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _schedule.doctorCategory.name,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ScheduleCard(
                              appointment: _schedule,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      await cancelAppointment(_schedule.id!);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Config.primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Config.primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => BookingPage(
                                              
                                                    appointmentForReschedule:
                                                        _schedule,
                                                  )));
                                    },
                                    child: const Text(
                                      'Reschedule',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    ));
  }
}

class ScheduleCard extends StatelessWidget {
  final AppointmentModel appointment;
  const ScheduleCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${appointment.day}, ${appointment.date}',
            style: const TextStyle(color: Config.primaryColor),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            appointment.time,
            style: const TextStyle(color: Config.primaryColor),
          ))
        ],
      ),
    );
  }
}
