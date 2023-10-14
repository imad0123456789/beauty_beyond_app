import 'package:beauty_beyond_app/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String? id;
  String date;
  String day;
  String time;
  final String userId;
  final String doctorId;
  final String doctorName;
  final DoctorCategoryName doctorCategory;
  AppointmentStatus status;
  final String token;

  AppointmentModel({
    this.id,
    required this.date,
    required this.day,
    required this.time,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorCategory,
    required this.status,
    required this.token,
  });

  factory AppointmentModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return AppointmentModel(
      id: document.id,
      date: data['Date'],
      day: data['Day'],
      time: data['Time'],
      userId: data['userId'].toString(),
      doctorId: data['doctorId'].toString(),
      doctorName: (data['doctorName'] ?? 'Doctor Name'),
      doctorCategory: (DoctorCategoryName.values.singleWhere(
          (e) => e.name == data['doctorCategory'],
          orElse: () => DoctorCategoryName.another)),
      token: data['token'].toString(),
      status: AppointmentStatus.values
          .singleWhere((element) => element.name == data['status']),
    );
  }

  Map<String, dynamic> toDocument() => {
        "Date": date,
        "Day": day,
        "Time": time,
        "userId": userId,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "doctorCategory": doctorCategory.name,
        "status": status.name,
        "token": token,
      };

  Map<String, dynamic> toRescheduleUpdate() => {
        "Date": date,
        "Day": day,
        "Time": time,
        "status": status.name,
      };

  AppointmentModel reschedule(String newDay, String newDate, String newTime) {
    status = AppointmentStatus.upcoming;
    day = newDay;
    date = newDate;
    time = newTime;
    return this;
  }

  completeAppointment() {
    status = AppointmentStatus.completed;
  }

  cancelAppointment() {
    status = AppointmentStatus.canceled;
  }
}

enum AppointmentStatus {
  upcoming,
  completed,
  canceled,
}
