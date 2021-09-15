import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/features/home_page.dart';
import 'package:parks/features/sing_up.dart';
import 'package:parks/services/facebook_sign.dart';
import 'package:parks/services/google_sign_in.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/app_strings.dart';
import 'package:parks/util/back_widget.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: Stack(
      children: [
        BackWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 50),
                  child: Text(
                    AppStrings.settingsText,
                    style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                )),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    user.displayName!,
                    style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    user.email!,
                    style: TextStyle(
                        color: AppColors.primaryTextColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
                constraints: BoxConstraints.expand(height: 100),
                color: AppColors.grayBackgroundColor,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: TextButton.icon(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                      
                        provider.logoutGoogle();

                        final providerFacebook = Provider.of<FacebookSignInProvider>(
                            context,
                            listen: false);
                      
                        provider.logoutGoogle();

                        providerFacebook.logoutFacebook();

                        navigateToSignUpPage(context);
                      },
                      icon: Icon(Icons.logout),
                      label: Text(AppStrings.logoutButtonText)),
                )),
          ],
        )
      ],
    ));
  }

  navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }
}
