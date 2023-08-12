class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, Object?> json) {
    final int userId = json['userId'] as int;
    final int id = json['id'] as int;
    final String title = json['title'] as String;
    final String body = json['body'] as String;

    return Post(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}
