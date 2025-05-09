import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
        title: Widgets.buildText("Payment Method", context, isMedium: true),
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
              Widgets.buildText("How would you like to pay?", context,
                  color: "text.secondary", isMedium: true),
              const SizedBox(height: 10.0),
              Widgets.buildText(
                  "Select your preferred payment method below to proceed.",
                  context,
                  lines: 3,
                  color: "text.disabled"),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            setMethod("paystack");
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
                Image.asset("assets/images/paystack.png",
                    height: 30.0, fit: BoxFit.contain),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Pay with Paystack", context,
                          color: "text.secondary", isMedium: true),
                      const SizedBox(height: 5.0),
                      Widgets.buildText("Cards & Transfer", context,
                          color: "text.disabled", size: 13.0, weight: 500),
                    ],
                  ),
                ),
                Checkbox(
                    value: method == "paystack",
                    onChanged: (checked) {
                      setMethod("paystack");
                    })
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            setMethod("wallet");
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
                Image.asset("assets/images/logo.png",
                    height: 44.0, fit: BoxFit.contain),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Wallet", context,
                          color: "text.secondary", isMedium: true),
                      const SizedBox(height: 5.0),
                      Widgets.buildText(
                          "Use Your Wallet for Fast & Secure Payments", context,
                          color: "text.disabled",
                          size: 13.0,
                          weight: 500,
                          lines: 3),
                    ],
                  ),
                ),
                Checkbox(
                    value: method == "wallet",
                    onChanged: (checked) {
                      setMethod("wallet");
                    })
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            setMethod("stripe");
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
                Image.asset("assets/images/stripe.jpeg",
                    height: 44.0, fit: BoxFit.contain),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Stripe", context,
                          color: "text.secondary", isMedium: true),
                      const SizedBox(height: 5.0),
                      Widgets.buildText(
                          "Seamless international Payments", context,
                          color: "text.disabled",
                          size: 13.0,
                          weight: 500,
                          lines: 3),
                    ],
                  ),
                ),
                Checkbox(
                    value: method == "stripe",
                    onChanged: (checked) {
                      setMethod("stripe");
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
