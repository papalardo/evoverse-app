import "package:app/utils/theme/app.palette.dart";
import "package:flutter/material.dart";

class AppThemeData {
  static themeData() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppPalette.PRIMARY,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.primary600,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        selectedColor: Colors.white,
        tileColor: AppPalette.primary600,
        selectedTileColor: Colors.red,
      ),
      scaffoldBackgroundColor: AppPalette.primary800,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppPalette.gray500,
        elevation: 10,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 20),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(size: 20)
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF325071),
          linearTrackColor: Color(0xFFe9ecef)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF325071),
          )
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppPalette.PRIMARY,
        filled: true,
        labelStyle: const TextStyle(
          color: Colors.white
        ),
        focusColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: AppPalette.GRAY),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: AppPalette.GRAY),
          borderRadius: BorderRadius.circular(15),
        )
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(
            color: Colors.white
        ),
      )
  );
}