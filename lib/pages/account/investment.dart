import 'dart:convert';

import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/fetch.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Investment extends StatefulWidget {
  const Investment({Key? key}) : super(key: key);

  @override
  _InvestmentState createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> investment = {};

  bool loading = true;
  String error = "";
  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getInvestment(investment["pid"] ?? "");
      print("response $res");
      setState(() {
        investment = res;
        loading = false;
      });
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print("response $err");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final data = jsonDecode(arguments.toString());
          setState(() {
            investment = data;
          });
          fetch();
        } catch (err) {
          print("dante - $err");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xfff1f1f1), width: 1),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(left: 15.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Helpers.fetchIcons(
                "arrow-small-left",
                "solid",
                size: 24,
                color: "text.other",
              )),
        ),
        title: Widgets.buildText(
            "Investment Details - #${investment["pid"]}", context,
            isMedium: true),
        actions: [],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
              bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
          child: SingleChildScrollView(
            child: loading
                ? Shimmer.fromColors(
                    baseColor: Palette.get("background.neutral"),
                    highlightColor: Palette.get("background.default"),
                    loop: 1,
                    child: AbsorbPointer(child: buildContent()),
                  )
                : (error.isNotEmpty
                    ? Alert.showErrorMessage(context, "",
                        padding: 50.0,
                        buttonText: "Retry",
                        message: error,
                        action: fetch)
                    : buildContent()),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    bool isCancel = investment["status"].toString() == "1";
    final stat = Defaults.investmentStatus.firstWhere((stat) =>
        stat["value"].toString() == (investment["status"] ?? "0").toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            color: Palette.get("${stat["color"]}.main"),
                            borderRadius: BorderRadius.circular(10.0))),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Widgets.buildText(stat["label"].toString(), context,
                        color: "text.secondary")
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Widgets.buildText(
                          investment["name"] ?? "", context,
                          lines: 10, isMedium: true),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("calendar-clock", "solid"),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Widgets.buildText("Start Date", context,
                                size: 13.0,
                                weight: 500,
                                color: "text.disabled"),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            Helpers.formatDate(
                                investment["dateAdded"].toString(),
                                formatString: "EEE, d MMM yyyy"),
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("calendar-clock", "solid"),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Widgets.buildText("Maturity date", context,
                                size: 13.0,
                                weight: 500,
                                color: "text.disabled"),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            investment["dateEnds"].toString().isEmpty
                                ? ""
                                : Helpers.formatDate(
                                    investment["dateEnds"].toString(),
                                    formatString: "EEE, d MMM yyyy"),
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("Tenor (days)", context,
                            size: 13.0, weight: 500, color: "text.disabled"),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            investment.containsKey("days")
                                ? investment["days"].toString()
                                : "",
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("Duration", context,
                            size: 13.0, weight: 500, color: "text.disabled"),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            investment.containsKey("daysLeft")
                                ? investment["daysLeft"].toString()
                                : "",
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10.0,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("Interest Rate (%)", context,
                            size: 13.0, weight: 500, color: "text.disabled"),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            investment.containsKey("rate")
                                ? "${investment["rate"].toString()}%"
                                : "",
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                  ],
                )
              ],
            )),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.get("background.paper"),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0x0D000000))),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Principal", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      Helpers.formatCurrency(investment["amount"].toString()),
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Interest Earned", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      Helpers.formatCurrency(investment["interest"].toString()),
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Interest Paid", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      "- ${Helpers.formatCurrency(investment["interestPaid"].toString())}",
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Face Value", context,
                      color: "text.disabled", size: 15.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                    Helpers.formatCurrency(investment["total"].toString()),
                    context,
                    color: "main.primary",
                    size: 15.0,
                    isMedium: true,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Actions", context, isMedium: true),
            const SizedBox(
              height: 10.0,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Palette.getColor(context, "background", "paper"),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              Alert.showLoading(context, "Requesting...");
                              final ret = await Fetch(
                                      "${API.getInvestmentsLetter}?investmentId=${investment["pid"].toString()}",
                                      {},
                                      method: "get")
                                  .load();
                              Alert.hideLoading(context);
                              if (ret["status"] == "success") {
                                Alert.show(context, "",
                                    "We've sent you the investment letter as requested to your mail!");
                              } else {
                                Alert.show(context, "",
                                    "An error occurred while sending the letter. Please try again later.");
                              }
                            } catch (e) {
                              Alert.show(context, "",
                                  "An error occurred! Please try again later.");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Helpers.fetchIcons("envelope-open-text", "solid",
                                  size: 22.0),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Widgets.buildText(
                                  "Request Investment Letter", context,
                                  size: 15.0,
                                  weight: 500,
                                  color: "text.disabled"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              height: 10.0,
            ),
            if (!isCancel)
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Palette.getColor(context, "background", "paper"),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              try {
                                final percent = await Helpers.getDefault(
                                    "savings_cancellation_percent");
                                await Sheets.showCancelInvestment(
                                    context,
                                    investment["name"].toString(),
                                    percent,
                                    investment["pid"].toString());
                                fetch();
                              } catch (e) {
                                Alert.show(context, "",
                                    "An error occurred! Please try again later.");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("ban", "solid",
                                    size: 22.0, color: "error.main"),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Widgets.buildText("Cancel Investment", context,
                                    size: 15.0,
                                    weight: 500,
                                    color: "error.main"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
          ],
        )
      ],
    );
  }
}
