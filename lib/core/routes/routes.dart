import 'package:flutter/material.dart';
import 'package:ticcket/pages/home.dart';
import 'package:ticcket/pages/onboarding.dart';
import 'package:ticcket/pages/auth/login.dart';
import 'package:ticcket/pages/auth/signup.dart';
import 'package:ticcket/pages/today_task.dart';

class Routes {
  static const login = "/login";
  static const signup = "/signup";
  static const onBoarding = "/";
  static const home = "/home";
  static const todaysTask = "/task/todays";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: ((context) => const LoginScreen())
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: ((context) => const SignUpScreen())
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: ((context) => const OnboardingScreen()),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case Routes.todaysTask:
        return MaterialPageRoute(
          builder: ((context) => const TodaysTaskScreen()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
    }
  }
}
