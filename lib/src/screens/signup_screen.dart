import 'package:flutter/material.dart';
import '../blocs/signup_bloc.dart';
import 'package:toast/toast.dart';
import 'list_view.dart';

class SingUpScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = SignUpBloc();
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _addTopMargin(10),
          textLabel(),
          _addTopMargin(10),
          emailFied(bloc),
          _addTopMargin(10),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(bloc)
        ],
      ),
    );
  }

  Widget textLabel() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Color.fromRGBO(0, 209, 189, 100),
              fontWeight: FontWeight.w500,
              fontSize: 30),
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

  Widget submitButton(bloc) {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: StreamBuilder(
                stream: bloc.submitValid,
                builder: (context, snapshot) {
                  return RaisedButton(
                      onPressed: () async {
                        if (snapshot.hasData) {
                          final result = await bloc.submit();
                          if (result) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListViewScreen()));
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
                      color: Color.fromRGBO(0, 186, 168, 1.0),
                      disabledColor: Color.fromRGBO(29, 242, 222, 1.0));
                },
              ),
            ),
          ]),
    );
  }
// 29, 242, 222

  Container _addTopMargin(double x) {
    return Container(height: x);
  }
}
