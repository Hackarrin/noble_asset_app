import 'package:afritas/utils/loader.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';

abstract class Alert {
  static void show(
    BuildContext context,
    String title,
    String message, {
    type = "error",
    buttonText = "",
    Function? buttonAction,
    Function? cancelAction,
  }) {
    final icons = {
      "error": "assets/animations/error1.json",
      "success": "assets/animations/success.json",
      "warning": "assets/animations/warning.json",
      "info": "assets/animations/info.json",
    };
    Alert.hideLoading(context);
    showModalBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Palette.getColor(context, "background", "paper"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icons.keys.contains(type)) const SizedBox(height: 2),
                    if (title.isNotEmpty)
                      Widgets.buildText(title, context,
                          size: 24.0,
                          isBold: true,
                          isCenter: true,
                          lines: 3,
                          color: "main.primary"),
                    if (title.isNotEmpty) const SizedBox(height: 15),
                    Widgets.buildText(message, context,
                        size: 16.0,
                        isCenter: true,
                        color: "text.secondary",
                        lines: 5),
                    const SizedBox(
                      height: 30.0,
                    ),
                    if (buttonText.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (buttonAction != null) {
                            buttonAction();
                          }
                        },
                        child: Widgets.buildText(buttonText, context,
                            isMedium: true),
                      ),
                    if (buttonText.isNotEmpty)
                      const SizedBox(
                        height: 15.0,
                      ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Widgets.buildText("Close", context),
                    )
                  ],
                )),
          );
        });
      },
    ).whenComplete(() {
      if (cancelAction != null) {
        cancelAction();
      }
    });
  }

  static showLoading(BuildContext context, String title,
      {String message = ""}) {
    Loader.show(context, title, message);
  }

  static hideLoading(BuildContext context) {
    Loader.hide(context);
  }
}
