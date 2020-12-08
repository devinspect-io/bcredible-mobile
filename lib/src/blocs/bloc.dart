import 'dart:async';
import '../validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import '../persistence/repository.dart';

class Bloc extends Object with Validators {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  Repository _repository = Repository();
  //Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //combine both stream using observable 
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e,p) => true);

  //Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() async {
    final validEmail = _email.value;
    final validPass = _password.value;
    final resp = await _repository.singInUser(validEmail, validPass);
    return resp;
  }

  dispose() {
    _email.close();
    _password.close();
  }
  
}