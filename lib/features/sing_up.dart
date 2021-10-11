import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parks/services/social_sign_in.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final textStyleHeader = TextStyle(
      fontSize: 30, fontWeight: FontWeight.w700, color: Colors.orange);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.png"), fit: BoxFit.cover)),
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Login", style: textStyleHeader),
                SizedBox(height: 300),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/vivaRecife.png"),
                SizedBox(height: 40),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.3, 1],
                          colors: [Color(0XFFF58524), Color(0XFFFFC966)]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sigin with Google",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        final provider =
                            Provider.of<SignInProvider>(context, listen: false);
                        provider.googleLogin();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.3, 1],
                          colors: [Color(0XFFF58524), Color(0XFFFFC966)]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sigin with Facebook",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        final provider =
                            Provider.of<SignInProvider>(context, listen: false);
                        provider.fbSignIn();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
