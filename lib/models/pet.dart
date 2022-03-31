import 'package:almighty_pet/models/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Gender { male, female, non }

enum PetCategory {
  cat,
  dog,
  bunny,
  non
}

class Pet with ChangeNotifier {
  String id;
  String name;
  String description;
  int age;
  String breed;
  Gender gender;
  PetCategory category;
  String image;
  String address;
  String? date;
  bool isFavorite = false;
  Location location;

  Pet(this.location, this.isFavorite,
      {required this.id,
      required this.name,
      required this.description,
      required this.age,
      required this.category,
      required this.breed,
      required this.address,
      required this.image,
      required this.gender,
      required this.date});

  void favoriteStatusChange() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
