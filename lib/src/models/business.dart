class Business {
  // ignore: non_constant_identifier_names
  String Id;
  double avgRating;
  List<String> categories;
  String city;
  String name;
  String phone;
  String street;
  List<dynamic> ratings;
  String imageUrl;
  int totalRatings;
  String description;
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
        imageUrl = parsedJson['imageURL'],
        description = parsedJson['description'],
        ratings = parsedJson['ratings'],
        hours = parsedJson['hours'];
}
