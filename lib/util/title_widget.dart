import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/features/settings_page.dart';

class TitleWidget extends StatelessWidget {
  String title;
  TitleWidget(this.title);
  Widget _createTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.account_circle_outlined),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createTitle(context, title);
  }
}
