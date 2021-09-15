import 'package:flutter/material.dart';
import 'package:parks/features/splash_page.dart';
import 'package:parks/services/social_sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        child: MaterialApp(home: Splash()),
      );
}
