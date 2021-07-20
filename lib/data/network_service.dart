//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:taskmanager/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:taskmanager/data/models/task.dart';
import 'package:taskmanager/data/models/user.dart';

class NetworkService {
  Future<List<dynamic>> fetchTask(String token) async {
    final url = URL + '/tasks';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      return jsonDecode(response.body) as List;
    } catch (error) {
      return [];
    }
  }

  Future<Task> createTask(Task task, String token) async {
    final url = Uri.parse(URL + '/tasks');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'title': task.title,
            'description': task.description,
            'completed': task.completed,
            'date': task.date.toString(),
          },
        ),
      );
      return Task.fromRawJson(jsonDecode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<Task> updateTask(Task task, String token) async {
    final url = Uri.parse(URL + '/tasks/${task.id}');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': task.title,
          'description': task.description,
          'completed': task.completed,
          'date': task.date.toString(),
        }),
      );
      return Task.fromRawJson(jsonDecode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteTask(String id, String token) async {
    final url = URL + '/tasks/$id';
    try {
      await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      throw error;
    }
  }

  Future<User> profile(String token) async {
    final url = Uri.parse(URL + '/users/me');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      return User.fromRawJson(jsonDecode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> avatar(String token, String filepath) async {
    // var bytes = image.readAsBytesSync();
    final url = Uri.parse(URL + '/users/me/avatar');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'image/png',
          'Authorization': token,
        },
        body: {"avatar": filepath},
      );
      // encoding: Encoding.getByName("utf-8"));

      // return User.fromRawJson(jsonDecode(response.body));
      print(response.body);
      return response.body;
    } catch (error) {
      throw (error);
    }
  }

  Future<User> signup(String name, String email, String password) async {
    final url = Uri.parse(URL + '/users');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      return User.fromRawJson(jsonDecode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<User> login(String email, String password) async {
    final url = Uri.parse(URL + '/users/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      return User.fromRawJson(jsonDecode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> delete(String token) async {
    final url = URL + '/users/me';
    try {
      await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      throw (error);
    }
  }

  Future<void> logout(String token) async {
    final url = URL + '/users/logout';
    try {
      await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      throw (error);
    }
  }
}
