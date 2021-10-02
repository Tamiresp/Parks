import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parks/util/header_page.dart';
import 'package:parks/features/sing_up.dart';
import 'package:parks/features/tab_page.dart';
import 'package:parks/util/app_strings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return TabPage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(AppStrings.errorText),
              );
            } else {
              return SignupPage();
            }
          },
        ),
      );
}
