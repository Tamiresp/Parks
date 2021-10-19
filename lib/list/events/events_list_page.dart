import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/events_data.dart';
import 'package:parks/list/events/event_item.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/search_widget.dart';
import 'package:parks/util/title_widget.dart';

class EventsListPage extends StatefulWidget {
  EventsListPage({Key? key}) : super(key: key);

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("events");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: FutureBuilder(
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
                        final event = Events.fromJson(lists[index]);
                        return GestureDetector(
                          child: EventsItemPage(
                            event: event,
                          ),
                          onTap: () {},
                        );
                      });
                }
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColors.defaultColor),
                );
              }),
        ),
        Column(
          children: [
            TitleWidget("Eventos"),
            SizedBox(
              height: 16,
            ),
            SearchWidget()
          ],
        ),
      ],
    ));
  }
}
