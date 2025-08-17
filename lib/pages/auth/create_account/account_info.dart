import 'package:flutter/material.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String name = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final profile = await Helpers.getProfile(key: "profile");
      setState(() {
        name = profile["fname"].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.get("main.primary"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Palette.get("main.primary"),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: Helpers.fetchIcons("circle-xmark", "regular",
                        size: 36.0, color: "text.white")),
                const SizedBox(height: 50.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Widgets.buildText("Welcome, $name!", context,
                        size: 25.0, color: "text.white", lines: 2),
                    const SizedBox(height: 10.0),
                    Widgets.buildText("Let's get you started", context,
                        size: 30.0, color: "text.white", isBold: true),
                    const SizedBox(height: 40.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/account');
                        },
                        style: Widgets.buildButton(context,
                                background:
                                    Theme.of(context).colorScheme.secondary,
                                radius: 10.0,
                                horizontal: 10.0,
                                vertical: 15.0)
                            .copyWith(alignment: Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("user-skill-gear", "regular",
                                size: 30.0, color: "text.white"),
                            FittedBox(
                              child: Widgets.buildText(
                                  "Finish your account setup", context,
                                  color: "text.white", isMedium: true),
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        )),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: Widgets.buildButton(context,
                                background:
                                    Theme.of(context).colorScheme.secondary,
                                radius: 10.0,
                                horizontal: 10.0,
                                vertical: 15.0)
                            .copyWith(alignment: Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("coin-up-arrow", "regular",
                                size: 30.0, color: "text.white"),
                            Widgets.buildText("Start Investing", context,
                                color: "text.white", isMedium: true),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        )),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: Widgets.buildButton(context,
                                background:
                                    Theme.of(context).colorScheme.secondary,
                                radius: 10.0,
                                horizontal: 10.0,
                                vertical: 15.0)
                            .copyWith(alignment: Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("wallet-income", "regular",
                                size: 30.0, color: "text.white"),
                            Widgets.buildText("Top up my Wallet", context,
                                color: "text.white", isMedium: true),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
