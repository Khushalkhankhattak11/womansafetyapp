import 'package:flutter/material.dart';

class TChip {
  TChip._();

  static ChipThemeData lightchipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );

  static ChipThemeData darkchipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );
}
