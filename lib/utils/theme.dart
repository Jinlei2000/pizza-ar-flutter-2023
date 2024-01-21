// theme.dart
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData myTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(background: MyColors.background),
    // set Inter as the default font
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
  );
}
