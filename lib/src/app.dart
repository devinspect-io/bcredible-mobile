import 'package:bcredible/src/screens/home_screen.dart';
import 'package:bcredible/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'blocs/login_bloc.dart';
import 'screens/signup_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      )
    );
  }
}

// for login
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Log Me In',
//         home: Scaffold(
//             appBar: AppBar(
//                 title: Text('bCredible'),
//                 backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
//             body: LoginScreen()),
//       ),
//     );
//   }
// }
