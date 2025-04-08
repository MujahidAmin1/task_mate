class User {
  String username;
  String email;
  String id;
  User({required this.email, required this.username, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
