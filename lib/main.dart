import 'package:almighty_pet/screens/auth_screen.dart';
import 'package:almighty_pet/screens/edit_pet_screen.dart';
import 'package:almighty_pet/screens/home.dart';
import 'package:almighty_pet/screens/message.dart';
import 'package:almighty_pet/screens/pet_category_overview_screen.dart';
import 'package:almighty_pet/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:almighty_pet/screens/pet_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/pet_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
    ChangeNotifierProvider(
        create : (ctx) => PetProvider(),
      child:
    MaterialApp(
        title: 'AlmightyPet',
        theme: ThemeData(
          backgroundColor: Colors.lightBlueAccent,
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.red,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
           builder: (ctx, userSnapshot) {
            if(userSnapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
            if(userSnapshot.hasData){
              return HomePageScreen();
             }
            return AuthScreen();
           },
        ),
        routes: {
          PetDetailScreen.routeName : (ctx) => PetDetailScreen(),
          HomePageScreen.routeName : (ctx) => HomePageScreen(),
          Message.routeName : (ctx) => Message(),
          PetsCategoryOverviewScreen.routeName : (ctx) => PetsCategoryOverviewScreen(),
          EditPetScreen.routeName : (ctx) => EditPetScreen(),
        },
    ),
    );
  }
}
