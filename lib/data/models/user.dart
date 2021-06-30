//@dart=2.9
import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String token;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.token,
  });

  User.fromJson(Map json)
      : id = json['_id'],
        name = json['name'],
        email = json['email'],
        token = json['token'];

  User.fromRawJson(Map json)
      : id = json['user']['_id'],
        name = json['user']['name'],
        email = json['user']['email'],
        token = json['token'];

  Map toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'token': token,
      };

  delete() => {
        id = '',
        name = '',
        email = '',
        token = '',
      };
}
