import 'package:flutter/material.dart';

class Palette {
  static const Map<String, Map<String, Map<String, int>>> palette = {
    'light': {
      'text': {
        'primary': 0xFF333333,
        'secondary': 0xFF535353,
        'disabled': 0xFF696A6F,
        'white': 0xFFFFFFFF,
        "black": 0xFF212B36,
        'other': 0xCC757575,
      },
      'main': {
        'primary': 0xFF41B11A,
        'secondary': 0xff3357A6,
        'primaryButton': 0xFF283687,
        "purple": 0xFF7575EC
      },
      'background': {
        "button": 0x80FFFFFF,
        'default': 0xFFF8F7FA,
        'neutral': 0xFFF1F1F1,
        'paper': 0xFFFFFFFF,
        'skeleton': 0xFFF2f2f2,
        "textfield": 0xFFf5f5f5,
        "overlay": 0x8C000000
      },
      'error': {'main': 0xFFFD73737, 'light': 0xFFFDE9D1, 'dark': 0xFF906A01},
      'success': {'main': 0xFF44B22E, 'light': 0xFFE7FBD5, 'dark': 0xFF0E6714},
      'warning': {'main': 0xFFF9C804, 'light': 0xFFFEF8CC, 'dark': 0xFF906A01},
      'info': {'main': 0xFF0073D1, 'light': 0xFFCAF0FC, 'dark': 0xFF002E79},
    },
    'dark': {
      'text': {
        'primary': 0xFFFFFFFF,
        'secondary': 0xFF919EAB,
        'disabled': 0xFF637381,
        'other': 0xCC757575,
        'white': 0xFFFFFFFF,
        "black": 0xFF000000
      },
      'main': {
        'primary': 0xff3357A6,
        'secondary': 0xff3357A6,
        'primaryButton': 0xFF283687,
        "purple": 0xFF7575EC
      },
      'background': {
        'default': 0xFF191C25,
        'neutral': 0x1FF4F6F8,
        'paper': 0xFF191c25,
        'skeleton': 0xBB212b36,
        "overlay": 0xEE000000
      },
      'error': {'main': 0xFFFE4D3C, 'light': 0xFFFFA48D, 'dark': 0xFFB72136},
      'success': {'main': 0xFF35BA83, 'light': 0xFFAAF27F, 'dark': 0xFF229A16},
      'warning': {'main': 0xFFF7B538, 'light': 0xFFFFE16A, 'dark': 0xFFB78103},
      'info': {'main': 0xFF5492FF, 'light': 0xFF98C5FF, 'dark': 0xFF2A53B7},
    },
  };

  static Color getColor(BuildContext context, String type, String variant,
      {Brightness? mode}) {
    var color = Colors.black;
    var isLight =
        true; // (mode ?? MediaQuery.of(context).platformBrightness) == Brightness.light;
    var scheme = (isLight ? palette['light'] : palette['dark'])!;
    if (scheme.containsKey(type)) {
      if (scheme[type]!.containsKey(variant)) {
        color = Color(scheme[type]![variant]!);
      }
    }
    return color;
  }

  static Color get(String colorText, {Brightness? mode}) {
    var color = Colors.black;
    var isLight =
        true; // (mode ?? MediaQuery.of(context).platformBrightness) == Brightness.light;
    var scheme = (isLight ? palette['light'] : palette['dark'])!;
    final colorSplit = colorText.toString().split(".");
    final type = colorSplit[0];
    final variant = colorSplit.length > 1 ? colorSplit[1] : "";
    if (scheme.containsKey(type)) {
      if (scheme[type]!.containsKey(variant)) {
        color = Color(scheme[type]![variant]!);
      }
    }
    return color;
  }

  static String getLogo(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? "assets/images/logo.png"
        : "assets/images/logo2.png";
  }

  static String getOnboardHeader(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? 'assets/images/setup/onboarding-header.svg'
        : 'assets/images/setup/onboarding-header-dark.svg';
  }
}
