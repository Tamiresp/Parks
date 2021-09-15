import 'package:flutter/material.dart';
import 'package:parks/util/app_strings.dart';

import 'app_colors.dart';

class BackWidget extends StatelessWidget {
  
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backButton(context)
        ],
      ),
    );
  }

  Widget backButton(BuildContext context) {
    var textStyle = TextStyle(
        fontSize: 16,
        color: AppColors.primaryTextColor);

    return Container(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            IconButton(
                color: AppColors.primaryTextColor,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                }),
            Text(
              AppStrings.backButtonText,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
