import 'dart:convert';
import 'package:flutter/foundation.dart';

class Business {
  String Id;
  double avgRating;
  List<String> categories;
  String city;
  String name;
  String phone;
  String street;
  String imageUrl;
  int totalRatings;
  String hours;

  Business({this.city, this.name});

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  Business.fromJson(Map<String, dynamic> parsedJson)
      : Id = parsedJson['_id'],
        avgRating = parsedJson['avg_rating'],
        categories = List.from(parsedJson['categories']),
        city = parsedJson['city'],
        name = parsedJson['name'],
        phone = parsedJson['phone'],
        street = parsedJson['street'],
        totalRatings = parsedJson['total_ratings'],
        imageUrl = parsedJson['imageUrl'],
        hours = parsedJson['hours'];
}
