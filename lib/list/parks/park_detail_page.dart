import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/comment_data.dart';
import 'package:parks/data/events_data.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/parks/map_page.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/back_widget.dart';

class ParkDetailPage extends StatefulWidget {
  const ParkDetailPage(this.model);
  final Records model;
  @override
  ParkDetailPageState createState() => ParkDetailPageState(model);
}

class ParkDetailPageState extends State<ParkDetailPage> {
  ParkDetailPageState(this.model);

  TextEditingController _textFieldController = TextEditingController();

  int rate = 0;

  final Records model;
  final dbRefFavorites =
      FirebaseDatabase.instance.reference().child("favorites/");
  final dbRefEvents = FirebaseDatabase.instance.reference().child("events");
  final dbRefComments =
      FirebaseDatabase.instance.reference().child("comments/");

  var isPressed = false;

  var isStarPressed = false;
  List<Map<dynamic, dynamic>> lists = [];

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
        BackWidget(),
        SizedBox(
          height: 50,
        ),
        Column(
          children: <Widget>[
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            child: Text(model.enderecoEquipUrbano,
                                style: TextStyle(fontSize: 12)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                _navigateToMapPage(
                                    context: context,
                                    latitude: latitude,
                                    longitude: longitude);
                              },
                              icon: Icon(Icons.map))
                        ],
                      ),
                    ],
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
                              " , o parque possui área de " +
                              model.area +
                              " .",
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
                          Text("Eventos",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        child: FutureBuilder(
                            future: dbRefEvents.once(),
                            builder: (context,
                                AsyncSnapshot<DataSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                lists.clear();
                                List<dynamic> values = snapshot.data!.value;

                                values.forEach((values) {
                                  final nextId =
                                      Map<String, dynamic>.from(values);
                                  final recordId = nextId['record_id'];

                                  if (recordId == model.id) {
                                    lists.add(values);
                                  }
                                });

                                if (lists.isNotEmpty) {
                                  return new ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: lists.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final event =
                                            Events.fromJson(lists[index]);
                                        return Container(
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              color: Colors.grey[300]),
                                          child: Text(event.name,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      });
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
                      )
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
                      stream: dbRefComments.orderByKey().onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          lists.clear();

                          if ((snapshot.data! as Event).snapshot.value !=
                              null) {
                            final comments = Map<String, dynamic>.from(
                                (snapshot.data! as Event).snapshot.value);
                            comments.forEach((key, value) {
                              final nextComment =
                                  Map<String, dynamic>.from(value);

                              final id = nextComment['id'];

                              if (id == model.id) {
                                lists.add(nextComment);
                              }
                            });

                            if (lists.isNotEmpty) {
                              return new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: lists.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final comment =
                                        Comments.fromJson(lists[index]);
                                    return Container(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundImage: NetworkImage(
                                                  comment.userImage),
                                            ),
                                            Text(
                                              comment.username,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(Icons.star_border),
                                            Icon(Icons.star_border),
                                            Icon(Icons.star_border),
                                            Icon(Icons.star_border),
                                            Icon(Icons.star_border),
                                          ],
                                        ),
                                        Row(
                                          children: [Text(comment.comment)],
                                        )
                                      ],
                                    ));
                                  });
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
                ],
              ),
            )
          ],
        ),
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

  void _writeData() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
    dbRefFavorites.push().set({'id': uid, 'favorite': model.toJson()});
  }

  void _writeComment(String comment, int rate) {
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
    final isUser = await isSameUser();
    if (isUser) {
      DataSnapshot snapshot = await dbRefFavorites
          .orderByChild("favorite/id")
          .equalTo(model.id)
          .once();
      return snapshot.exists;
    } else {
      return false;
    }
  }

  Future<void> setIsPressed() async {
    final isFavorite = await existsData();
    if (isFavorite) {
      setState(() {
        isPressed = true;
      });
    } else {
      setState(() {
        isPressed = false;
      });
    }
  }

  Future<void> _displayCommentDialog(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(user.displayName!),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: (isStarPressed)
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          rate++;
                          setState(() {
                            isStarPressed = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: (isStarPressed)
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          rate++;
                          setState(() {
                            isStarPressed = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: (isStarPressed)
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          rate++;
                          setState(() {
                            isStarPressed = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: (isStarPressed)
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          rate++;
                          setState(() {
                            isStarPressed = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: (isStarPressed)
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Icon(Icons.star_border),
                        onPressed: () {
                          rate++;
                          setState(() {
                            isStarPressed = true;
                          });
                        },
                      ),
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
}
