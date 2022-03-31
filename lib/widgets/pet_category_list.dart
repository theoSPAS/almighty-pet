import 'package:almighty_pet/models/pet.dart';
import 'package:almighty_pet/providers/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:almighty_pet/widgets/pet_item.dart';
import 'package:provider/provider.dart';

class PetsCategoryList extends StatelessWidget {
  final int selectedCategory;

  PetsCategoryList(this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    final petsData =Provider.of<PetProvider>(context, listen: true);
    final pets = petsData.categoryPets(selectedCategory);

    return Container(
      child: ListView.builder(
        physics:  const BouncingScrollPhysics(),
        itemCount: pets.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: ChangeNotifierProvider<Pet>.value(
            value: pets[index],
            child : PetItem(),
          ),
        ),
      ),
    );
  }
}
