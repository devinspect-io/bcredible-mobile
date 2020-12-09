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
    city = city.toLowerCase();
    final _url = _baseUrl + "/get-business-by-city/" + city;
    final response = await client.get(
        "$_url"); // Make the network call asynchronously to fetch the data.
    if (response.statusCode == 200) {
      return (json.decode(response.body)['businesses'] as List)
          .map((i) => Business.fromJson(i))
          .toList(); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<Business> fetchBusiness(String id) async {
    final _url = _baseUrl + "/business/" + id;
    final response = await client.get("$_url");
    if (response.statusCode == 200) {
      return Business.fromJson(json.decode(response.body)['business']);
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
    } else {
      return false;
    }
  }

  Future<bool> createUser(String name, String city, String street, String email,
      String password, List<String> categories) async {
    final _url = _baseUrl + "/user";
    print("baseUrl $_url $email $password $categories");
    Map data = {
      'name': name,
      'city': city,
      'street': street,
      'email': email,
      'password': password,
      'categories': categories,
    };
    var body = json.encode(data);
    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: body); // Make the network call asynchronously to fetch the data.
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createRating(
      int stars, String review, String userId, String businessId) async {
    final _url = _baseUrl + "/rating";
    Map data = {
      'user': userId,
      'business': businessId,
      'comment': review,
      'rating': stars,
    };
    var body = json.encode(data);
    final response = await client.post("$_url",
        headers: {"Content-Type": "application/json"},
        body: body); // Make the network call asynchronously to fetch the data.
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }
}
