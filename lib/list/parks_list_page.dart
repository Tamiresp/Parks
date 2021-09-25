import 'package:flutter/material.dart';
import 'package:parks/data/parks_fix_list.dart';
import 'package:parks/list/park_item.dart';

class ParksListPage extends StatelessWidget {
  final List<Parks> parks = parksList;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 21),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: parks.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: ParkItem(parks: parks[index]),
                  onTap: () {},
                );
              })),
    );
  }
}
