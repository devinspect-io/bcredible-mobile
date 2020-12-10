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
  List<Business> businesss = new List<Business>();
  List<Business> filtered = List<Business>();

  @override
  void initState() {
    super.initState();
    print('init $locationCity');
    businessBloc.fetchBusinessDirectly(locationCity).then((results) => {
          setState(() {
            businesss = results;
            filtered = results;
          })
        });
  }

  void filterSearchResults(String query) {
    List<Business> dummySearchList = List<Business>();
    dummySearchList.addAll(businesss);
    if (query.isNotEmpty) {
      List<Business> dummyListData = List<Business>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filtered.clear();
        filtered.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filtered.clear();
        filtered.addAll(businesss);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(filtered.toString());
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
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    // controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search bussiness by name",
                        hintText: "Search bussiness by name",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)))),
                  ),
                ),
                Expanded(
                  child: _buildSearchResults(filtered),
                ),
              ],
            ),
          ),
        ));
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
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    // controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search bussiness by name",
                        hintText: "Search bussiness by name",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)))),
                  ),
                ),
                Expanded(
                  child: _buildSearchResults(data),
                ),
              ],
            ),
          ),
        ));
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
