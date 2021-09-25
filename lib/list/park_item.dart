import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parks/data/parks_fix_list.dart';

class ParkItem extends StatefulWidget {
  final Parks parks;
  const ParkItem({Key? key, required this.parks}) : super(key: key);

  @override
  State<ParkItem> createState() => ParkItemState(parks);
}

class ParkItemState extends State<ParkItem> {
  final Parks parks;
  ParkItemState(this.parks);

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
            child: Image(
              width: double.infinity,
              height: 150,
              image: AssetImage(parks.image),
              fit: BoxFit.fitWidth,
            ),
          ),
          Row(
            children: [
              Text(
                parks.name,
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
