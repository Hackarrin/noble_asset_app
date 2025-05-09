import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
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

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        selected = true;
      });
      Future.delayed(const Duration(milliseconds: 2500), () {
        setState(() {
          isDone = true;
        });
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
    return Scaffold(
      backgroundColor: selected
          ? Palette.getColor(context, "background", "paper")
          : Palette.getColor(context, "main", "primary"),
      body: isDone
          ? SlideInUp(
              duration: Duration(seconds: 1),
              child: SafeArea(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: 300, maxHeight: 500),
                                  child: SizedBox(
                                    height: 500.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color:
                                                    Palette.get("main.primary"),
                                                width: 2.0),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(260, 320))),
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: ClipOval(
                                          child: Image.asset(
                                              "assets/images/splash.jpeg",
                                              height: 500,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0.0,
                                    top: 0.0,
                                    width: 70.0,
                                    height: 70.0,
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF61FF61),
                                            Color(0xFF41B11A)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(70.0)),
                                    )),
                                Positioned(
                                    left: 0.0,
                                    bottom: 0.0,
                                    width: 50.0,
                                    height: 50.0,
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF61FF61),
                                            Color(0xFF41B11A)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(70.0)),
                                    )),
                                Positioned(
                                    right: 100.0,
                                    bottom: 0.0,
                                    width: 50.0,
                                    height: 50.0,
                                    child: Transform.rotate(
                                      angle: 18.4,
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF41B11A),
                                              Color(0xFF61FF61),
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(70.0)),
                                        child: UnconstrainedBox(
                                          child: Helpers.fetchIcons(
                                              "arrow-small-right", "regular",
                                              color: "text.white", size: 30.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Column(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  Widgets.buildText(
                                    "Your ",
                                    context,
                                    isMedium: true,
                                    size: 24.0,
                                    weight: 500,
                                  ),
                                  Widgets.buildText(
                                    "Ultimate Booking ",
                                    context,
                                    isMedium: true,
                                    size: 24.0,
                                    color: "main.primary",
                                    weight: 500,
                                  ),
                                  Widgets.buildText(
                                    "Experience with ",
                                    context,
                                    isMedium: true,
                                    size: 24.0,
                                    weight: 500,
                                  ),
                                  Widgets.buildText(
                                    "Afritas",
                                    context,
                                    isMedium: true,
                                    size: 24.0,
                                    color: "main.primary",
                                    weight: 500,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Widgets.buildText(
                                  "Discover endless possibilities for travel, stays, rentals, and unforgettable experiences with Afritas.",
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
                                      Navigator.pushNamed(
                                          context, "/get-started");
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    Widgets.buildText(
                                        "Already have an account?   ", context,
                                        color: "text.secondary"),
                                    Widgets.buildText("Sign In", context,
                                        isUnderlined: true,
                                        color: "main.primary"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ))),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: selected
                    ? Palette.getColor(context, "background", "paper")
                    : Palette.getColor(context, "main", "primary"),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Palette.get("background.paper"),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(12, 14),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  color: Color(0x0D000000))
                            ]),
                        child: Image.asset(
                          "assets/images/icon.png",
                          height: 200.0,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
    );
  }
}
