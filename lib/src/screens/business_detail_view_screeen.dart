import 'package:flutter/material.dart';
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
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  business.name,
                  style: textTheme.subtitle.copyWith(fontSize: 18),
                ),
                Text(
                  business.street,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          // _buildFavoriteButton(context),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: business.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Price: ${business.name}', style: style),
          SizedBox(width: 40),
          Text('Rating: ${business.avgRating}', style: style),
        ],
      ),
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
