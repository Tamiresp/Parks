import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/parks_data.dart';
 
class ParkItem extends StatefulWidget {
 const ParkItem(
     {Key? key, this.title, required this.record, required this.dbRef})
     : super(key: key);
 final String? title;
 final Records record;
 final DatabaseReference dbRef;
 
 @override
 ParkItemState createState() => ParkItemState(record, dbRef);
}
 
class ParkItemState extends State<ParkItem> {
 final Records record;
 final DatabaseReference dbRef;
 ParkItemState(this.record, this.dbRef);
 
 var isPressed = false;
 
 @override
 void initState() {
   super.initState();
 
   setIsPressed();
 }
 
 @override
 Widget build(BuildContext context) {
   return Container(
     height: 250,
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
                       _deleteFavorite(record);
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
         )
       ],
     ),
   );
 }
 
 void _writeData() {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final User user = _auth.currentUser!;
   final uid = user.uid;
   dbRef.push().set({'id': uid, 'favorite': record.toJson()});
 }
 
 Future<bool> isSameUser() async {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final User user = _auth.currentUser!;
   DataSnapshot snapshot =
       await dbRef.orderByChild("id").equalTo(user.uid).once();
   return snapshot.exists;
 }
 
 Future<void> _deleteFavorite(Records record) async {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final User user = _auth.currentUser!;
   dbRef
       .orderByChild("favorite/id")
       .equalTo(record.id)
       .once()
       .then((DataSnapshot snapshot) {
     Map<dynamic, dynamic> children = snapshot.value;
     children.forEach((key, value) {
       final favorite = Map<String, dynamic>.from(value);
       final id = favorite["id"];
       if (id == user.uid) {
         dbRef.child(key).remove();
       }
     });
   });
 }
 
 Future<bool> existsData() async {
   final isUser = await isSameUser();
   if (isUser) {
     DataSnapshot snapshot =
         await dbRef.orderByChild("favorite/id").equalTo(record.id).once();
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
}
