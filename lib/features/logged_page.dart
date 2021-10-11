import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/features/settings_page.dart';

class LoggedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: IconButton(icon: Icon(Icons.settings), onPressed: () {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => SettingsPage()));
      },)
    );
  }
}
