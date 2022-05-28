import 'package:intl/intl.dart';

class User {
  final String name;
  final String email;
  final String photo;
  final String createdAt;
  final String updateAt;

  User({
    required this.name,
    required this.email,
    required this.photo,
    required this.createdAt,
    required this.updateAt,
  });

}

// ignore: non_constant_identifier_names
List<User> demo_users = [
  User(name: "kareem", email: "kareem@kareem.com", photo: "http://178.62.201.95/storage/users/1653664889-kareem.png", createdAt: DateFormat.yMMM().format(DateTime(2020, 10)), updateAt: DateFormat.yMMM().format(DateTime(2020, 10))),
  User(name: "kareem", email: "kareem@kareem.com", photo: "http://178.62.201.95/storage/users/1653664889-kareem.png", createdAt: DateFormat.yMMM().format(DateTime(2020, 10)), updateAt: DateFormat.yMMM().format(DateTime(2020, 10))),
];