import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parks/util/app_colors.dart';
import 'home_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
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
