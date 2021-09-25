import 'package:flutter/material.dart';
import 'package:parks/data/parks_fix_list.dart';
import 'package:parks/list/events_item.dart';

class EventsListPage extends StatelessWidget {
  final List<Parks> events = eventsList;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 21),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: EventsItem(event: events[index]),
                  onTap: () {},
                );
              })),
    );
  }
}
