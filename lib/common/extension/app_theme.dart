import 'package:flutter/material.dart';

class AppTheme {
  static get mainTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  static get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );
}
