import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parks/data/comment_data.dart';
import 'package:parks/data/events_data.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/map_page.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/app_strings.dart';

class ParkDetailPage extends StatefulWidget {
  const ParkDetailPage(this.model);
  final Records model;
  @override
  ParkDetailPageState createState() => ParkDetailPageState(model);
}

class ParkDetailPageState extends State<ParkDetailPage> {
  ParkDetailPageState(this.model);

  TextEditingController _textFieldController = TextEditingController();

  double rate = 0.0;

  final Records model;
  final dbRefFavorites =
      FirebaseDatabase.instance.reference().child("favorites/");
  final dbRefEvents = FirebaseDatabase.instance.reference().child("events/");
  final dbRefComments =
      FirebaseDatabase.instance.reference().child("comments/");

  var isPressed = false;

  double average = 0.0;

  List<Map<dynamic, dynamic>> listsComments = [];
  List<Map<dynamic, dynamic>> listsEevents = [];

  List<num> ratings = [];
  List<Records> favorites = [];

  @override
  void initState() {
    super.initState();
    setIsPressed();
  }

  @override
  Widget build(BuildContext context) {
    var latitude = model.latitude.toDouble();
    var longitude = model.longitude.toDouble();

    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              backButton(context),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Image.network(
                  this.model.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          model.nomeOficialEquipUrbano,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: average,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: (isPressed)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border),
                              onPressed: () async {
                                final existData = await existsData();

                                if (existData) {
                                  _deleteFavorite(model);
                                  setState(() {
                                    isPressed = false;
                                  });
                                } else {
                                  _writeData();
                                  setState(() {
                                    isPressed = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        model.enderecoEquipUrbano,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Descrição",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "O " +
                                model.nomeEquipUrbano +
                                " é uma área de lazer da cidade do Recife, localizado no bairro " +
                                model.nomeBairro +
                                ", o parque possui área de " +
                                model.area +
                                ".",
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.justify),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Localização",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MapPage(latitude: latitude, longitude: longitude)
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Eventos",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        StreamBuilder(
                        stream: dbRefEvents
                            .orderByChild("record_id")
                            .equalTo(model.id)
                            .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                listsEevents.clear();

                                if ((snapshot.data! as Event).snapshot.value !=
                                    null) {
                                  final events = Map<String, dynamic>.from(
                                      (snapshot.data! as Event).snapshot.value);
                                  events.forEach((key, value) {
                                    final nextEvent =
                                        Map<String, dynamic>.from(value);

                                    listsEevents.add(nextEvent);
                                  });

                                  if (listsEevents.isNotEmpty) {
                                    return new Container(
                                      height: 40,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: listsEevents.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final event = Events.fromJson(
                                                listsEevents[index]);
                                            return Container(
                                              width: 200,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color:
                                                        AppColors.defaultColor,
                                                    width: 1.0),
                                              ),
                                              child: Text(event.name,
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  SizedBox(
                                                    width: 8,
                                                  )),
                                    );
                                  } else {
                                    return new Center(
                                      child: Text('Sem eventos adicionados'),
                                    );
                                  }
                                } else {
                                  return new Center(
                                    child: Text('Sem eventos adicionados'),
                                  );
                                }
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.defaultColor),
                              );
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Avaliações",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    StreamBuilder(
                        stream: dbRefComments
                            .orderByChild("id")
                            .equalTo(model.id)
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            ratings.clear();
                            listsComments.clear();

                            if ((snapshot.data! as Event).snapshot.value !=
                                null) {
                              final comments = Map<String, dynamic>.from(
                                  (snapshot.data! as Event).snapshot.value);
                              comments.forEach((key, value) {
                                final nextComment =
                                    Map<String, dynamic>.from(value);

                                final rating = nextComment['rate'];

                                listsComments.add(nextComment);
                                ratings.add(rating);
                              });

                              _ratingAverage();

                              if (listsComments.isNotEmpty) {
                                return new Container(
                                  height: 150,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: listsComments.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final comment = Comments.fromJson(
                                            listsComments[index]);

                                        return Container(
                                            height: 50,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundImage:
                                                          NetworkImage(comment
                                                              .userImage),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Text(
                                                      comment.username,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: comment.rate
                                                          .toDouble(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 20.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 34),
                                                      child:
                                                          Text(comment.comment),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ));
                                      }),
                                );
                              } else {
                                return new Center(
                                  child: Text('Sem comentáios adicionados'),
                                );
                              }
                            } else {
                              return new Center(
                                child: Text('Sem comentáios adicionados'),
                              );
                            }
                          }
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColors.defaultColor),
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(height: 8),
              CupertinoButton(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                onPressed: () {
                  _displayCommentDialog(context);
                },
                child: Text(
                  "ADICIONAR COMENTÁRIO",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: AppColors.defaultColor,
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ],
    ));
  }

  void _writeData() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
    dbRefFavorites.push().set({'id': uid, 'favorite': model.toJson()});
  }

  void _writeComment(String comment, double rate) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;

    dbRefComments.push().set({
      'id': model.id,
      'user_name': user.displayName,
      'userImage': user.photoURL,
      'comment': comment,
      'rate': rate
    });
  }

  Future<bool> isSameUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    DataSnapshot snapshot =
        await dbRefFavorites.orderByChild("id").equalTo(user.uid).once();
    return snapshot.exists;
  }

  Future<void> _deleteFavorite(Records record) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    dbRefFavorites
        .orderByChild("favorite/id")
        .equalTo(record.id)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        final favorite = Map<String, dynamic>.from(value);
        final id = favorite["id"];
        if (id == user.uid) {
          dbRefFavorites.child(key).remove();
        }
      });
    });
  }

  Future<bool> existsData() async {
    bool hasFavorite = false;
    favorites.forEach((element) {
      if (element.id == model.id) {
        hasFavorite = true;
      }
    });
    return hasFavorite;
  }

 Future<void> setIsPressed() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    dbRefFavorites
        .orderByChild('id')
        .equalTo(user.uid)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        final favorite = Map<String, dynamic>.from(value);
        final favoriteItem = favorite["favorite"];
        var list = Records.fromJson(favoriteItem);
        favorites.add(list);

        if (list.id == model.id) {
          setState(() {
            isPressed = true;
          });
        }
      });
    });
  }
  Future<void> _displayCommentDialog(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                SizedBox(width: 8),
                Text(
                  user.displayName!,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 40,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          rate = rating;
                          print(rating);
                        },
                      )
                    ],
                  ),
                  TextField(
                      cursorColor: AppColors.defaultColor,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          valueText = value;
                        });
                      },
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: "Adicione um comentário",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.defaultColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.defaultColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.defaultColor),
                        ),
                      )),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoButton(
                color: AppColors.defaultColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    _writeComment(codeDialog, rate);
                    codeDialog = "";
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  var codeDialog;
  var valueText;

  _ratingAverage() {
    average = ratings.reduce((a, b) => a + b) / ratings.length;
  }

  Widget backButton(BuildContext context) {
    var textStyle = TextStyle(fontSize: 16, color: AppColors.primaryTextColor);

    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryTextColor,
                ),
                label: Text(
                  AppStrings.backButtonText,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}
