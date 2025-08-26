import 'package:flutter/material.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import '../../../main.dart';
import '../../../utils/fetch.dart';
import '../../../utils/helpers.dart';

class ProfileConfirmation extends StatefulWidget {
  const ProfileConfirmation({Key? key}) : super(key: key);

  @override
  _ProfileConfirmationState createState() => _ProfileConfirmationState();
}

class _ProfileConfirmationState extends State<ProfileConfirmation> {
  Map<String, String> values = {
    "agree": "",
    "preferredProfile": "",
    "conclusion": "",
  };
  void save() async {
    try {
      Alert.showLoading(context, "Saving. Please wait...");
      Map data = await Fetch(API.investorProfile, values).load();
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
      if (data["status"].toString() == "success") {
        await Helpers.fetchProfile();
        Navigator.pushNamed(navigatorKey.currentContext!, "/profile_success",
            arguments: values);
      } else {
        Alert.show(
            context, "", "Something went wrong! Please try again later.");
      }
    } catch (e) {
      Alert.show(context, "", "Something went wrong! Please try again later.");
    }
  }

  void check() async {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{}) as Map<String, String>;
    setState(() {
      values.addAll(arguments);
    });
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
      appBar: AppBar(
        title: Widgets.buildText("Investor's Profile (3/3)", context,
            isMedium: true),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Confirmation", context,
                          size: 35.0, isBold: true),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "Here's the result of your profile", context,
                          size: 20.0, color: 'text.secondary'),
                      const SizedBox(height: 30.0),
                      Widgets.buildText("Our Ratings Explanation:", context,
                          color: "text.primary",
                          size: 18.0,
                          isBold: true,
                          isCenter: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Defaults.ratings.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = Defaults.ratings[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText(
                                    "${item["title"].toString()}:", context,
                                    size: 16.0, color: "text.primary"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 5.0, bottom: 8.0),
                                  child: Widgets.buildText(
                                      item["description"].toString(), context,
                                      lines: 10,
                                      size: 14.0,
                                      color: "text.secondary"),
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "Based on the questions and your responses, we believe you are",
                          context,
                          lines: 10,
                          color: "text.primary",
                          size: 18.0,
                          isCenter: true,
                          isBold: true),
                      const SizedBox(height: 10.0),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Palette.getColor(context, "success", "main"),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Widgets.buildText(
                              values["conclusion"].toString().isNotEmpty
                                  ? "${values["conclusion"].toString().toUpperCase()}!"
                                  : "RISK AVERSE!",
                              context,
                              color: "text.white",
                              size: 18.0,
                              isBold: true),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Widgets.buildText(
                          "Kindly confirm if you agree with the Client Investor Profile Ratings",
                          context,
                          color: "text.primary",
                          lines: 4,
                          size: 14.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = index == 0
                                ? {
                                    "title": "I agree with the profiling",
                                    "value": "1",
                                  }
                                : {
                                    "title":
                                        "I disagree with the ratings and opt for a different Client Investment Profile",
                                    "value": "0",
                                  };
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: item["value"].toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        values["agree"] =
                                            item["value"].toString();
                                      });
                                    },
                                    groupValue: values["agree"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["agree"] =
                                                item["value"].toString();
                                          });
                                        },
                                        child: Widgets.buildText(
                                            item["title"].toString(), context,
                                            lines: 3,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      if (values["agree"].toString() == "0")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Widgets.buildText(
                                "Select your preferred profiling:", context,
                                color: "text.primary",
                                size: 16.0,
                                isBold: true),
                            ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 10.0, 15.0),
                                shrinkWrap: true,
                                itemCount: Defaults.ratings.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = Defaults.ratings[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Radio(
                                          toggleable: true,
                                          value: item["title"].toString(),
                                          onChanged: (value) {
                                            setState(() {
                                              values["preferredProfile"] =
                                                  item["title"].toString();
                                            });
                                          },
                                          groupValue:
                                              values["preferredProfile"]),
                                      Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  values["preferredProfile"] =
                                                      item["title"].toString();
                                                });
                                              },
                                              child: Widgets.buildText(
                                                  item["title"].toString(),
                                                  context,
                                                  size: 14.0,
                                                  color: "text.secondary")))
                                    ],
                                  );
                                }),
                          ],
                        )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (values["agree"].toString().isEmpty) {
                          Alert.show(context, "",
                              "Please confirm your agreement to proceed.");
                          return;
                        }
                        save();
                      },
                      style: Widgets.buildButton(context,
                          background: Theme.of(context).colorScheme.secondary,
                          radius: 30.0,
                          horizontal: 10.0,
                          vertical: 15.0),
                      child: Widgets.buildText("SAVE", context,
                          isMedium: true, color: "text.white"),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
