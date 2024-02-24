class Users {
  final String id;
  final String email;
  final String username;

  Users({
    required this.id,
    required this.email,
    required this.username,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }
}
