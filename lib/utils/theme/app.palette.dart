import "package:flutter/material.dart";

class AppPalette {
  static const PRIMARY = Color(0xFF325071);
  static const primary400 = Color(0xFF325071);
  static const primary600 = Color(0xFF272f3b);
  static const primary800 = Color(0xFF151821);
  static const BACKGROUND = Color(0xFF070d14);
  static const BROWN = Color(0xFF353535);
  static const DANGER = Color(0xFFFF0000);
  static const GRAY = Color(0xFF818181);
  static const gray600 = Color(0xFF272f3b);
  static const gray500 = Color(0xFF272f3b);
  static const gray300 = Color(0xFF707070);
  static const gray400 = Color(0xFF737373);
  static const green400 = Color(0xFF0dff13);

  // Rarities
  static const legendary = Color(0xFFf6b91d);
  static const epic = Color(0xFFaa2ed5);
  static const rare = Color(0xFF72c403);
  static const common = Color(0xFF979797);

  static Color byRarity(String rarity) {
    switch(rarity.toLowerCase()) {
      case "legendary": return legendary;
      case "epic": return epic;
      case "rare": return rare;
      case "common":
      default:
        return common;
    }
  }
}