import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/header_page.dart';

class ParksListPage extends StatefulWidget {
  ParksListPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  ParkListPageState createState() => ParkListPageState();
}

class ParkListPageState extends State<ParksListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("records");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: dbRef.once(),
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
                    final records = Records.fromJson(lists[index]);
                      return Container(
                        height: 200,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Image.network(
                                records.image,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  records.nomeOficialEquipUrbano,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star_border),
                                    Icon(Icons.star_border),
                                    Icon(Icons.star_border),
                                    Icon(Icons.star_border),
                                    Icon(Icons.star_border),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.favorite_border),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(color: AppColors.defaultColor),
              );
            }));
  }
}