import 'dart:io';
import 'package:almighty_pet/models/bloc.dart';
import 'package:almighty_pet/widgets/user_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      BuildContext context, bool isLogin, File? image) submitData;
  final bool isLoading;

  AuthForm(this.submitData, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _username = '';
  var _userPassword = '';
  File? _userImageFile;

  var _isLogin = true;

  void _pickedImage(File image){
    _userImageFile = image;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please pick a image!'),
      backgroundColor: Theme.of(context).errorColor,),);
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitData(
        _userEmail.trim(),
        _userPassword.trim(),
        _username.trim(),
        context,
        _isLogin,
        _userImageFile
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();

    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin) UserImagePicker(_pickedImage),
                  StreamBuilder<String>(
                    stream: bloc.email,
                    builder: (context,snapshot) => TextFormField(
                      onChanged: bloc.emailChanged,
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        errorText:  snapshot.hasError ? '${snapshot.error}' : null
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: true,
                    ),
                  StreamBuilder<String>(
                    stream: bloc.password,
                    builder: (context, snapshot) => TextFormField(
                      onChanged: bloc.passwordChanged,
                      key: const ValueKey('password'),
                      decoration:  InputDecoration(labelText: 'Password',
                          errorText: snapshot.hasError ? '${snapshot.error}' : null),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    StreamBuilder<bool>(
                      stream: bloc.submitCheck,
                      builder: (context, snapshot) => RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Sing up'),
                        onPressed: snapshot.hasData ? _submit : null,
                      ),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
