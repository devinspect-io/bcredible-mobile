class Rating {
  int stars;
  String comment;

  Rating({this.stars, this.comment});

  Rating.fromJson(Map<String, dynamic> parsedJson)
      : stars = parsedJson['stars'],
        comment = parsedJson['comment'];
}
