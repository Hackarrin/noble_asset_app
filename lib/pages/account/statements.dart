import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Statements extends StatefulWidget {
  const Statements({Key? key}) : super(key: key);

  @override
  _StatementsState createState() => _StatementsState();
}

class _StatementsState extends State<Statements> {
  List<String> reviewFilter = ["verified", "latest"];
  bool isDescriptionExpanded = false;

  Map<String, dynamic> filter = {
    "checkin": "",
    "checkout": "",
    "adults": 1,
    "children": 0,
    "rooms": 0
  };
  String _selectedMethod = "paystack";
  String _paymentRef = "";
  bool _verifyWallet = false;
  double _walletBalance = 0;

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
        title:
            Widgets.buildText("Statements & Reports", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 15.0, left: 15.0, right: 15.0, bottom: 80.0),
          child: SingleChildScrollView(
            child: PaymentInformation(
              method: _selectedMethod,
              setMethod: (method) {
                setState(() {
                  _selectedMethod = method;
                });
              },
              walletBalance: _walletBalance,
              setPaymentReference: () => {},
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentInformation extends StatelessWidget {
  const PaymentInformation(
      {super.key,
      required this.method,
      required this.setMethod,
      required this.walletBalance,
      required this.setPaymentReference});

  final String method;
  final Function setMethod;
  final Function setPaymentReference;
  final double walletBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Widgets.buildText("Statement & Reports", context,
                  color: "text.secondary", isMedium: true),
              const SizedBox(height: 10.0),
              Widgets.buildText(
                  "Generate your account and portfolio statment by selecting the options below:",
                  context,
                  lines: 3,
                  color: "text.disabled"),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Sheets.showAccountStatement();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Palette.get("background.paper"),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0x0D000000))),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Helpers.fetchIcons("newspaper", "regular",
                    size: 30.0, color: "main.secondary"),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Account Statement", context,
                          color: "text.secondary", isMedium: true),
                      Widgets.buildText(
                          "See a breakdown of your wallet credit and debit.",
                          context,
                          color: "text.disabled",
                          size: 13.0,
                          lines: 3,
                          weight: 500),
                    ],
                  ),
                ),
                Helpers.fetchIcons("caret-right", "regular", size: 20.0)
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Sheets.showPortfolioStatement();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Palette.get("background.paper"),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0x0D000000))),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Helpers.fetchIcons("corporate-alt", "regular",
                    size: 30.0, color: "main.secondary"),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Portfolio Statement", context,
                          color: "text.secondary", isMedium: true),
                      Widgets.buildText(
                          "Download a breakdown of your portfolio.", context,
                          color: "text.disabled",
                          size: 13.0,
                          lines: 3,
                          weight: 500),
                    ],
                  ),
                ),
                Helpers.fetchIcons("caret-right", "regular", size: 20.0)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
