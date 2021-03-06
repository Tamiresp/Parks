import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parks/data/events_data.dart';
import 'package:parks/data/parks_data.dart';
import 'package:parks/list/events/event_item.dart';
import 'package:parks/list/parks/park_detail_page.dart';
import 'package:parks/util/app_colors.dart';
import 'package:parks/util/search_widget.dart';
import 'package:parks/util/title_widget.dart';

class EventsListPage extends StatefulWidget {
  EventsListPage({Key? key}) : super(key: key);

  @override
  EventsListPageState createState() => EventsListPageState();
}

class EventsListPageState extends State<EventsListPage> {
  final dbRef = FirebaseDatabase.instance.reference().child("events");
  final dbRefRecord = FirebaseDatabase.instance.reference().child("records");
  final dbRefFavorites =
      FirebaseDatabase.instance.reference().child("favorites/");

  List<Map<dynamic, dynamic>> lists = [];
  List<Map<dynamic, dynamic>> records = [];

  TextEditingController controller = new TextEditingController();
  List<Events> _searchResult = [];
  List<Events> _eventList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 100),
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = _searchResult[index];

                      return GestureDetector(
                        child: EventsItemPage(
                          event: event,
                        ),
                        onTap: () {
                          _getRecord(event);
                        },
                      );
                    })
                : new StreamBuilder(
                    stream: dbRef.onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        lists.clear();
                        _eventList.clear();

                        if ((snapshot.data! as Event).snapshot.value != null) {
                          final events = Map<String, dynamic>.from(
                              (snapshot.data! as Event).snapshot.value);
                          events.forEach((key, value) {
                            final nextComment =
                                Map<String, dynamic>.from(value);

                            lists.add(nextComment);
                          });

                          return new ListView.builder(
                              shrinkWrap: true,
                              itemCount: lists.length,
                              itemBuilder: (BuildContext context, int index) {
                                final event = Events.fromJson(lists[index]);
                                _eventList.add(event);
                                return GestureDetector(
                                  child: EventsItemPage(
                                    event: event,
                                  ),
                                  onTap: () {
                                    _getRecord(event);
                                  },
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
                    })),
        Column(
          children: [
            TitleWidget("Eventos"),
            SizedBox(
              height: 16,
            ),
            _createSearch()
          ],
        ),
      ],
    ));
  }

  _navigateToParkListPage(
      {required BuildContext context, required Records records}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ParkDetailPage(records)));
  }

  _getRecord(Events event) {
    dbRefRecord
        .orderByChild('id')
        .equalTo(event.recordId)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        final favorites = Map<String, dynamic>.from(snapshot.value);

        var record;
        favorites.forEach((key, value) {
          record = Records.fromJson(value);
        });
        _navigateToParkListPage(context: context, records: record);
      }
    });
  }

  Widget _createSearch() {
    return SearchWidget(controller, onSearchTextChanged);
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _eventList.forEach((event) {
      if (event.name.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(event);
      }
    });

    setState(() {});
  }
}
