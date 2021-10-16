import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parks/services/social_sign_in.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<SignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50)),
                label: Text('Sigin with Google')),
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<SignInProvider>(context, listen: false);
                  provider.fbSignIn();
                },
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50)),
                label: Text('Sigin with Facebook'))
          ],
        ),
      );
}
