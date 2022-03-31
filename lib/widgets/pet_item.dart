import 'package:almighty_pet/consts/const_file.dart';
import 'package:almighty_pet/models/pet.dart';
import 'package:almighty_pet/screens/pet_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<Pet>(context);
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<Pet>.value(
       value: pet,
      child:
    GestureDetector(
          onTap: (){
             Navigator.of(context).pushNamed(
               PetDetailScreen.routeName,
               arguments: pet.id
             );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 240,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(
                    top: 70,
                    bottom: 20
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.48,
                      ),
                      Expanded
                        (child: Container(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                          pet.name.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                            Icon(
                              pet.gender == Gender.female
                                  ? Icons.female
                                  : Icons.male,
                              size: 18,
                              color: fadedBlack,
                            ),
                          ],
                        ),
                        Text(
                          pet.breed.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: fadedBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pet.age.toString() + ' years',
                          style: TextStyle(
                            fontSize: 12,
                            color: fadedBlack,
                          ),
                        ),
                        Row(
                          children: [
                          Icon(
                          Icons.location_pin,
                          size: 16,
                          color: primaryGreen,
                        ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            pet.address.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: fadedBlack,
                            ),
                          )
                          ],
                        )
                          ],
                        ),
                      ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: customShadowBox,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 41),
                  width: size.width * 0.48,
                  height: size.height,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: customShadowBox,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.only(top: 50),
                      ),
                      Align(
                        child: Hero(
                          tag: pet.id.toString(),
                          child: Image.asset(
                            pet.image.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
     ),
    );
  }
}
