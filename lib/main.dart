import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/core/routes/routes.dart';
import 'services/user_controller.dart';

bool logedIn = false;
String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var t = await pref.getString("object");
  // print(t);
  if(t != null) {
    token = jsonDecode(t)['token'];
    var u = await UserController.getUserData(token ?? "");
    logedIn = (u == null) ? false : true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        initialRoute: logedIn ? Routes.home : Routes.login,
        onGenerateRoute: RouterGenerator.generateRoutes,
      );
    });
  }
}
