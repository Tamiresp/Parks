import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/park_detail_page.dart';
import 'package:parks/list/parks/park_item.dart';
import 'package:parks/util/app_colors.dart';

class ParksListPage extends StatefulWidget {
  ParksListPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  ParkListPageState createState() => ParkListPageState();
}

class ParkListPageState extends State<ParksListPage> {
  final dbRef = FirebaseDatabase.instance.reference();

  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    final dbRefRecords = dbRef.child("records");
    final dbRefFavorites = dbRef.child("favorites/");
    return Scaffold(
        body: FutureBuilder(
            future: dbRefRecords.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                List<dynamic> values = snapshot.data!.value;

                values.forEach((values) {
                  lists.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      final record = Records.fromJson(lists[index]);
                      return GestureDetector(
                        child: ParkItem(
                          record: record,
                          dbRef: dbRefFavorites,
                        ),
                        onTap: () {
                          navigateToParkDetailPage(
                              context: context, model: record);
                        },
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(color: AppColors.defaultColor),
              );
            }));
  }

  navigateToParkDetailPage(
      {required BuildContext context, required Records model}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ParkDetailPage(model: model)));
  }
}
