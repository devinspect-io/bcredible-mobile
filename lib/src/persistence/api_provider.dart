import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' show Client;
import '../models/business.dart';

class ApiProvider {
  Client client = Client();

  Future<List<Business>> fetchBusinesses(String city) async {
    if (city == null) {
      city = 'islamabad';
    }
    print('Got city $city');
    final _baseUrl = "https://bcredible.herokuapp.com/get-business-by-city/" + city;
    print("baseUrl $_baseUrl");
    final response = await client.get("$_baseUrl"); // Make the network call asynchronously to fetch the data.
    print(response.body.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body)['businesses'] as List).map((i) =>
        Business.fromJson(i)).toList(); //Return decoded response
    } else {
      throw Exception('Failed to load Data');
    }
  }
}