class User {
  int id;
  String username;
  String email;
  String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, Object?> json) {
    final int id = json['id'] as int;
    final String username = json['username'] as String;
    final String email = json['email'] as String;
    final String password = json['password'] as String;

    return User(
      id: id,
      username: username,
      email: email,
      password: password,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, password: $password}';
  }
}
