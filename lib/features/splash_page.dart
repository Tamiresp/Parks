import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parks/features/home_page.dart';
import 'package:parks/features/login_page.dart';
import 'package:parks/services/facebook_sign.dart';
import 'package:parks/util/app_colors.dart';
import '../main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_) {
      _initializeFirebase();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  Future _initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.defaultColor,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            child: Image.asset("images/icon_splash.png"),
          ),
        ));
  }
}
