import 'dart:io' show Platform;
import 'package:almighty_pet/consts/const_file.dart';
import 'package:almighty_pet/providers/pet_provider.dart';
import 'package:almighty_pet/screens/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import '../widgets/factory/widget_factory.dart';

class PetDetailScreen extends StatefulWidget {
  static const routeName = '/pet-detail';

  PetDetailScreen();

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  WidgetFactory? _factory;

  @override
  void initState() {
    if (Platform.isIOS) {
      _factory = IOsWidgetFactory();
    } else if (Platform.isAndroid) {
      _factory = AndroidWidgetFactory();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final petId = ModalRoute.of(context)!.settings.arguments as String;
    final pet = Provider.of<PetProvider>(context).findById(petId);
    final size = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: pet,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Hero(
                              tag: petId,
                              child: Image.asset(
                                pet.image as String,
                                //fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/lajka.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Lajka Лајка',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Owner',
                                      style: TextStyle(
                                        color: fadedBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Text(
                                  DateFormat.yMMMd().format(DateTime.now()),
                                  style: TextStyle(
                                    color: fadedBlack,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              pet.description as String,
                              style: TextStyle(
                                color: fadedBlack,
                                height: 1.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 42,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.chevron_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 120,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: customShadowBox,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pet.name as String,
                          style: TextStyle(
                            color: fadedBlack,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          pet.gender == 'female' ? Icons.female : Icons.male,
                          size: 22,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pet.breed as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pet.age.toString() + ' years',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.location_pin,
                                    size: 18,
                                    color: primaryGreen,
                                  ),
                                  style: const ButtonStyle(),
                                  onPressed: () {
                                    MapsLauncher.launchCoordinates(
                                        pet.location.latitude.toDouble(),
                                        pet.location.longitude.toDouble());
                                  },
                                  label: Container(
                                    child: Text(
                                      pet.address as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: fadedBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: IconButton(
                          icon: Icon(pet.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            setState(() {
                              pet.favoriteStatusChange();
                            });
                          }),
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: _factory?.createButton(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Message()));
                      }, 'Message'),
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
