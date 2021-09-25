import 'package:firebase_database/firebase_database.dart';

import 'parks_data.dart';

class ParksDao {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');

  Query getMessageQuery() {
    return _messagesRef;
  }
}
