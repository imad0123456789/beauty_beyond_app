import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorModel {
  final String id;
  final String name;
  final String about;
  final DoctorCategoryName category;
  final String details;
  final String experice;
  final int patients;
  final int reviews;
  final double rating;
  final String image;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.about,
    required this.category,
    required this.details,
    required this.experice,
    required this.patients,
    required this.reviews,
    required this.rating,
    required this.image,
  });

  factory DoctorModel.fromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return DoctorModel(
      id: document.id,
      name: data['name'],
      about: data['about'],
      category: DoctorCategoryName.values.singleWhere((e) => e.name == data['category']),
      details: data['details'],
      experice: data['experience'],
      patients: data['patients'],
      rating: data['rating'],
      image: data['image'],
      reviews: data['reviews'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "name": name,
        "about": about,
        "category": category,
        "details": details,
        "experice": experice,
        "patients": patients,
        "rating": rating,
      };

  // IconData getCategoryIcon() =>
  //     categoriesIcons.singleWhere((element) => element.name == category).icon;
}

enum DoctorCategoryName {
  preliminary,
  botox,
  filler,
  another,
}

class DoctorCategory {
  final String? id;
  final DoctorCategoryName name;
  final IconData icon;

  DoctorCategory({
    this.id,
    required this.name,
    required this.icon,
  });
}

List<DoctorCategory> categoriesIcons = [
  DoctorCategory(
    icon: FontAwesomeIcons.userDoctor,
    name: DoctorCategoryName.preliminary,
  ),
  DoctorCategory(
    icon: FontAwesomeIcons.syringe,
    name: DoctorCategoryName.botox,
  ),
  DoctorCategory(
    icon: FontAwesomeIcons.syringe,
    name: DoctorCategoryName.filler,
  ),
  DoctorCategory(
    icon: FontAwesomeIcons.userDoctor,
    name: DoctorCategoryName.another,
  ),
];
