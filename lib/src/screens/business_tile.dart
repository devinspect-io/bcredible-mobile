import 'package:flutter/material.dart';
import '../models/business.dart';
import './business_detail_view_screeen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BusinessTile extends StatelessWidget {
  final Business business;
  const BusinessTile({Key key, @required this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(0, 209, 189, 10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        business.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 2, right: 10, bottom: 2),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(224, 224, 224, 100),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4)),
                        ),
                        child: Text(
                          business.categories[0],
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                _addTopMargin(3),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Lorem Ipsum shop dealer sells Fish",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                _addTopMargin(5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Reviews: 10",
                        style: TextStyle(
                            color: Color.fromRGBO(10, 10, 0, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 5, top: 2, right: 5, bottom: 2),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(224, 224, 224, 100),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4)),
                          ),
                          child: _buildRatingStars(2)),
                    ])
              ])),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BusinessDetailsScreen(business: business),
          ),
        );
        print("tapped on container");
      },
    );
    ;
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

  Widget _buildRatingStars(double rating) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
