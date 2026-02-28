import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/views/auth/register.dart';

import '../../view_models/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isPasswordHidden = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
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

    setState(() {
      isLoading = true;
    });

    final authVM = context.read<AuthViewModel>();
    bool success = await authVM.login(email, password);

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, "home");
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text("Warning", style: TextStyle(color: Colors.white)),
              content: Text(
                "Login Failed",
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
                    "Login",
                    style: TextStyle(
                      color: Color(0xFFCAAF2D),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isPasswordHidden,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
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
                  SizedBox(height: 30),
                  isLoading
                      ? CircularProgressIndicator(color: Color(0xFFCAAF2D))
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCAAF2D),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: _login,
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register",
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
