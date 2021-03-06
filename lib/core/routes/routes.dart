import 'package:flutter/material.dart';
import 'package:ticcket/pages/add_event.dart';
import 'package:ticcket/pages/change_profile.dart';
import 'package:ticcket/pages/main_screen.dart';
import 'package:ticcket/pages/onboarding.dart';
import 'package:ticcket/pages/auth/login.dart';
import 'package:ticcket/pages/auth/signup.dart';
import 'package:ticcket/pages/today_task.dart';

class Routes {
  static const login = "/";
  static const signup = "/signup";
  static const onBoarding = "/onboarding";
  static const home = "/home";
  static const addEvent = "/addEvent";
  static const changeData = "/profile/change";
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
          builder: ((context) => const MainScreen()),
        );
      case Routes.todaysTask:
        return MaterialPageRoute(
          builder: ((context) => const TodaysTaskScreen()),
        );
      case Routes.addEvent:
        return MaterialPageRoute(
          builder: ((context) => const AddEventScreen()),
        );
      case Routes.changeData:
        return MaterialPageRoute(
          builder: ((context) => const ChangeDataScreen()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const MainScreen()),
        );
    }
  }
}
