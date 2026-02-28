import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool _isPasswordHidden = true;
  bool _isPassworconfdHidden = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final String baseUrl = "https://todo-backend-oob0.onrender.com";

  bool isLoading = false;

  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text("Warning", style: TextStyle(color: Colors.white)),
              content: Text(
                "Please fill all fields",
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.yellow[700]),
                  ),
                ),
              ],
            ),
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text("Warning", style: TextStyle(color: Colors.white)),
              content: Text(
                "Passwords do not match",
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.yellow[700]),
                  ),
                ),
              ],
            ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      if (res.statusCode == 201) {
        // تسجيل ناجح
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration successful! Please login.",
              style: TextStyle(color: Color(0xFFCAAF2D)),
            ),
          ),
        );
      } else {
        // خطأ من السيرفر
        final data = jsonDecode(res.body);
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                backgroundColor: Colors.grey[900],
                title: Text("Error", style: TextStyle(color: Colors.white)),
                content: Text(
                  data['message'] ?? "Registration failed",
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.yellow[700]),
                    ),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text("Error", style: TextStyle(color: Colors.white)),
              content: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.yellow[700]),
                  ),
                ),
              ],
            ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text("<<To Do>>"),
        ),
        titleTextStyle: TextStyle(
          color: Color(0xFFCAAF2D),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFCAAF2D),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFFCAAF2D),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isPasswordHidden,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _isPassworconfdHidden,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPassworconfdHidden = !_isPassworconfdHidden;
                          });
                        },
                        icon: Icon(
                          _isPassworconfdHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  isLoading
                      ? CircularProgressIndicator(color: Color(0xFFCAAF2D))
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCAAF2D),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: registerUser,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                          ),
                        ),
                      ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, 'login');
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Color(0xFFCAAF2D), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
