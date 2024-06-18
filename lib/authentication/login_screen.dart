import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tiktok/customs/customcolors.dart';
import 'package:tiktok/customs/customtext.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _emailErrorText;
  bool _obsureText = true;
  bool circularprogress = false;

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obsureText = !_obsureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "images/tiktoklogo.png",
                    width: 180,
                  ),
                  const CustomText(
                    label: "Welcome!",
                    fontsize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    label: "login here",
                    fontWeight: FontWeight.w400,
                    fontsize: 20,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      hintText: "email",
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!isEmailValid(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _emailErrorText = null;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: _obsureText,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: whitecolor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: bluecolor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: whitecolor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: bluecolor),
                      ),
                      hintText: "password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obsureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 4) {
                        return 'Password must be at least 4 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  circularprogress
                      ? const SpinKitCircle(
                          duration: Duration(milliseconds: 1800),
                          color: pinkcolor,
                          size: 50.0,
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: signin,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: whitecolor,
                                backgroundColor: pinkcolor, // Text color
                                minimumSize:
                                    Size(double.infinity, 50), // Button size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25), // Rounded corners
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 5, // Shadow elevation
                              ),
                              child: const Text('LOGIN'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const CustomText(
                                    label: "Don't have an account?",
                                    fontsize: 14,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed("/register");
                                    },
                                    child: const CustomText(
                                      label: "SIGN UP",
                                      fontWeight: FontWeight.bold,
                                      fontsize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signin() async {
    if (!_formKey.currentState!.validate()) {
      return; // Form is not valid, don't proceed
    }

    setState(() {
      circularprogress = true;
    });

    final url =
        "https://nattiee.com/TiktokFolder/login.php?email=${email.text.trim()}&password=${password.text.trim()}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final serverResponse = json.decode(response.body);
        final loginSuccess = serverResponse['success'];
        if (loginSuccess == 1) {
          Get.toNamed("/homepage");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFFFE2C55),
              content: Text('Login Error: Invalid email or password'),
              duration: Duration(seconds: 4),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFFFE2C55),
            content: Text('Error: ${response.statusCode}'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFFFE2C55),
          content: Text('Error: $e'),
          duration: Duration(seconds: 4),
        ),
      );
    } finally {
      setState(() {
        circularprogress = false;
      });
    }
  }
}
