import 'dart:async';

class Validators {
  //first string represent input and other return type which is string
  final validateEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink) {
      if(email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid Email');
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password,sink) {
      if(password.length > 3) {
        sink.add(password);
      } else {
        sink.addError('Password length must be greater than 3');
      }
    }
  );
}