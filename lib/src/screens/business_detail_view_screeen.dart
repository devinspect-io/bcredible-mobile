import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/business.dart';
import './image_container.dart';
// import '../blocs/bloc_provider.dart';
// import 'package:restaurant_finder/bloc/favorite_bloc.dart';

class BusinessDetailsScreen extends StatelessWidget {
  final Business business;
  const BusinessDetailsScreen({Key key, this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(business.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _addTopMargin(10),
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _addTopMargin(5),
                Text(
                  business.name,
                  style: textTheme.subtitle.copyWith(fontSize: 20),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildRatingStars(business.avgRating),
                    ])
              ],
            ),
          ),
          // Column (
          // ),
          _buildDetails(context),
          Divider(
            color: Colors.black,
          ),
          _buildAddReviewButton(context),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: business.imageUrl != null
          ? business.imageUrl
          : 'https://b.zmtcdn.com/data/pictures/1/16780641/99091045c8222b164a24442de4548b9e.jpg',
    );
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

  Widget _buildRatingStars(double rating) {
    print(rating);
    return RatingBar.builder(
      initialRating: rating,
      minRating: 0,
      itemSize: 18,
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

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 13);
    return Container(
      padding: EdgeInsets.only(left: 6),
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
                    text: ' Address: ',
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
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                color: Color.fromRGBO(0, 186, 168, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.1),
                    side: BorderSide(color: Color.fromRGBO(0, 186, 168, 1))),
                onPressed: () {
                  // if (_selectedLocation != 'Please choose a location' &&
                  //     _selectedLocation != '') {
                  //   print('button pressed');
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => ListViewScreen()),
                  //   );
                  // }
                },
                child: const Text('Add Review',
                    style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
            ),
          ]),
    );
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
