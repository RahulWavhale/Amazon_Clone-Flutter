import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.type});

  Map<String, dynamic> fromApptoDb() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type
    };
  }

  factory User.fromApptoDb(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      address: map['address'] ?? "",
      type: map['type'] ?? "",
    );
  }

  factory User.fromJson(String source) => User.fromApptoDb(jsonDecode(source));
}
