class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  // Create Post from Map
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }
}
