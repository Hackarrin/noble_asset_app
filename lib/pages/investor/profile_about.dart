import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';

class ProfileAbout extends StatefulWidget {
  const ProfileAbout({Key? key}) : super(key: key);

  @override
  _ProfileAboutState createState() => _ProfileAboutState();
}

class _ProfileAboutState extends State<ProfileAbout> {
  Map<String, String> values = {
    "ageRange": "",
    "education": "",
    "employment": "",
    "annualIncome": "0",
    "cashBank": "0",
    "investmentProducts": "0",
    "realEstate": "0",
    "loans": "0",
    "total": "0",
    "understandingTreasury": "",
    "understandingFixedDeposit": "",
    "understandingMutualFunds": "",
    "understandingStocks": "",
    "understandingCommercialPaper": "",
    "understandingStructuredNote": "",
    "understandingEquity": "",
    "understandingDerivatives": "",
    "experienceTreasury": "",
    "experienceFixedDeposit": "",
    "experienceMutualFunds": "",
    "experienceStocks": "",
    "experienceCommercialPaper": "",
    "experienceStructuredNote": "",
    "experienceEquity": "",
    "experienceDerivatives": "",
    "financialLiteracy": "",
    "dollarInvestment": ""
  };
  final TextEditingController totalController = TextEditingController();
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(symbol: "");

  void toInvestment() {
    Navigator.pushNamed(context, "/profile_objective", arguments: values);
  }

