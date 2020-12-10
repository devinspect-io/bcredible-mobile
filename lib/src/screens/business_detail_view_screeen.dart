import 'dart:math';

import 'package:bcredible/src/screens/rating_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './list_view.dart';
import 'package:toast/toast.dart';
import '../models/business.dart';
import './image_container.dart';
import './image_container_round.dart';
import '../blocs/business_bloc.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final Business business;
  BusinessDetailsScreen({Key key, @required this.business}) : super(key: key);

  @override
  BusinessDetailsScreenState createState() => BusinessDetailsScreenState(business);
}

class BusinessDetailsScreenState extends State<BusinessDetailsScreen>  {
  Business business;
  Business businessNew;
  BusinessDetailsScreenState(this.business);

  @override
  Widget build(BuildContext context) {
    businessBloc.fetchBusiness(business.Id);
    return StreamBuilder(
      stream: businessBloc.resultb,
      builder: (context, AsyncSnapshot<Business> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _addTopMargin(1),
                  _buildBanner(context, snapshot.data.imageUrl),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          snapshot.data.name,
                          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        _buildRatingStars(snapshot.data.avgRating, snapshot.data.totalRatings),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container (
                          width: MediaQuery.of(context).size.width*0.8,
                          child: new Column (
                            children: <Widget>[
                              new Text ( snapshot.data.description != null
                                ? snapshot.data.description
                                : "Lorem Ipsum shop dealer sells Fish", textAlign: TextAlign.left,
                                style: TextStyle( fontWeight: FontWeight.normal, fontSize: 16, color: Color.fromRGBO(43, 43, 43, 100)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column (
                  // ),
                  _buildDetails(context),
                  _divider(),
                  // Divider(
                  //   color: Colors.black,
                  // ),
                  _buildAddReviewButton(context),
                  _buildReviews(snapshot.data),
                ],
              ),
            ));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      });
  }

  _divider() {
    return Row(children: <Widget>[
      Expanded(
        child: Container(width: 90, child: Divider()),
      ),
    ]);
  }

  Widget _buildBanner(BuildContext context, String url) {
    Random random = new Random();
    int randomNumber = random.nextInt(200) + 400; // from 10 upto 99 included
    return ImageContainer(
      height: 200,
      url: business.imageUrl != null
          ? business.imageUrl
          : "https://picsum.photos/${randomNumber}",
    );
  }

  Widget _buildAvatar() {
    Random random = new Random();
    int randomNumber = random.nextInt(90) + 200; // from 10 upto 99 included
    return CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage("https://picsum.photos/${randomNumber}")
    );
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

  Widget _buildRatingStars(double rating, int reviewCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "${rating}",
          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.2),
          direction: Axis.horizontal,
        ),
        Text(
          "${reviewCount} reviews",
          style: TextStyle( fontWeight: FontWeight.normal, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 13);
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: '\nAddress: ',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                new TextSpan(
                    text: '${business.street + ' ' + business.city}',
                    style: style),
                new TextSpan(
                    text: '\n\nPhone: ',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                new TextSpan(
                    text:
                        '${business.phone.length > 0 ? business.phone : '0302-999999'}',
                    style: style),
                new TextSpan(
                    text: '\n\nHours: ',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                new TextSpan(
                    text:
                        '${business.hours != null ? business.hours : '11:00AM to 1:00AM'}',
                    style: style),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddReviewButton(context) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Reviews",
              style: TextStyle( fontWeight: FontWeight.bold,  fontSize: 20),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 30,
              child: RaisedButton(
                color: Color.fromRGBO(0, 186, 168, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.1),
                    side: BorderSide(color: Color.fromRGBO(0, 186, 168, 1))),
                onPressed: () async {
                  var results = await showDialog(
                      context: context, builder: (_) => RatingDialog());
                  if (results != null) {
                    final resp = await businessBloc.submitRating(
                      results['stars'],
                      results['review'],
                      '5fd08b61a8ea89477a623982',
                      business.Id);
                    if (resp) {
                      Toast.show("Thank you!", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      setState(() {});

                      // business.avgRating = business.avgRating * business.totalRatings + results['stars'] /
                      // Navigator.of(context).popUntil(Modal);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           ListViewScreen(locationCity: 'islamabad')),
                      // );
                    }
                  }
                },
                child: const Text('Add Review',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ]
        ),
      )
    );
  }

  Widget _buildReviews(Business business) {
    return Column(
      children: <Widget>[
        ...business.ratings.map((item) {
          return  Column (
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildAvatar(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "\t${item['user_name']}",
                            style: TextStyle( fontWeight: FontWeight.bold,  fontSize: 14),
                          ),
                          _buildReviewRatingStars(item['rating']),
                          Text(
                            "\t${item['comment']}",
                            style: TextStyle( fontWeight: FontWeight.normal, fontSize: 14,  color: Color.fromRGBO(43, 43, 43, 100)),
                          ),
                        ]
                      )
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }


  Widget _buildReviewRatingStars(int rating) {
    return RatingBarIndicator(
      rating: checkDouble(rating),
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 15,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
      direction: Axis.horizontal,
    );
    // return RatingBarIndicator.builder(
  }

  // Widget _buildFavoriteButton(BuildContext context) {
  //   final bloc = BlocProvider.of<FavoriteBloc>(context);

  //   return StreamBuilder<List<Business>>(
  //     stream: bloc.favoritesStream,
  //     initialData: bloc.favorites,
  //     builder: (context, snapshot) {
  //       List<Business> favorites =
  //           (snapshot.connectionState == ConnectionState.waiting)
  //               ? bloc.favorites
  //               : snapshot.data;
  //       bool isFavorite = favorites.contains(restaurant);

  //       return FlatButton.icon(
  //         onPressed: () => bloc.toggleRestaurant(restaurant),
  //         icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
  //         label: Text('Favorite'),
  //         textColor: isFavorite ? Theme.of(context).accentColor : null,
  //       );
  //     },
  //   );
  // }
}
