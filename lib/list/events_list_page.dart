import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/util/app_colors.dart';

class EventsListPage extends StatefulWidget {
  EventsListPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("events");
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
                      return Container(
                          height: 50,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Text(
                            lists[index]["name"],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          ));
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.defaultColor,
                ),
              );
            }));
  }
}
