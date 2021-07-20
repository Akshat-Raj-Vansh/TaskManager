//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/models/user.dart';
import 'package:taskmanager/data/network_service.dart';
import 'package:taskmanager/data/notification_service.dart';

class Auth with ChangeNotifier {
  final NetworkService api;
  final NotificationService notificationService;
  User user = User(name: '', email: '', id: '', token: '');

  Auth(this.api, this.notificationService);

  bool get isAuth => user.token != '';

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(user));
  }

  Future<bool> signup(String name, String email, String password) async {
    try {
      user = await api.signup(name, email, password);
      await _saveData();
      notifyListeners();
      return true;
    } catch (error) {
      print('AUTH:' + error.toString());
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      user = await api.login(email, password);
      await _saveData();
      notifyListeners();
      return true;
    } catch (error) {
      print('AUTH:' + error.toString());
      return false;
    }
  }

  void profile() async {
    try {
      user = await api.profile(user.token);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void avatar(String filepath) async {
    try {
      await api.avatar(user.token, filepath);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void logout() async {
    try {
      await api.logout(user.token);
      user.delete();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      notifyListeners();
      notificationService.cancelAllNotifications();
    } catch (error) {
      print(error);
    }
  }

  void delete() async {
    try {
      await api.delete(user.token);
      user.delete();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      notifyListeners();
      notificationService.cancelAllNotifications();
    } catch (error) {
      print(error);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    user = User.fromJson(jsonDecode(prefs.getString('userData')));
    if (user.id == null) return false;
    notifyListeners();
    return true;
  }
}
