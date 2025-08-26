import 'package:flutter/material.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/widget.dart';

class ProfileObjective extends StatefulWidget {
  const ProfileObjective({Key? key}) : super(key: key);

  @override
  _ProfileAboutState createState() => _ProfileAboutState();
}

class _ProfileAboutState extends State<ProfileObjective> {
  Map<String, String> values = {
    "percentRisk": "",
    "investmentDuration": "",
    "returnTarget": "",
  };
  final TextEditingController totalController = TextEditingController();

  void toConfirmation() {
    calcResult();
    Navigator.pushNamed(context, "/profile_confirmation", arguments: values);
  }

  void calcResult() async {
    final percentRisk = values["percentRisk"].toString();
    final investmentDuration = values["investmentDuration"].toString();
    final returnTarget = values["returnTarget"].toString();
    var conclusion = "Highly aggressive";
    if (percentRisk == "Less than 25%") {
      conclusion = "Risk Averse";
    }
    if (percentRisk == "Between 25% - 50%" &&
        (returnTarget == "At least 20%" || returnTarget == "At least 25%")) {
      conclusion = "Conservative";
    }
    if ((percentRisk == "Between 25% - 50%" || percentRisk == "Above 50%") &&
        (investmentDuration == "Maximum 1 year" ||
            investmentDuration == "Up to 2 years")) {
      conclusion = "Moderate";
    }
    if ((percentRisk == "Between 25% - 50%" || percentRisk == "Above 50%") &&
        (investmentDuration == "Up to 2 years" ||
            investmentDuration == "Up to 5 years")) {
      conclusion = "Moderately Aggressive";
    }
    setState(() {
      values["conclusion"] = conclusion;
    });
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
        title: Widgets.buildText("Investor's Profile (2/3)", context,
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
                      Widgets.buildText(
                          "Your Investment Objective & Risk Tolerance", context,
                          size: 30.0, isBold: true, lines: 10),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "What is your investment objective and how much risk can you tolerate?",
                          context,
                          size: 20.0,
                          lines: 10,
                          color: 'text.secondary'),
                      const SizedBox(height: 30.0),
                      Widgets.buildText(
                          "1. To achieve higher returns, what percentage of your liquid net worth will you invest in a higher risk transaction?",
                          context,
                          color: "text.primary",
                          lines: 5,
                          size: 18.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          itemCount: Defaults.percentInvest.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = Defaults.percentInvest[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: item,
                                    onChanged: (value) {
                                      setState(() {
                                        values["percentRisk"] = item;
                                      });
                                    },
                                    groupValue: values["percentRisk"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["percentRisk"] = item;
                                          });
                                        },
                                        child: Widgets.buildText(item, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "2. How long can you consider investing to achieve your financial goals?",
                          context,
                          lines: 5,
                          color: "text.primary",
                          size: 18.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          itemCount: Defaults.financialGoals.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = Defaults.financialGoals[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: item,
                                    onChanged: (value) {
                                      setState(() {
                                        values["investmentDuration"] = item;
                                      });
                                    },
                                    groupValue: values["investmentDuration"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["investmentDuration"] = item;
                                          });
                                        },
                                        child: Widgets.buildText(item, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "3. What is your overall portfolio return target?",
                          context,
                          color: "text.primary",
                          lines: 5,
                          size: 18.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          itemCount: Defaults.returnTarget.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final status = Defaults.returnTarget[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: status,
                                    onChanged: (value) {
                                      setState(() {
                                        values["returnTarget"] = status;
                                      });
                                    },
                                    groupValue: values["returnTarget"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["returnTarget"] = status;
                                          });
                                        },
                                        child: Widgets.buildText(
                                            status, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        final empties = values.keys
                            .where(
                                (element) => values[element].toString().isEmpty)
                            .toList();
                        if (empties.isNotEmpty) {
                          Alert.show(context, "",
                              "Please fill all fields to proceed.");
                          return;
                        }
                        toConfirmation();
                      },
                      style: Widgets.buildButton(context,
                          background: Theme.of(context).colorScheme.secondary,
                          radius: 30.0,
                          horizontal: 10.0,
                          vertical: 15.0),
                      child: Widgets.buildText("CONTINUE", context,
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
