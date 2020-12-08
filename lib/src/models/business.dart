class Business {
  Object business;
  Object ratings;

  Business({this.business, this.ratings});
  
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
    : business = parsedJson['Business'],
      ratings = parsedJson['Ratings'];
}
