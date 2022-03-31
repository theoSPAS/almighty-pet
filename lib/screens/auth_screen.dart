import 'dart:io';
import 'package:almighty_pet/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      BuildContext context, bool isLogin, File? image) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance.refFromURL('gs://almighty-pet.appspot.com').child('user_image').child(userCredential.user!.uid + '.jpg');

        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
             .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'user_image' : url,
        }).then((value) => print('User added'));
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme
            .of(context)
            .errorColor,
      ));
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    }catch (err) {
      print(err);
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,_isLoading
      ),
    );
  }
}
