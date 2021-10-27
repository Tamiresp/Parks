import 'package:flutter/material.dart';
import 'package:parks/data/events_data.dart';

class EventsItemPage extends StatefulWidget {
  const EventsItemPage({Key? key, this.title, required this.event})
      : super(key: key);
  final String? title;
  final Events event;

  @override
  EventItemPageState createState() => EventItemPageState(event);
}

class EventItemPageState extends State<EventsItemPage> {
  final Events event;
  EventItemPageState(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.white,
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    event.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    event.date,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
