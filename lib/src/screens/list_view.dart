import 'package:bcredible/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import '../models/business.dart';
import './business_tile.dart';
import '../blocs/business_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login_screen.dart';

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
  bool isLoading = false;

  Future<void> getBussiness() async {
    businessBloc.fetchBusinessDirectly(locationCity).then((results) => {
          setState(() {
            businesss = results;
            isLoading = false;
          }),
          filtered.addAll(results)
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    print('init $locationCity');
    getBussiness();
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ListViews',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          appBar: AppBar(
              title: Text('bCredible'),
              backgroundColor: Color.fromRGBO(0, 209, 189, 100),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  onPressed: () {
                    _logout();
                  },
                ),
              ]
              ),
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
                    child: RefreshIndicator(
                  onRefresh: () async {
                    getBussiness();
                  },
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _buildSearchResults(filtered),
                )),
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

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userID';
    final value = prefs.getString(key) ?? null;
    print('read userID: $value');
  }

  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
      builder: (context) => Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sign in',
          home: Scaffold(
            appBar: AppBar(
              title: Text('bCredible'),
              backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
            body: LoginScreen(),
          ),
        ),
      ))
    );
  }

}
