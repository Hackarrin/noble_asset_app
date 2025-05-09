import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

class SignupNotification extends StatefulWidget {
  const SignupNotification({Key? key}) : super(key: key);

  @override
  _SignupNotificationState createState() => _SignupNotificationState();
}

class _SignupNotificationState extends State<SignupNotification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: Palette.getColor(context, "background", "paper"),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              width: screenWidth,
              height: screenHeight,
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF9F8F8),
                        borderRadius: BorderRadius.circular(60.0)),
                    padding: const EdgeInsets.all(20.0),
                    child: UnconstrainedBox(
                      child: Helpers.fetchIcons(
                          "bell-notification-social-media", "solid",
                          size: 60.0, color: "main.primary"),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Widgets.buildText(
                    "Enable Notification Access",
                    context,
                    isMedium: true,
                    size: 24.0,
                    weight: 500,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Widgets.buildText(
                      "Enable notification to  receive real-time update",
                      context,
                      lines: 10,
                      isCenter: true,
                      color: "text.secondary"),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/signup-complete-profile");
                        },
                        style: Widgets.buildButton(context,
                            vertical: 20.0,
                            horizontal: 10.0,
                            radius: 60.0,
                            background: Palette.get("main.primary")),
                        child: Widgets.buildText("Allow Notification", context,
                            color: "text.white", weight: 500, size: 16.0)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup-complete-profile");
                    },
                    child: Widgets.buildText("Maybe later", context,
                        color: "main.primary", isMedium: true),
                  ),
                ],
              )),
        )));
  }
}
