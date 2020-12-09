import 'package:flutter/material.dart';
import '../models/business.dart';
import './business_tile.dart';
import '../blocs/business_bloc.dart';

class ListViewScreen extends StatefulWidget {
  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    businessBloc.fetchBusinesses();
    return StreamBuilder(
      stream: businessBloc.result,
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
        appBar: AppBar(title: Text('bCredible'), backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
        body: _buildSearchResults(data),
      ),
    );
  }

  Widget _buildSearchResults(List<Business> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final business = results[index];
        return Card(
          margin: EdgeInsets.all(1.5),
          child: InkWell(
            onTap: () {
              print('tapped');
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
