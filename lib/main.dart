import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:tiktok/authentication/login_screen.dart';

import 'controllers/routes.dart';
// import 'package:tiktok/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false, initialRoute: "/",
    getPages: Routes.routes,
    // home: const LoginScreen(),
    title: "TikTok Clone",
    // theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    theme: _buildTheme(Brightness.dark),
  ));
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}
