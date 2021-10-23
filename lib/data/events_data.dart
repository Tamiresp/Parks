class Events {
  final num id;
  final num recordId;
  final String name;

  Events(
      {required this.id,
      required this.recordId,
      required this.name,});

  Events.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'] ?? 0,
      recordId = data['record_id'] ?? 0,
        name =
            data['name'] ?? 'Nome evento';
}
