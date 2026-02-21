import 'package:flutter/material.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool _isPasswordHidden = true;
  bool _isPassworconfdHidden = true;


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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "User Name",
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  SizedBox(height: 30),TextFormField(
                    obscureText: _isPasswordHidden,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFCAAF2D),
                    decoration: InputDecoration(
                      hintText: "Password's Confirmation",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFCAAF2D),
                          width: 2,
                        ),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCAAF2D),
                      minimumSize: Size(double.infinity, 50), // عرض كامل
                    ),
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.grey[900], fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        'login',
                      );
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Color(0xFFCAAF2D),fontSize: 12),
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