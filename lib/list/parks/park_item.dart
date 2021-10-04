import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';

class ParkItem extends StatefulWidget {
  const ParkItem({Key? key, this.title, required this.record})
      : super(key: key);
  final String? title;
  final Records record;

  @override
  ParkItemState createState() => ParkItemState(record);
}

class ParkItemState extends State<ParkItem> {
  final Records record;
  ParkItemState(this.record);

  @override
  Widget build(BuildContext context) {
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
              this.record.image,
              width: double.infinity,
              height: 150,
              fit: BoxFit.fitWidth,
            ),
          ),
          Row(
            children: [
              Text(
                record.nomeOficialEquipUrbano,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
  }
}
