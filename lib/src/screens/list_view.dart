import 'package:flutter/material.dart';
import '../models/business.dart';
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
      builder: (context, AsyncSnapshot<Business> snapshot) {
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

  Scaffold _buildListView(Business data) {
    print('got Daaata');
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('bCredible'),
        backgroundColor: Color.fromRGBO(0, 209, 189, 100)
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              child: Text("Go Back!"),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

}

