import 'dart:convert';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  String name;
  String email;
  String? photo;
  String? createdAt;
  String? updateAt;
  String token;

  User({
    required this.name,
    required this.email,
    required this.photo,
    required this.updateAt,
    required this.createdAt,
    required this.token,
  });


  String toJson() {
    return jsonEncode({
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
      token: json['data']['token'],
      name: json['data']['name'],
      email: json['data']['email'],
      photo: json['data']['photo'],
      createdAt: json['data']['created_at'],
      updateAt: json['data']['updated_at'],
    );
  }

}