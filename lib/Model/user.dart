class User {
  int id;
  String name;
  String email;
  String phone;
  String username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      username: json['username'] as String,
    );
  }
}
