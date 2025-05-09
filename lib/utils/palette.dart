import 'package:flutter/material.dart';

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
        'primary': 0xFF174AB5,
        'secondary': 0xffFDA911,
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
      'error': {'main': 0xFFD61B1E, 'light': 0xFFFCDFD0, 'dark': 0xFF660528},
      'success': {'main': 0xFF108C44, 'light': 0xFFCDF9CE, 'dark': 0xFF034337},
      'warning': {'main': 0xFFFFC005, 'light': 0xFFFFF7CD, 'dark': 0xFF7A4F00},
      'info': {'main': 0xFF146BE5, 'light': 0xFFCFEAFD, 'dark': 0xFF031E6D},
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
        'primary': 0xFF174AB5,
        'secondary': 0xffFDA911,
      },
      'background': {
        'default': 0xFF191C25,
        'neutral': 0x1FF4F6F8,
        'paper': 0xFF191c25,
        'skeleton': 0xBB212b36,
        "overlay": 0xEE000000
      },
      'error': {'main': 0xFFD61B1E, 'light': 0xFFFCDFD0, 'dark': 0xFF660528},
      'success': {'main': 0xFF108C44, 'light': 0xFFCDF9CE, 'dark': 0xFF034337},
      'warning': {'main': 0xFFFFC005, 'light': 0xFFFFF7CD, 'dark': 0xFF7A4F00},
      'info': {'main': 0xFF146BE5, 'light': 0xFFCFEAFD, 'dark': 0xFF031E6D},
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
