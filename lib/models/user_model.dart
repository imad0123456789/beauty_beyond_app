import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String family;
  final String email;
  final String mobileNumber;
  final int age;
  final String type;
  final String details;

  const UserModel({
    this.id,
    required this.name,
    required this.family,
    required this.email,
    required this.mobileNumber,
    required this.age,
    required this.type,
    required this.details,
  });

  factory UserModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      name: data['name'],
      family: data['family'],
      email: data['email'],
      mobileNumber: data['mobileNumber'],
      age: data['age'],
      type: data['type'],
      details: data['details'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "name": name,
        "family": family,
        "email": email,
        "mobileNumber": mobileNumber,
        "age": age,
        "type": type,
        "details": details,
      };
}

enum UserType {
  user,
}