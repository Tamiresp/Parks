
class Comments {
  final num id;
  final num rate;
  final String comment;
  final String username;
  final String userImage;

  Comments(
      {required this.id,
      required this.rate,
      required this.comment,
      required this.username, 
      required this.userImage});

  Comments.fromJson(Map<dynamic, dynamic> data)
      : id = data['id'] ?? 0,
        rate = data['rate'] ?? 0.0,
        comment = data['comment'] ?? 'comentário',
        username = data['user_name'] ?? 'hhhh',
        userImage = data['userImage'];
}
