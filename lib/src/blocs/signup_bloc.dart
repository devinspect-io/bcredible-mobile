import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';

import '../validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import '../persistence/repository.dart';

class SignUpBloc extends Object with Validators {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _name = new BehaviorSubject<String>();
  final _city = new BehaviorSubject<String>();
  final _street = new BehaviorSubject<String>();

  Repository _repository = Repository();
  //Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get city => _city.stream.transform(validateCity);
  Stream<String> get street => _street.stream.transform(validateStreet);

  //combine both stream using observable
  Stream<bool> get submitValid => Rx.combineLatest5(
      email, password, name, city, street, (e, p, n, c, s) => true);

  //Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeCity => _city.sink.add;
  Function(String) get changeStreet => _street.sink.add;

  submit() async {
    final validEmail = _email.value;
    final validPass = _password.value;
    final validName = _name.value;
    final validCity = _city.value;
    final validStreet = _street.value;
    final resp = await _repository.createUser(
        validName, validCity, validStreet, validEmail, validPass);
    return resp;
  }

  dispose() {
    _email.close();
    _password.close();
    _name.close();
    _street.close();
    _city.close();
  }

  static of(BuildContext context) {}
}
