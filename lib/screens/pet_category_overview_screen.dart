import 'package:almighty_pet/widgets/pet_category.dart';
import 'package:flutter/material.dart';
import '../widgets/pet_category_list.dart';

class PetsCategoryOverviewScreen extends StatelessWidget {
  PetsCategoryOverviewScreen();

  static const routeName = '/pet-categories';

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AlmightyPet'),
      ),
        body:
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
              children : [
                PetCategories(selectedIndex),
          Container(
              padding: const EdgeInsets.only(top: 40),
                child :PetsCategoryList(selectedIndex)),
              ]),
        ));
  }
}
