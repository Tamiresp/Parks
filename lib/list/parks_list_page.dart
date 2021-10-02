import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/header_page.dart';

class ParksListPage extends StatefulWidget {
  ParksListPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  ParkListPageState createState() => ParkListPageState();
}

class ParkListPageState extends State<ParksListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("records");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                List<dynamic> values = snapshot.data!.value;
                values.forEach((values) {
                  lists.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                lists[index]["image"],
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  lists[index]["nome_oficial_equip_urbano"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
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
                    });
              }
              return Center(
                child: CircularProgressIndicator(color: AppColors.defaultColor),
              );
            }));
  }
}

// class ParksListPage extends StatefulWidget {
//   @override
//   State<ParksListPage> createState() => ParkListPageState();
// }

// class ParkListPageState extends State<ParksListPage> {
//   final _database = FirebaseDatabase.instance.reference();
//   //StreamSubscription _listRecords;
//   final List<Parks> parks = parksList;
//   final recordsDao = ParksDao();
//   ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     // _activateListeners();
//   }

//   // void _performSingleFetch() {
//   //   _database.child("records").once().then((snapshot) {
//   //     final data = new Map<String, dynamic>.from(snapshot.value);
//   //     final records = Records.fromRTDB(data);
//   //   });
//   // }

//   // void _activateListeners() {
//   //   _database.child("records").onValue.listen((event) {
//   //     final data = event.snapshot.value;

//   //     setState(() {});
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//           color: Colors.white,
//           margin: EdgeInsets.only(top: 21),
//           child: Column(
//             children: [
//               StreamBuilder(
//                 stream: RecordsStreamPublisher().getRecordsStream(),
//                 builder: (context, snapshot) {
//                   final list = <ListTile>[];

//                   if (snapshot.hasData) {
//                     final records = snapshot.data as List<Records>;

//                     list.addAll(records.map((nextRecord) {
//                       return ListTile(
//                         leading: Icon(Icons.local_cafe),
//                         title: Text(nextRecord.nome_bairro),
//                       );
//                     }));
//                   }
//                   return Expanded(
//                       child: ListView(
//                     children: list,
//                   ));
//                 },
//               ),
//             ],
//           )
//           // ListView.builder(
//           //     padding: const EdgeInsets.all(8),
//           //     itemCount: parks.length,
//           //     itemBuilder: (BuildContext context, int index) {
//           //       return GestureDetector(

//           //         onTap: () {},
//           //       );
//           //     })
//           ),
//     );
//   }

//   // Widget _getRecordsList() {
//   //   return Expanded(
//   //       child: FirebaseAnimatedList(
//   //     controller: _scrollController,
//   //     query: recordsDao.getRecordsQuery(),
//   //     itemBuilder: (context, snapshot, animation, index) {
//   //       final json = snapshot.value as List<Object>;
//   //       return ParkItem(parks: json[index]);
//   //     },
//   //   ));
//   // }
// }
