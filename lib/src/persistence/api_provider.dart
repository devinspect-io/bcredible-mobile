import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/business.dart';
import '../models/user.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = "https://bcredible.herokuapp.com";

  Future<List<Business>> fetchBusinesses(String city) async {
    if (city == null) {
      city = 'islamabad';
    }
    print('Got city $city');
    final _url = _baseUrl + "/get-business-by-city/" + city;
    print("baseUrl $_url");
    final response = await client.get(
        "$_url"); // Make the network call asynchronously to fetch the data.
    print(response.body.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body)['businesses'] as List)
          .map((i) => Business.fromJson(i))
          .toList(); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<bool> singInUser(String email, String password) async {
    final _url = _baseUrl + "/login";
    print("baseUrl $_url $email $password");
    Map data = {'email': email, 'password': password};
    var body = json.encode(data);
    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: body); // Make the network call asynchronously to fetch the data.
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
      // return json.decode(response.body); //Return decoded response
    } else {
      return false;
    }
  }

  Future<bool> createUser(String email, String password) async {
    final _url = _baseUrl + "/signup";
    print("baseUrl $_url $email $password");
    Map data = {'email': email, 'password': password};
    var body = json.encode(data);
    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: body); // Make the network call asynchronously to fetch the data.
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
      // return json.decode(response.body); //Return decoded response
    } else {
      return false;
    }
  }
}
