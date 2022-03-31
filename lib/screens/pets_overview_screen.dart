import 'package:almighty_pet/widgets/pet_category.dart';
import 'package:flutter/material.dart';
import '../widgets/pets_list.dart';

class PetsOverviewScreen extends StatelessWidget {
  final bool showFavoritePets;
  final int selectedIndex;

  PetsOverviewScreen(this.showFavoritePets, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PetCategories(selectedIndex),
          PetsList(showFavoritePets, selectedIndex)
        ],
      ));
  }
}
