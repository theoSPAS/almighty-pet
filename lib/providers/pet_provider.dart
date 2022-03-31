import 'package:almighty_pet/models/pet.dart';
import 'package:flutter/material.dart';
import '../models/location.dart';

class PetProvider with ChangeNotifier{
  List<Pet> _pets = [
    Pet(
        Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
        false,
        id: 'p1',
        name: 'Bruno',
        description: 'This is my dog Bruno',
        age: 1,
        category: PetCategory.dog,
        breed: 'Labrador',
        address: 'Kumanovo MKD',
        image: "images/labrador horizontal.jpg",
        gender: Gender.male,
        date: null),
    Pet(Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
        false,
        id: 'p2',
        name: 'Nezuko',
        category: PetCategory.dog,
        breed: 'Akita Inu',
        description: 'Nezuko is a perfect dog',
        age: 2,
        address: 'Skopje MKD',
        image: "images/akita horizontal.jpg",
        gender: Gender.female,
        date: null
    ),
    Pet(Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
        false,
        id: 'p3',
        name: 'Giorgo',
        description: 'Giorgo is a perfect dog',
        age: 4,
        category: PetCategory.dog,
        breed: 'Pug',
        address: 'Bitola MKD',
        image: "images/pug horizontal.jpg",
        gender: Gender.male,
        date: '2012-02-27'),
    Pet(Location(latitude: 41.989948561073035, longitude: 21.486265197965615,),
      false,
        id: 'p4',
        name: 'Lana',
        category: PetCategory.dog,
        description: 'Lana is a sweetheart',
        age: 3,
        breed: 'Maltese',
        address: 'Bitola MKD',
        image: "images/maltezer horizontal.jpg",
        gender: Gender.female,
        date: '2012-02-27'
    ),
    Pet(Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
      false,
      id: 'p5',
      name: 'Mando',
      category: PetCategory.dog,
      description: 'Mando is a sweetheart',
      age: 3,
      breed: 'Husky',
      address: 'Skopje MKD',
      image: "images/haski.jpg",
      gender: Gender.male,
        date: '2012-02-27'
    ),
    Pet(Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
        false,
        id: 'p6',
        name: 'Lorien',
        category: PetCategory.cat,
        description: 'Mando is a sweetheart',
        age: 2,
        breed: 'Persian',
        address: 'Skopje MKD',
        image: "images/cat-pet.jpg",
        gender: Gender.female,
        date: '2012-02-27'
    ),
    Pet(
        Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
        false,
        id: 'p7',
        name: 'Corry',
        category: PetCategory.bunny,
        description: 'Corry is a sweetheart',
        age: 2,
        breed: 'Netherland Dwarf',
        address: 'Skopje MKD',
        image: "images/bunny-pet.webp",
        gender: Gender.male,
        date: '2012-02-27'
    )
  ];
  List<Pet> get pets{
    return [..._pets];
  }

  List<Pet> get favoritePets{
    return _pets.where((petItem) => petItem.isFavorite).toList();
  }

  List<Pet> categoryPets(int index){
    if(index == 0){
      return _pets;
    }else if(index == 1){
      return _pets.where((petItem) => petItem.category == PetCategory.cat).toList();
    }else if(index == 2){
      return _pets.where((petItem) => petItem.category == PetCategory.dog).toList();
    }else if(index == 3){
      return _pets.where((petItem) => petItem.category == PetCategory.bunny).toList();
    }
    return _pets;
  }


  Pet findById(String id){
    return _pets.firstWhere((pet) => pet.id == id);
  }

  addPet(Pet pet){
    final newPet = Pet(
        pet.location,
        pet.isFavorite,
        id: pet.id,
        name: pet.image,
        description: pet.description,
        age: pet.age,
        category: pet.category,
        breed: pet.breed,
        address: pet.address,
        image: pet.image,
        gender: pet.gender,
        date: pet.date);
    _pets.add(newPet);
    notifyListeners();
  }

  updatePet(String id, Pet editedPet) {
    final petIndex = _pets.indexWhere((pet) => pet.id == id);
    if(petIndex >= 0){
      _pets[petIndex] = editedPet;
      notifyListeners();
    }
  }

  void deletePet(String id){
    _pets.removeWhere((pet) => pet.id == id);
    notifyListeners();
  }
}