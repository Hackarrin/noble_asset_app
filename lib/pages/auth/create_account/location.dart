import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

class SignupLocation extends StatefulWidget {
  const SignupLocation({Key? key}) : super(key: key);

  @override
  _SignupLocationState createState() => _SignupLocationState();
}

class _SignupLocationState extends State<SignupLocation> {
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
                      child: Helpers.fetchIcons("marker", "solid",
                          size: 60.0, color: "main.primary"),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Widgets.buildText(
                    "What is your location?",
                    context,
                    isMedium: true,
                    size: 24.0,
                    weight: 500,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Widgets.buildText(
                      "To suggest nearby services, we need to know your location.",
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
                          Navigator.pushNamed(context, "/signup-notification");
                        },
                        style: Widgets.buildButton(context,
                            vertical: 20.0,
                            horizontal: 10.0,
                            radius: 60.0,
                            background: Palette.get("main.primary")),
                        child: Widgets.buildText(
                            "Allow Location Access", context,
                            color: "text.white", weight: 500, size: 16.0)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Widgets.buildText("Enter your location manually", context,
                      color: "main.primary", isMedium: true),
                ],
              )),
        )));
  }
}
