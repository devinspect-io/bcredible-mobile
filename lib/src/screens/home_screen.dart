import 'package:flutter/material.dart';
import './list_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _showInfo = false;
  String _selectedLocation = 'Please choose a location';
  List<String> _locations = ['Please choose a location', 'Islamabad', 'Peshawar'];

  @override
  Widget build(BuildContext context) {
    return _buildHomeScreen(); 
  }

  Container _buildHomeScreen() {
    return Container(
      padding: const EdgeInsets.all(17.0),
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildGettingStarted(),
        ],
      ),
    );
  }

  Container _buildGettingStarted() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/undraw_right_direction.svg",
                height: 330)
            ]
          ),
          _addTopMargin(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select Your Location",
                style: TextStyle(color: Colors.black, fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ]
          ),
          _addTopMargin(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLocationSelect()
            ]
          ),
          _addTopMargin(100),
          _buildGetStartedButton()
        ]
      )
    );
  }


  DropdownButton _buildLocationSelect() {
    return new DropdownButton<String>(
      hint: Text('Please choose a location'),
      items: _locations.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (val) {
        _selectedLocation = val;
        print(_selectedLocation);
        this.setState(() {});
      },
      value: _selectedLocation,
    );
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

  Widget _buildGetStartedButton() {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 320,
            child: RaisedButton(
              color: Color.fromRGBO(0, 186, 168, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.1),
                side: BorderSide(color: Color.fromRGBO(0, 186, 168, 1))
              ),
              onPressed: () {
                if (_selectedLocation != 'Please choose a location' && _selectedLocation != '') {
                  print('button pressed');
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewScreen()),
                  );
                }
              },
              child: const Text('Get Started', style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ),
        ]
      ),
    );
  }
}
