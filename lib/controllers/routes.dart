import 'package:get/route_manager.dart';
import 'package:tiktok/authentication/login_screen.dart';
import 'package:tiktok/authentication/registration_screen.dart';
import 'package:tiktok/homepage.dart';

class Routes {
  static var routes = [
    GetPage(name: "/", page: () => const LoginScreen()),
    GetPage(name: "/homepage", page: () => const Homepage()),
    GetPage(name: "/register", page: () => const RegistrationScreen())
  ];
}
