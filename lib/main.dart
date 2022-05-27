import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/core/routes/routes.dart';

bool logedIn = false;

void main() {
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
