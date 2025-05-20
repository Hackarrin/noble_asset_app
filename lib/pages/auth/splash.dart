import 'dart:convert';

import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/palette.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var selected = false;
  var isDone = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        final data = jsonDecode(arguments.toString());
        if (data["isDone"]) {
          setState(() {
            isDone = true;
          });
          return;
        }
      }

      final isGuest = await Helpers.readPref(Defaults.isGuest);
      if (isGuest == "1") {
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacementNamed(context, "/home");
        });
        return;
      }

      Future.delayed(const Duration(milliseconds: 2500), () async {
        final userid = await Helpers.readPref(Defaults.userid);
        if (userid.isEmpty) {
          setState(() {
            isDone = true;
          });
        } else {
          // logged in, go to home
          Navigator.pushNamed(context, "/home");
        }
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: isDone
          ? Palette.getColor(context, "background", "paper")
          : Palette.getColor(context, "main", "primary"),
      body: isDone
          ? FadeIn(
              duration: Duration(seconds: 1),
              child: SafeArea(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 70.0,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: 300, maxHeight: 500),
                                  child: SizedBox(
                                    height: 500.0,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Image.asset(
                                            "assets/images/splash.png",
                                            height: 500,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Column(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  Widgets.buildText(
                                    "Find ",
                                    context,
                                    isMedium: true,
                                    size: 35.0,
                                    weight: 700,
                                  ),
                                  Widgets.buildText(
                                    "Any Crib ",
                                    context,
                                    isMedium: true,
                                    size: 35.0,
                                    color: "main.primary",
                                    weight: 700,
                                  ),
                                  Widgets.buildText(
                                    "You Want",
                                    context,
                                    isMedium: true,
                                    size: 35.0,
                                    weight: 700,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Widgets.buildText(
                                  "Find the perfect space for your stay—for business, leisure, content creation, or a weekend escape. Verified listings, easy booking, and total comfort.",
                                  context,
                                  lines: 10,
                                  size: 16.0,
                                  isCenter: true,
                                  color: "text.secondary"),
                              const SizedBox(
                                height: 20.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      Helpers.writePref(Defaults.isGuest, "0");
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    style: Widgets.buildButton(context,
                                        vertical: 20.0,
                                        horizontal: 10.0,
                                        radius: 60.0,
                                        background:
                                            Palette.get("main.primary")),
                                    child: Widgets.buildText(
                                        "Get Started", context,
                                        color: "text.white",
                                        weight: 500,
                                        size: 16.0)),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Widgets.buildText("OR", context,
                                  isMedium: true,
                                  color: "main.primary",
                                  size: 14.0),
                              const SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      Helpers.writePref(Defaults.isGuest, "1");
                                      Navigator.pushNamed(context, "/home");
                                    },
                                    style: Widgets.buildButton(context,
                                        vertical: 15.0,
                                        horizontal: 10.0,
                                        radius: 60.0,
                                        sideColor:
                                            Palette.get("text.secondary"),
                                        background:
                                            Palette.get("background.paper")),
                                    child: Widgets.buildText(
                                        "Continue as Guest", context,
                                        isMedium: true)),
                              ),
                            ],
                          ),
                        ],
                      ))),
            )
          : Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo-splash.png",
                      width: screenWidth * (3 / 4),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Image.asset("assets/images/splash-icon.png",
                        width: screenWidth * (3.5 / 4)))
              ],
            ),
    );
  }
}
