import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/park_detail_page.dart';
import 'package:parks/list/parks/park_item.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/search_widget.dart';
import 'package:parks/util/title_widget.dart';

class FavoritesListPage extends StatefulWidget {
  FavoritesListPage({Key? key}) : super(key: key);

  @override
  FavoritesListPageState createState() => FavoritesListPageState();
}

class FavoritesListPageState extends State<FavoritesListPage> {
  final dbRef = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> lists = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List<Map<dynamic, dynamic>> lists = [];
    final User user = _auth.currentUser!;
    final dbRefFavorites = dbRef.child("favorites/");

    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: StreamBuilder(
              stream: dbRef.child('favorites').orderByKey().onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if ((snapshot.data! as Event).snapshot.value != null) {
                    final favorites = Map<String, dynamic>.from(
                        (snapshot.data! as Event).snapshot.value);
                    favorites.forEach((key, value) {
                      final nextFavorite = Map<String, dynamic>.from(value);
                      final favorite = nextFavorite['favorite'];
                      final userId = nextFavorite['id'];

                      if (userId == user.uid) {
                        lists.add(favorite);
                      }
                    });

                    if (lists.isNotEmpty) {
                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            final record = Records.fromJson(lists[index]);
                            return GestureDetector(
                              child: ParkItem(
                                record: record,
                                dbRef: dbRefFavorites,
                              ),
                              onTap: () {
                                navigateToParkDetailPage(
                                    context: context, model: record);
                              },
                            );
                          });
                    } else {
                      return new Center(
                        child: Text('Sem favoritos adicionados'),
                      );
                    }
                  } else {
                    return new Center(
                      child: Text('Sem favoritos adicionados'),
                    );
                  }
                }
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColors.defaultColor),
                );
              }),
        ),
        Column(
          children: [
            TitleWidget("Favoritos"),
            SizedBox(
              height: 16,
            ),
            SearchWidget()
          ],
        ),
      ],
    ));
  }

  navigateToParkDetailPage(
      {required BuildContext context, required Records model}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ParkDetailPage(model)));
  }
}