  void calcTotal() async {
    final annualIncome =
        num.tryParse(values["annualIncome"].toString())?.toDouble() ?? 0;
    final cashBank =
        num.tryParse(values["cashBank"].toString())?.toDouble() ?? 0;
    final investmentProducts =
        num.tryParse(values["investmentProducts"].toString())?.toDouble() ?? 0;
    final realEstate =
        num.tryParse(values["realEstate"].toString())?.toDouble() ?? 0;
    final loans = num.tryParse(values["loans"].toString())?.toDouble() ?? 0;
    print(
        "response - $annualIncome $cashBank $investmentProducts $realEstate $loans");
    final total =
        (annualIncome + cashBank + investmentProducts + realEstate) - loans;
    print(
        "response - $annualIncome $cashBank $investmentProducts $realEstate $loans = $total");
    setState(() {
      values["total"] = total.toString();
    });
    totalController.text =
        _formatter.formatString((total.toInt() * 100).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Widgets.buildText("Investor's Profile (1/3)", context,
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
                      Widgets.buildText("About You", context,
                          size: 35.0, isBold: true),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "Tell us a bit more about yourself", context,
                          size: 20.0, isBold: true, color: 'text.secondary'),
                      const SizedBox(height: 30.0),
                      Widgets.buildText("1. Age Range", context,
                          color: "text.primary", size: 18.0, isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Defaults.ageRange.length,
                          itemBuilder: (BuildContext context, int index) {
                            final age = Defaults.ageRange[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: age,
                                    onChanged: (value) {
                                      setState(() {
                                        values["ageRange"] = age;
                                      });
                                    },
                                    groupValue: values["ageRange"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["ageRange"] = age;
                                          });
                                        },
                                        child: Widgets.buildText(age, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "2. What's your educational qualification?", context,
                          color: "text.primary", size: 18.0, isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Defaults.educationalQualification.length,
                          itemBuilder: (BuildContext context, int index) {
                            final education =
                                Defaults.educationalQualification[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: education,
                                    onChanged: (value) {
                                      setState(() {
                                        values["education"] = education;
                                      });
                                    },
                                    groupValue: values["education"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["education"] = education;
                                          });
                                        },
                                        child: Widgets.buildText(
                                            education, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "3. What is your employment status?", context,
                          color: "text.primary", size: 18.0, isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Defaults.employmentStatus.length,
                          itemBuilder: (BuildContext context, int index) {
                            final status = Defaults.employmentStatus[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: status,
                                    onChanged: (value) {
                                      setState(() {
                                        values["employment"] = status;
                                      });
                                    },
                                    groupValue: values["employment"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["employment"] = status;
                                          });
                                        },
                                        child: Widgets.buildText(
                                            status, context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "4. What is your current Financial Net Worth?",
                          context,
                          lines: 3,
                          color: "text.primary",
                          size: 18.0,
                          isBold: true),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: Widgets.inputDecoration(
                                "Estimated Annual Income",
                                isOutline: true,
                                prefixIcon: UnconstrainedBox(
                                  child: Widgets.buildText("NGN", context,
                                      color: "text.secondary"),
                                ),
                                isFloating: true,
                                hintColor: Palette.get("text.secondary"),
                                color: Palette.get("background.default"),
                                borderColor: Palette.get("text.primary"),
                                isFilled: true,
                              ),
                              style: GoogleFonts.nunito(
                                color: Palette.get("text.secondary"),
                                fontSize: 16.0,
                              ),
                              inputFormatters: [_formatter],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                if (!Helpers.isNumeric(value)) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  values["annualIncome"] =
                                      value.replaceAll(",", "");
                                });
                                calcTotal();
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 25.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  inputFormatters: [_formatter],
                                  decoration: Widgets.inputDecoration(
                                    "Cash & Bank",
                                    prefixIcon: UnconstrainedBox(
                                      child: Widgets.buildText("NGN", context,
                                          color: "text.secondary"),
                                    ),
                                    isOutline: true,
                                    isFloating: true,
                                    hintColor: Palette.get("text.secondary"),
                                    color: Palette.get("background.default"),
                                    borderColor: Palette.get("text.primary"),
                                    isFilled: true,
                                  ),
                                  style: GoogleFonts.nunito(
                                    color: Palette.get("text.secondary"),
                                    fontSize: 16.0,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid amount to proceed';
                                    }
                                    if (!Helpers.isNumeric(value)) {
                                      return 'Please enter a valid amount to proceed';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      values["cashBank"] =
                                          value.replaceAll(",", "");
                                      ;
                                    });
                                    calcTotal();
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 4.0),
                                Widgets.buildText(
                                    "Cash & Bank (Current account + Savings +    Investment)",
                                    context,
                                    size: 12.0,
                                    color: "text.secondary")
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  inputFormatters: [_formatter],
                                  decoration: Widgets.inputDecoration(
                                    "Investments Products",
                                    isOutline: true,
                                    prefixIcon: UnconstrainedBox(
                                      child: Widgets.buildText("NGN", context,
                                          color: "text.secondary"),
                                    ),
                                    isFloating: true,
                                    hintColor: Palette.get("text.secondary"),
                                    color: Palette.get("background.default"),
                                    borderColor: Palette.get("text.primary"),
                                    isFilled: true,
                                  ),
                                  style: GoogleFonts.nunito(
                                    color: Palette.get("text.secondary"),
                                    fontSize: 16.0,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid amount to proceed';
                                    }
                                    if (!Helpers.isNumeric(value)) {
                                      return 'Please enter a valid amount to proceed';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      values["investmentProducts"] =
                                          value.replaceAll(",", "");
                                    });
                                    calcTotal();
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 4.0),
                                Widgets.buildText(
                                    "Investments Products (Stocks, bonds , Mutual Fund etc)",
                                    context,
                                    size: 12.0,
                                    color: "text.secondary")
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              inputFormatters: [_formatter],
                              decoration: Widgets.inputDecoration(
                                "Real Estate",
                                isOutline: true,
                                isFloating: true,
                                prefixIcon: UnconstrainedBox(
                                  child: Widgets.buildText("NGN", context,
                                      color: "text.secondary"),
                                ),
                                hintColor: Palette.get("text.secondary"),
                                color: Palette.get("background.default"),
                                borderColor: Palette.get("text.primary"),
                                isFilled: true,
                              ),
                              style: GoogleFonts.nunito(
                                color: Palette.get("text.secondary"),
                                fontSize: 16.0,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                if (!Helpers.isNumeric(value)) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  values["realEstate"] =
                                      value.replaceAll(",", "");
                                  ;
                                });
                                calcTotal();
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              inputFormatters: [_formatter],
                              decoration: Widgets.inputDecoration(
                                "Outstanding Loans",
                                isOutline: true,
                                prefixIcon: UnconstrainedBox(
                                  child: Widgets.buildText("NGN", context,
                                      color: "text.secondary"),
                                ),
                                isFloating: true,
                                hintColor: Palette.get("text.secondary"),
                                color: Palette.get("background.default"),
                                borderColor: Palette.get("text.primary"),
                                isFilled: true,
                              ),
                              style: GoogleFonts.nunito(
                                color: Palette.get("text.secondary"),
                                fontSize: 16.0,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                if (!Helpers.isNumeric(value)) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  values["loans"] = value.replaceAll(",", "");
                                  ;
                                });
                                calcTotal();
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              controller: totalController,
                              readOnly: true,
                              decoration: Widgets.inputDecoration(
                                "Total Net",
                                prefixIcon: UnconstrainedBox(
                                  child: Widgets.buildText("NGN", context,
                                      color: "text.secondary"),
                                ),
                                isOutline: true,
                                isFloating: true,
                                hintColor: Palette.get("text.secondary"),
                                color: Palette.get("background.default"),
                                borderColor: Palette.get("text.primary"),
                                isFilled: true,
                              ),
                              style: GoogleFonts.nunito(
                                color: Palette.get("text.secondary"),
                                fontSize: 16.0,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                if (!Helpers.isNumeric(value)) {
                                  return 'Please enter a valid amount to proceed';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "5. What is the extent of your understanding and experience of the following investment products?",
                          context,
                          lines: 3,
                          color: "text.primary",
                          size: 18.0,
                          isBold: true),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (final item in Defaults.understandingExperience)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      item["title"].toString(), context,
                                      color: "text.primary",
                                      size: 14.0,
                                      isBold: true),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  "Understanding", context,
                                                  color: "main.secondary",
                                                  size: 14.0),
                                              const SizedBox(height: 5.0),
                                              ListView.builder(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: Defaults
                                                      .understanding.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final element = Defaults
                                                        .understanding[index];
                                                    return Row(
                                                      children: [
                                                        Radio(
                                                            toggleable: true,
                                                            value: element,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                values[item["understanding"]
                                                                        .toString()] =
                                                                    element;
                                                              });
                                                            },
                                                            groupValue: values[
                                                                item["understanding"]
                                                                    .toString()]),
                                                        Expanded(
                                                          child: Widgets.buildText(
                                                              element, context,
                                                              color:
                                                                  "text.secondary",
                                                              size: 14.0),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  "Experience", context,
                                                  color: "main.secondary",
                                                  size: 14.0),
                                              const SizedBox(height: 5.0),
                                              ListView.builder(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: Defaults
                                                      .experience.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final element = Defaults
                                                        .experience[index];
                                                    return Row(
                                                      children: [
                                                        Radio(
                                                            toggleable: true,
                                                            value: element,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                values[item["experience"]
                                                                        .toString()] =
                                                                    element;
                                                              });
                                                            },
                                                            groupValue: values[
                                                                item["experience"]
                                                                    .toString()]),
                                                        Expanded(
                                                          child: Widgets.buildText(
                                                              element, context,
                                                              color:
                                                                  "text.secondary",
                                                              size: 14.0),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "6. How financially literate are you on a scale of 1 - 10? With 1 being lowest?",
                          context,
                          color: "text.primary",
                          lines: 3,
                          size: 18.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: (index + 1).toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        values["financialLiteracy"] =
                                            (index + 1).toString();
                                      });
                                    },
                                    groupValue: values["financialLiteracy"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["financialLiteracy"] =
                                                (index + 1).toString();
                                          });
                                        },
                                        child: Widgets.buildText(
                                            (index + 1).toString(), context,
                                            size: 14.0,
                                            color: "text.secondary")))
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Widgets.buildText(
                          "7. Do you have the capacity and are willing to make dollar investments?",
                          context,
                          color: "text.primary",
                          lines: 3,
                          size: 18.0,
                          isBold: true),
                      ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 15.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            final item = index == 0 ? "YES" : "NO";
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                    toggleable: true,
                                    value: item,
                                    onChanged: (value) {
                                      setState(() {
                                        values["dollarInvestment"] = item;
                                      });
                                    },
                                    groupValue: values["dollarInvestment"]),
                                Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            values["dollarInvestment"] = item;
                                          });
                                        },
                                        child: Widgets.buildText(item, context,
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
                    child: TextButton(
                      onPressed: () {
                        final empties = values.keys
                            .where(
                                (element) => values[element].toString().isEmpty)
                            .toList();
                        print("response ${empties}");
                        if (empties.isNotEmpty) {
                          Alert.show(context, "",
                              "Please fill all fields to proceed.");
                          return;
                        }
                        if (values["total"].toString() == "0") {
                          Alert.show(context, "",
                              "Please enter your financial worth to proceed.");
                          return;
                        }
                        toInvestment();
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
