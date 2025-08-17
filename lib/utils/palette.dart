import 'package:flutter/material.dart';
import 'package:nobleassets/main.dart';

class Palette {
  static const Map<String, Map<String, Map<String, int>>> palette = {
    'light': {
      'text': {
        'primary': 0xFF0B132B,
        'secondary': 0xFF191C25,
        'disabled': 0xFF696A6F,
        'white': 0xFFFFFFFF,
        "black": 0xFF212B36,
        'other': 0xCC757575,
      },
      'main': {
        'primary': 0xFF852E5E,
        'secondary': 0xffa3802b,
      },
      'background': {
        "button": 0x80FFFFFF,
        'default': 0xFFffffff,
        'neutral': 0xFFF1F1F1,
        'paper': 0xFFFFFFFF,
        'skeleton': 0xFFF2f2f2,
        "textfield": 0xFFf5f5f5,
        "overlay": 0x8C000000
      },
      'error': {'main': 0xFFBC421A, 'light': 0xFFEAA071, 'dark': 0xFF87190D},
      'success': {'main': 0xFF56C124, 'light': 0xFACEC79, 'dark': 0xFF0B5C06},
      'warning': {'main': 0xFFD6A000, 'light': 0xFFF2D561, 'dark': 0xFF9A6B00},
      'info': {'main': 0xFF0097E2, 'light': 0xFF62D8F6, 'dark': 0xFF0057A2},
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
        'primary': 0xFF852E5E,
        'secondary': 0xffa3802b,
      },
      'background': {
        'default': 0xFF191C25,
        'neutral': 0x1FF4F6F8,
        'paper': 0xFF191c25,
        'skeleton': 0xBB212b36,
        "overlay": 0xEE000000
      },
      'error': {'main': 0xFFBC421A, 'light': 0xFFEAA071, 'dark': 0xFF87190D},
      'success': {'main': 0xFF56C124, 'light': 0xFACEC79, 'dark': 0xFF0B5C06},
      'warning': {'main': 0xFFD6A000, 'light': 0xFFF2D561, 'dark': 0xFF9A6B00},
      'info': {'main': 0xFF0097E2, 'light': 0xFF62D8F6, 'dark': 0xFF0057A2},
    },
  };

  static Color getColor(BuildContext context, String type, String variant,
      {Brightness? mode}) {
    var color = Colors.black;
    var isLight = (mode ?? Theme.of(navigatorKey.currentContext!).brightness) ==
        Brightness.light;
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
    var isLight = (mode ?? Theme.of(navigatorKey.currentContext!).brightness) ==
        Brightness.light;
    print("response $isLight");
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
