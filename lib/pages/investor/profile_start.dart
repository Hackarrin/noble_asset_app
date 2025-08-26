import 'package:flutter/material.dart';
import 'package:nobleassets/utils/widget.dart';
import '../../../utils/helpers.dart';

class ProfileStart extends StatefulWidget {
  const ProfileStart({Key? key}) : super(key: key);

  @override
  _ProfileStartState createState() => _ProfileStartState();
}

class _ProfileStartState extends State<ProfileStart> {
  Map<String, dynamic> prevProfile = {};

  void check() async {
    try {
      final profile = await Helpers.getInvestmentProfile();
      if (profile.isNotEmpty && profile.containsKey("date")) {
        setState(() {
          prevProfile = profile;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, check);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Helpers.fetchIcons("investment", "solid",
                        size: 100.0, color: "main.primary"),
                    const SizedBox(height: 30.0),
                    Widgets.buildText("Client Investment Profile", context,
                        isCenter: true,
                        isBold: true,
                        size: 35.0,
                        color: "main.secondary",
                        lines: 10),
                    const SizedBox(height: 15.0),
                    Widgets.buildText(
                        "The answers to the following questions will assist us in assessing your current investment objectives, risk appetite, knowledge and experience. This will help us make recommendations that are best suited to your investment profile.",
                        context,
                        isCenter: true,
                        size: 15.0,
                        lines: 10,
                        color: "text.secondary"),
                    if (prevProfile.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 40.0, bottom: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Widgets.buildText("Current Rating:", context,
                                    size: 17.0, color: "text.secondary"),
                                const SizedBox(width: 20.0),
                                Expanded(
                                    child: Widgets.buildText(
                                        prevProfile["rating"]
                                            .toString()
                                            .toUpperCase(),
                                        context,
                                        size: 17.0,
                                        color: "main.secondary",
                                        isBold: true)),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                Widgets.buildText("Last Updated:", context,
                                    size: 17.0, color: "text.secondary"),
                                const SizedBox(width: 20.0),
                                Expanded(
                                    child: Widgets.buildText(
                                        Helpers.formatDate(
                                            prevProfile["date"].toString(),
                                            formatString:
                                                "yyyy-MM-dd HH:mm:ss"),
                                        context,
                                        size: 17.0,
                                        color: "text.primary")),
                              ],
                            ),
                            if (prevProfile["preferredRating"]
                                .toString()
                                .isNotEmpty)
                              const SizedBox(height: 20.0),
                            if (prevProfile["preferredRating"]
                                .toString()
                                .isNotEmpty)
                              Row(
                                children: [
                                  Widgets.buildText(
                                      "Preferred Rating:", context,
                                      size: 17.0, color: "text.secondary"),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                      child: Widgets.buildText(
                                          prevProfile["preferredRating"]
                                              .toString()
                                              .toUpperCase(),
                                          context,
                                          size: 17.0,
                                          color: "main.secondary",
                                          isBold: true)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 50.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/profile_about");
                          },
                          style: Widgets.buildButton(context,
                              background:
                                  Theme.of(context).colorScheme.secondary,
                              radius: 50.0,
                              horizontal: 50.0,
                              vertical: 18.0),
                          child: Widgets.buildText(
                              prevProfile.isNotEmpty ? "Update" : "Start",
                              context,
                              isMedium: true,
                              color: "text.white")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
