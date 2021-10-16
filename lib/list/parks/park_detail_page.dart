import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/map_page.dart';
import 'package:parks/util/back_widget.dart';

class ParkDetailPage extends StatelessWidget {
  ParkDetailPage({required this.model});
  final Records model;

  @override
  Widget build(BuildContext context) {
    var latitude = model.latitude.toDouble();
    var longitude = model.longitude.toDouble();

    return Scaffold(
        body: Stack(
      children: [
        BackWidget(),
        SizedBox(
          height: 20,
        ),
        Positioned(
            left: 16,
            right: 16,
            top: 150,
            child: IconButton(
                onPressed: () {
                  _navigateToMapPage(
                      context: context,
                      latitude: latitude,
                      longitude: longitude);
                },
                icon: Icon(Icons.map)))
      ],
    ));
  }

  _navigateToMapPage(
      {required BuildContext context,
      required double latitude,
      required double longitude}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            MapPage(latitude: latitude, longitude: longitude)));
  }
}
