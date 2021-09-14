import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parks/services/facebook_sign.dart';
import 'package:parks/services/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  Color greenColor = Color(0xFF00AF19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          GestureDetector(
            onTap: () {
              FacebookSign().fbSignIn();
            },
            child: Container(
                height: 50.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text('Login with facebook',
                              style: TextStyle(fontFamily: 'Trueno'))),
                    ],
                  ),
                )),
          ),
          Spacer(),
          ElevatedButton.icon(onPressed: () {
             final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
          }, 
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,), 
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity, 50)
          ),
          label: Text('Sigin with Google'))
         
        ]));
  }
}
