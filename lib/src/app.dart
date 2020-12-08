import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: Text('bCredible'),
              backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
          body: HomeScreen(),
        ));
  }
}
