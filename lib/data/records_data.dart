import 'package:firebase_database/firebase_database.dart';
import 'package:parks/data/parks_data.dart';

class RecordsStreamPublisher {
  final _database = FirebaseDatabase.instance.reference();

  Stream<List<Records>> getRecordsStream() {
    final recordsStream = _database.child('records').onValue;
    final streamTpPublish = recordsStream.map((event) {
      final recordsMap = Map<String, dynamic>.from(event.snapshot.value);
      final recordsList = recordsMap.entries.map((e) {
        return Records.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return recordsList;
    });
    return streamTpPublish;
  }
}
