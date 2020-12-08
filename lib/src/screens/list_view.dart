import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/business.dart';
import './business_detail_view_screeen.dart';
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

  Scaffold _buildListView(List<Business> data) {
    print('got Daata');
    print(data.length);
    return Scaffold(
      appBar: AppBar(
          title: Text('bCredible'),
          backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildSearchResults(data),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Business> results) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final business = results[index];
        return tileBox(business);
      },
    );
  }

  Widget tileBox(Business business) {
    // final Business business;
    // const tileBox({Key key, this.business}) : super(key: key);
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 1, top: 0, right: 1, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(0, 209, 189, 100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(16.0),
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
                            fontSize: 20.0),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        business.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                _addTopMargin(30),
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
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }
}
