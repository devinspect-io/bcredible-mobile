import 'package:bcredible/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../blocs/signup_bloc.dart';
import 'package:toast/toast.dart';
import 'home_screen.dart';
import './login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool _checked = false;

  Widget build(context) {
    final bloc = SignUpBloc();
    return Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _addTopMargin(10),
              SvgPicture.asset("assets/images/undraw_welcome.svg",
                height: MediaQuery.of(context).size.height * 0.20),
              _addTopMargin(10),
              textLabel(),
              _addTopMargin(10),
              nameField(bloc),
              _addTopMargin(10),
              emailFied(bloc),
              _addTopMargin(10),
              passwordField(bloc),
              _addTopMargin(10),
              streetField(bloc),
              _addTopMargin(10),
              cityField(bloc),
              // checkBoxes(bloc),
              Container(margin: EdgeInsets.only(top: 25.0)),
              submitButton(bloc, context),
              loginText(context),
              listPageLink(context),
            ],
          ),
        ));
  }

  Widget checkBoxes(bloc) {
    return CheckboxListTile(
      title: Text("title text"),
      value: _checked,
      onChanged: (newValue) { 
        this.setState(() {
          _checked = newValue; 
        }); 
      },
      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
    );
  }

  Widget textLabel() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Create your account',
          style: TextStyle(
            color: Color.fromRGBO(19, 121, 111, 100),
            fontWeight: FontWeight.w500,
            fontSize: 20),
        ));
  }

  Widget emailFied(bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email Address',
              hintStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              errorText: snapshot.error,
              contentPadding: EdgeInsets.all(16),
              //  fillColor: colorSearchBg,
            ));
      },
    );
  }

  Widget passwordField(bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
              obscureText: true,
              onChanged: bloc.changePassword,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Passwords',
                labelText: 'Password',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.all(16),
                //  fillColor: colorSearchBg,
              ));
        });
  }

  Widget cityField(bloc) {
    return StreamBuilder(
        stream: bloc.city,
        builder: (context, snapshot) {
          return TextField(
              obscureText: false,
              onChanged: bloc.changeCity,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'City',
                labelText: 'City',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.all(16),
                //  fillColor: colorSearchBg,
              ));
        });
  }

  Widget streetField(bloc) {
    return StreamBuilder(
        stream: bloc.street,
        builder: (context, snapshot) {
          return TextField(
              obscureText: false,
              onChanged: bloc.changeStreet,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Street',
                labelText: 'Street',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.all(16),
                //  fillColor: colorSearchBg,
              ));
        });
  }

  Widget nameField(bloc) {
    return StreamBuilder(
        stream: bloc.name,
        builder: (context, snapshot) {
          return TextField(
              obscureText: false,
              onChanged: bloc.changeName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.all(16),
              ));
        });
  }

  Widget submitButton(bloc, context) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: StreamBuilder(
                stream: bloc.submitValid,
                builder: (context, snapshot) {
                  return RaisedButton(
                      onPressed: () async {
                        if (snapshot.hasData) {
                          final result = await bloc.submit();
                          if (result) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Provider(
                                      child: MaterialApp(
                                      debugShowCheckedModeBanner: false,
                                        title: 'Sign Up',
                                        home: Scaffold(
                                            appBar: AppBar(
                                                title: Text('bCredible'),
                                                backgroundColor:
                                                    Color.fromRGBO(0, 209, 189, 100)),
                                            body: HomeScreen()),
                                      ),
                                    )
                              )
                            );
                          } else {
                            Toast.show("Something went wrong", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                            return null;
                          }
                        } else {
                          return null;
                        }
                      },
                      child: Text('Submit'),
                      textColor: Color.fromRGBO(255, 255, 255, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.1),
                        side: BorderSide(color: Color.fromRGBO(0, 186, 168, 1))),
                      color: Color.fromRGBO(0, 186, 168, 1.0),
                      disabledColor: Color.fromRGBO(29, 242, 222, 1.0));
                },
              ),
            ),
          ]),
    );
  }

  Widget loginText(context) {
    return Container(
        child: Row(
      children: <Widget>[
        Text('Already have an account?'),
        FlatButton(
          textColor: Colors.blue,
          child: Text(
            'Sign in',
            style: TextStyle(
                color: Color.fromRGBO(0, 209, 189, 100),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                fontSize: 14),
          ),
          onPressed: () {
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
                )));
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  Widget listPageLink(context) {
    return Container(
        child: Row(
      children: <Widget>[
        FlatButton(
          textColor: Colors.blue,
          child: Text(
            'Continue As Guest',
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 189, 100),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Provider(
                      child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                        title: 'Sign Up',
                        home: Scaffold(
                            appBar: AppBar(
                                title: Text('bCredible'),
                                backgroundColor:
                                    Color.fromRGBO(0, 209, 189, 100)),
                            body: HomeScreen()),
                      ),
                    )
              )
            );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }
}
