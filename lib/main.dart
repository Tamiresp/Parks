import 'package:flutter/material.dart';
import 'package:parks/features/splash_page.dart';
import 'package:parks/services/facebook_sign.dart';
import 'package:parks/services/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (context) => FacebookSignInProvider()),
    ], child: MaterialApp(home: Splash()));
  }
}
