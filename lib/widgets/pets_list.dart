import 'package:almighty_pet/models/pet.dart';
import 'package:almighty_pet/providers/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:almighty_pet/widgets/pet_item.dart';
import 'package:provider/provider.dart';

class PetsList extends StatelessWidget {
  final bool showFavs;
  final int selectedIndex;

  PetsList(this.showFavs, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    final petsData =Provider.of<PetProvider>(context, listen: true);
    var pets = showFavs ? petsData.favoritePets : petsData.pets;
    if(showFavs == false){
      pets = petsData.categoryPets(selectedIndex);
    }

    return Container(
      padding: EdgeInsets.only(
        top: 80
      ),
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
