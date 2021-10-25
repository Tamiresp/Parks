import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/park_detail_page.dart';
import 'package:parks/list/parks/park_item.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/app_strings.dart';

class ParksListEventPage extends StatefulWidget {
  ParksListEventPage({Key? key, required this.records}) : super(key: key);
  List<Map<dynamic, dynamic>> records;

  @override
  ParksListEventPageState createState() =>
      ParksListEventPageState(this.records);
}

class ParksListEventPageState extends State<ParksListEventPage> {
  final dbRef = FirebaseDatabase.instance.reference();

  ParksListEventPageState(this.records);

  List<Map<dynamic, dynamic>> records = [];

  @override
  Widget build(BuildContext context) {
    final dbRefFavorites = dbRef.child("favorites/");
    return Scaffold(
        body: Stack(children: [
      Column(
        children: [
          backButton(context),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                final record = Records.fromJson(records[index]);
                return GestureDetector(
                  child: ParkItem(
                    record: record,
                    dbRef: dbRefFavorites,
                  ),
                  onTap: () {
                    navigateToParkDetailPage(context: context, model: record);
                  },
                );
              }),
        ],
      )
    ]));
  }

  navigateToParkDetailPage(
      {required BuildContext context, required Records model}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ParkDetailPage(model)));
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
