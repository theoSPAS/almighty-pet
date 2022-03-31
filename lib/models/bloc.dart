import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:almighty_pet/models/validator.dart';

class Bloc extends Object with Validator implements BaseBloc{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;


  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password => _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck => Rx.combineLatest2(email, password, (a, b) => true);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

abstract class BaseBloc{
  void dispose();
}