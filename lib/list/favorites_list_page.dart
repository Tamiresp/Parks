import 'package:flutter/material.dart';
import 'package:parks/data/parks_fix_list.dart';

class FavoritesListPage extends StatelessWidget {
  final List<Parks> favorites = favoritesList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 21),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  //child: ParkItem(parks: favorites[index]),
                  onTap: () {},
                );
              })),
    );
  }
}
