import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/park_detail_page.dart';
import 'package:parks/list/parks/park_item.dart';
import 'package:parks/util/back_widget.dart';
import 'package:parks/util/title_widget.dart';

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
    final dbRefRecords = dbRef.child("records");
    final dbRefFavorites = dbRef.child("favorites/");
    return Scaffold(
        body: Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 100),
            child: ListView.builder(
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
                })),
        Column(
          children: [
            BackWidget(),
            SizedBox(
              height: 16,
            ),
            TitleWidget("Parques"),
          ],
        ),
      ],
    ));
  }

  navigateToParkDetailPage(
      {required BuildContext context, required Records model}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ParkDetailPage(model)));
  }
}
