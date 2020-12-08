import 'dart:async';

class Validators {
  //first string represent input and other return type which is string
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid Email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Password length must be greater than 3');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (RegExp('[a-zA-Z]').hasMatch(name)) {
      sink.add(name);
    } else {
      sink.addError('Name should contain only alphabets and space');
    }
  });

  final validateCity =
      StreamTransformer<String, String>.fromHandlers(handleData: (city, sink) {
    if (city.length > 0) {
      sink.add(city);
    } else {
      sink.addError('City Name is Required');
    }
  });

  final validateStreet = StreamTransformer<String, String>.fromHandlers(
      handleData: (street, sink) {
    if (street.length > 0) {
      sink.add(street);
    } else {
      sink.addError('Street Address is Required');
    }
  });
}
