import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static bool isDarkMode = false;

  static Color get primaryColor => const Color(0xFF1D7CFF);
  static MaterialColor get primarySwatch => const MaterialColor(0xFF1D7CFF, {
    50:Color.fromRGBO(29, 124, 255, .1),
    100:Color.fromRGBO(29, 124, 255, .2),
    200:Color.fromRGBO(29, 124, 255, .3),
    300:Color.fromRGBO(29, 124, 255, .4),
    400:Color.fromRGBO(29, 124, 255, .5),
    500:Color.fromRGBO(29, 124, 255, .6),
    600:Color.fromRGBO(29, 124, 255, .7),
    700:Color.fromRGBO(29, 124, 255, .8),
    800:Color.fromRGBO(29, 124, 255, .9),
    900:Color.fromRGBO(29, 124, 255, 1),
    }
  );
  static Color get accentColor => isDarkMode ? primaryColor : Colors.grey[600]!;
  static Color get bgColor => isDarkMode ? Colors.black : Colors.grey[50]!;

  static ThemeData get getTheme => ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primarySwatch,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
          iconTheme: IconThemeData(
            color: Colors.grey[500],
          ),
          elevation: 0,
          foregroundColor: Colors.grey[600],
        ),
        colorScheme: const ColorScheme.light(),
        backgroundColor: bgColor,
        textTheme: TextTheme(
          displayMedium: GoogleFonts.poppins(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          displaySmall: GoogleFonts.poppins(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          labelMedium: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        scaffoldBackgroundColor: bgColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
      );

  static LinearGradient getLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[300]!,
        color[200]!,
        color[100]!,
      ],
      stops: const [
        0.4,
        0.7,
        0.9,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[400]!,
        color[300]!,
        color[200]!,
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }
}
