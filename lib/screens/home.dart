import 'package:almighty_pet/screens/edit_pet_screen.dart';
import 'package:almighty_pet/screens/pet_category_overview_screen.dart';
import 'package:almighty_pet/screens/pets_overview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum FilterOptions{
  Favorites,
  All,
  Logout,
}

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var _showOnlyFavoritesPets = false;
  var _showPetCategories = false;
  var selectedIndex= 0;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('AlmightyPet'),
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue){
                setState(() {
                  if(selectedValue == FilterOptions.All){
                    _showOnlyFavoritesPets = false;
                  }else if(selectedValue == FilterOptions.Favorites){
                    _showOnlyFavoritesPets = true;
                  }else if(selectedValue == FilterOptions.Logout){
                    FirebaseAuth.instance.signOut();
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  const PopupMenuItem(child: Text('Favorites'),
                  value : FilterOptions.Favorites),
                  const PopupMenuItem(child: Text('All'),
                  value: FilterOptions.All),
                  const PopupMenuItem(child: Text('Logout'),
                      value: FilterOptions.Logout),
                ]),
          ],
        ),
          drawer : Drawer(
            child: ListView(
               children: [
                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('users')
                      .doc(user?.uid).get(),
                  builder: (ctx, snapshot) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data?['username'] ?? null
                      ),
                      accountEmail: Text(
                          snapshot.data?['email'] ?? null
                      ),
                      currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                           snapshot.data?['user_image'] ?? null
                      )),
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .backgroundColor,
                      ),
                    );
                  }
                ),
                InkWell(
                  child: ListTile(
                    title: const Text('Home Page'),
                    leading: Icon(Icons.home,
                      color: Theme.of(context).backgroundColor,),
                    onTap: (){
                     Navigator.of(context).pushReplacementNamed(HomePageScreen.routeName);
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    title: const Text('Pet Actions'),
                    leading: Icon(Icons.person,
                      color: Theme.of(context).backgroundColor,),
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        EditPetScreen.routeName
                      );
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    title: const Text('Categories'),
                    leading:  Icon(Icons.dashboard,
                      color: Theme.of(context).backgroundColor,),
                    onTap: (){
                        setState(() {
                          _showPetCategories = true;
                        });
                        Navigator.of(context).pushNamed(
                            PetsCategoryOverviewScreen.routeName,
                            arguments: selectedIndex
                        );
                    },
                  ),
                ),
                InkWell(
                  child: ListTile(
                    title: const Text('Logout'),
                    leading: Icon(Icons.logout,
                      color: Theme.of(context).backgroundColor,),
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              ],
            ),
          ),
        body: PetsOverviewScreen(_showOnlyFavoritesPets, selectedIndex)
    );
  }
}
