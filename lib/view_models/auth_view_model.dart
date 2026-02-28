import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/data_sources/auth_data_source.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;
  String? token;

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();

    final response = await _authService.register(
      name: name,
      email: email,
      password: password,
    );

    isLoading = false;

    if (response["statusCode"] == 201) {
      token = response["body"]["token"];

      // نخزن التوكن في Hive
      final box = await Hive.openBox("authBox");
      box.put("token", token);

      notifyListeners();
      return true;
    } else {
      errorMessage = response["body"]["message"] ?? "Register failed";
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final response = await _authService.login(email: email, password: password);

    isLoading = false;

    if (response["statusCode"] == 200) {
      token = response["body"]["token"];

      final box = await Hive.openBox("authBox");
      box.put("token", token);

      notifyListeners();
      return true;
    } else {
      errorMessage = response["body"]["message"] ?? "Login failed";
      notifyListeners();
      return false;
    }
  }

  Future<void> loadToken() async {
    final box = await Hive.openBox("authBox");
    token = box.get("token");
  }

  Future<void> logout() async {
    final box = await Hive.openBox("authBox");
    await box.delete("token");
    token = null;
    notifyListeners();
  }
}
