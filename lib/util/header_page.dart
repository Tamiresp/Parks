import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/features/settings_page.dart';

class HeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsPage()));
          },
        ));
  }
}
