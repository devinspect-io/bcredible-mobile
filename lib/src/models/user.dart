class User {
  String email;
  String password;
  
  User({this.email, this.password});
  
  User.fromJson(Map<String, dynamic> parsedJson)
    : email = parsedJson['email'],
      password = parsedJson['password'];
}
