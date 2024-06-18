import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/imagepick_controller.dart';
import 'package:tiktok/customs/customtext.dart';
import 'package:http/http.dart' as http;

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController username = TextEditingController();
ImagepickController controller = Get.put(ImagepickController());

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    // bool circularprogress = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "images/tiktoklogo.png",
                    width: 60,
                  ),
                  const CustomText(
                    label: "Thanks for Joining",
                    fontsize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    label: "Create Your Account",
                    fontWeight: FontWeight.w400,
                    fontsize: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: controller.galleryImage,
                    child: CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: Image.asset(
                        "images/profile.png",
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: username,
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
                      hintText: "username",
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username is required';
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
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: serverSignup,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFFE2C55), // Text color
                          minimumSize:
                              const Size(double.infinity, 50), // Button size
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25), // Rounded corners
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 5, // Shadow elevation
                        ),
                        child: const Text('SIGN UP'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            const CustomText(
                              label: "Do you have an account?",
                              fontsize: 14,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed("/");
                              },
                              child: const CustomText(
                                label: "LOGIN",
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

  Future<void> serverSignup() async {
    http.Response response;
    var body = {
      'username': username.text.trim(),
      'email': email.text.trim(),
      'password': password.text.trim(),
    };
    response = await http.post(
        Uri.parse("https://nattiee.com/TiktokFolder/register.php"),
        body: body);
    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      int signedUp = serverResponse['success'];
      if (signedUp == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('SignUp'),
              content: Text("SignUp successful!"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      Get.toNamed("/login");
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
