import 'package:flutter/material.dart';
import 'package:parks/util/app_strings.dart';

import 'app_colors.dart';

class BackWidget extends StatelessWidget {
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [backButton(context)],
      ),
    );
  }

  Widget backButton(BuildContext context) {
    var textStyle = TextStyle(fontSize: 16, color: AppColors.primaryTextColor);

    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryTextColor,
                ),
                label: Text(
                  AppStrings.backButtonText,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}
