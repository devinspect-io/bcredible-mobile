import 'package:flutter/material.dart';
import '../models/business.dart';
import './business_tile.dart';
import '../blocs/business_bloc.dart';

class ListViewScreen extends StatefulWidget {
  final String locationCity;
  ListViewScreen({Key key, @required this.locationCity}) : super(key: key);

  @override
  ListScreenState createState() => ListScreenState(locationCity);
}

class ListScreenState extends State<ListViewScreen> {
  String locationCity;
  ListScreenState(this.locationCity);

  @override
  Widget build(BuildContext context) {
    businessBloc.fetchBusinesses(locationCity);
    return StreamBuilder(
        stream: businessBloc.businessStream,
        builder: (context, AsyncSnapshot<List<Business>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return _buildListView(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  MaterialApp _buildListView(List<Business> data) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: Text('bCredible'),
            backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search Business',
                ),
                onChanged: (query) {
                  if (query != null) {
                    var filteredArray = [];
                    for (int i = 0; i < data.length; i++) {
                      if (data[i]
                          .name
                          .toLowerCase()
                          .contains(query.toLowerCase())) {
                        filteredArray.add(data[i]);
                      }
                    }
                    print(filteredArray.toString());
                    setState(() {
                      data = filteredArray;
                    });
                    // _buildSearchResults(filteredArray);
                    // businessBloc.submitQuery(query);
                  }
                },
              ),
            ),
            Expanded(
              child: _buildSearchResults(data),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Business> results) {
    print(results.toString());
    return ListView.builder(
      key: UniqueKey(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final business = results[index];
        return Card(
          margin: EdgeInsets.all(1.5),
          child: InkWell(
            onTap: () {
              // print('tapped');
            },
            child: Padding(
              padding: const EdgeInsets.all(0.2),
              child: BusinessTile(business: business),
            ),
          ),
        );
      },
    );
  }
}
