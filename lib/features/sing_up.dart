import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parks/services/social_sign_in.dart';
import 'package:parks/util/app_colors.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Eventos 3.png"),
            fit: BoxFit.cover,
          ),
        ),
    child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/vivaRecife.png"),
            SizedBox(
                    height: 24,
                  ),
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<SignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.defaultColor,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 50)),
                label: Text('Sigin with Google')),
            SizedBox(
                    height: 8,
                  ),
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<SignInProvider>(context, listen: false);
                  provider.fbSignIn();
                },
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.defaultColor,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 50)),
                label: Text('Sigin with Facebook'))
          ],
        ),
      ),
  );
}
