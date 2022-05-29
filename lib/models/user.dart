import 'dart:convert';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  int id;
  String name;
  String email;
  String? photo;
  String? createdAt;
  String? updateAt;
  String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    this.updateAt,
    this.createdAt,
    required this.token,
  });


  String toJson() {
    return jsonEncode({
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "photo": this.photo,
      "updated_at": this.updateAt,
      "created_at": this.createdAt,
      "token": this.token,
    });
  }

  factory User.fromJson(Map json) {

    return User(
      id: json['id'],
      token: json['token'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updateAt: json['updated_at'],
    );
  }

}