import 'package:auth_task/Screens/login/login.dart';
import 'package:auth_task/Screens/register/register.dart';
import 'package:flutter/material.dart';
import 'Screens/homepage.dart';
// import 'Screens/login_or_signup.dart';

class RouteGenerator {
  static const String homepage = "homepage";
  static const String loginOrRigister = "loginOrRigiser";
  static const String login = "login";
  static const String register = "Rigister";

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteGenerator.homepage:
        return MaterialPageRoute(builder: (_) => const Home());
      case RouteGenerator.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case RouteGenerator.register:
        return MaterialPageRoute(builder: (_) => const Register());

      /*  case RouteGenerator.loginOrRigister:
        return MaterialPageRoute(builder: (_) => const LoginOrRegister());
*/
      default:
        // if didn't have any route we dont't sent it  its go to  undefinedRoute
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("NOT FOUND"),
        ),
      ),
    );
  }
}
