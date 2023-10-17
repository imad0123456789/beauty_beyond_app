import 'package:beauty_beyond_app/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/appointment_model.dart';


class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final Function() onActionDone;
  const AppointmentCard({Key? key, required this.appointment, required this.onActionDone})
      : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  cancelAppointment() async {
    await FirebaseFirestore.instance
        .collection('booking')
        .doc(widget.appointment.id)
        .update({"status": AppointmentStatus.canceled.name});
    setState(() {
      widget.onActionDone();
    });
  }

  completeAppointment() async {
    await FirebaseFirestore.instance
        .collection('booking')
        .doc(widget.appointment.id)
        .update({"status": AppointmentStatus.completed.name});
    setState(() {
      widget.onActionDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  /*
                  SizedBox(
                    width: Config.widthSize * 0.33,
                    child: Image.network(
                      doctor.image,
                      fit: BoxFit.fill,
                    ),
                  ),

                   */
                  /*
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/doctor01.jpg'),
                  ),

                   */
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.appointment.doctorName,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.appointment.doctorCategory.name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              //Schedule info
              ScheduleCard(
                appointment: widget.appointment,
              ),
              Config.spaceSmall,
              //action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {
                        await cancelAppointment();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Complete',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () async {
                        await completeAppointment();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final AppointmentModel appointment;
  const ScheduleCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${appointment.day}, ${appointment.date}',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            appointment.time,
            style: const TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
