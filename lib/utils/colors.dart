import 'package:flutter/material.dart';

class MyColors {
  static const Color green = Color(0xFF20C63F); // 20C63F
  static const Color red = Color(0xFFE52B00); // E52B00
  static const Color yellow = Color(0xFFF0B100); // F0B100

  // Gray Scale
  static const Color gray50 = Color(0xFFF2F2F2); // FCFDFD
  static const Color gray100 = Color(0xFFFCFDFD); // F2F2F2
  static const Color gray200 = Color(0xFFDDDDDD); // DDDDDD
  static const Color gray300 = Color(0xFFC9C9C9); // C9C9C9
  static const Color gray400 = Color(0xFFB4B4B4); // B4B4B4
  static const Color gray500 = Color(0xFFA0A0A0); // A0A0A0
  static const Color gray600 = Color(0xFF8C8C8C); // 8C8C8C
  static const Color gray700 = Color(0xFF777777); // 777777
  static const Color gray800 = Color(0xFF636361); // 636361
  static const Color gray850 = Color(0xFF4E4E4C); // 4E4E4C
  static const Color gray900 = Color(0xFF3A3A37); // 3A3A37
  static const Color gray950 = Color(0xFF1F1F1E); // 1F1F1E

  // Background Colors
  static const Color background = gray100;

  // Button Colors
  static const Color button = gray900;
  static const Color buttonText = gray100;

  // Bottom Navigation Bar Colors
  static const Color bottomNavBar = gray100;
  static const Color bottomNavBarSelectedTab = gray900;
  static const Color bottomNavBarSelectedText = gray100;
  static const Color bottomNavBarUnselectedTab = gray500;

  // Text Colors
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray700;

  // Tag Colors
  static const Color tagText = gray100;

  // Card Colors
  static const Color cardBackground = Colors.white;
  static const Color cardBorder = gray200;
  static const Color cardSelectedDate = gray300;
  static const Color cardText = gray850;

  // Border Colors
  static const Color borderColor = gray200;

  // AppBar Colors
  static const Color appBarBackButton = gray50;
  static Color appBarBlur = blur;

  // Blur Colors
  static Color blur = gray900.withOpacity(0.5);

  // Pizza Item Colors
  static Color pizzaItem = blur;
  static Color pizzaItemSelected = green.withOpacity(0.50);
  static Color pizzaItemBorder = green;
  static Color pizzaItemText = gray100.withOpacity(0.75);
  static Color pizzaItemTextSelected = gray100;
  static Color pizzaItemLabelText = gray100;

  // Pizza Sauce Colors
  static const Color tomatoSauce = Color(0xFFB21807);
  static const Color bbqSauce = Color(0xFF551D19);
  static const Color creamSauce = Color(0xFFFCFAF2);
}
