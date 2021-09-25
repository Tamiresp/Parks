import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parks/data/parks_fix_list.dart';

class EventsItem extends StatefulWidget {
  final Parks event;
  const EventsItem({Key? key, required this.event}) : super(key: key);

  @override
  State<EventsItem> createState() => EventsItemState(event);
}

class EventsItemState extends State<EventsItem> {
  final Parks event;
  EventsItemState(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      color: Colors.white,
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Image(
                width: double.infinity,
                height: 150,
                image: AssetImage(event.image),
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite_border),
              ],
            )
          ],
        ),
      ),
    );
  }
}
