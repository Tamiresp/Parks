class Events {
  final num id;
  final String name;

  Events(
      {required this.id,
      required this.name,});

  Events.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'] ?? 0,
        name =
            data['name'] ?? 'Nome evento';
}
