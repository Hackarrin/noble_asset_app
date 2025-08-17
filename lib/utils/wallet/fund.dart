import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paystack_flutter_sdk/paystack_flutter_sdk.dart';

class WalletTopup {
  static Future<Map<String, dynamic>> fundAccount(
      List cards,
      Map<dynamic, dynamic> account,
      Map<String, dynamic> limits,
      String currency,
      {bool showLimits = false}) async {
    Map<String, dynamic> result = {};
    bool isShowAccount = false;
    bool isShowLimits = showLimits;
    bool isShowSending = true;
    final currencyDetails = Defaults.walletTypes
        .firstWhere((item) => item["value"].toString() == currency);
    final _paystack = Paystack();

    void processPaystack() async {
      try {
        Alert.showLoading(navigatorKey.currentContext!, "Initializing...");
        final init = await _paystack.initialize(Defaults.paystackKey, true);
        if (init) {
          final accessCode = await JWT.getAccessCode(0);
          if (accessCode.isNotEmpty) {
            final response = await _paystack.launch(accessCode);
            Alert.hideLoading(navigatorKey.currentContext!);
            if (response.status == "success") {
              // confirmOrder(response.reference);
            }
            return;
          }
        }
        throw Exception(
            "An error occured while attempting to process payment! Please try again later.");
      } catch (err) {
        Alert.hideLoading(navigatorKey.currentContext!);
        Alert.show(
            navigatorKey.currentContext!,
            "",
            err.toString().isNotEmpty
                ? err.toString()
                : "An error has occured! Please try again later.");
      }
    }

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Palette.getColor(
            navigatorKey.currentContext!, "background", "default"),
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Palette.getColor(context, "background", "paper"),
                    padding: const EdgeInsets.only(bottom: 15.0, top: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xfff1f1f1), width: 1),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
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
                        Widgets.buildText(
                            isShowLimits
                                ? "$currency Limit"
                                : "Fund your account",
                            context,
                            isMedium: true),
                        const SizedBox(width: 60.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (!isShowAccount && !isShowLimits)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      "Choose your preferred method to add funds to your Naira wallet.",
                                      context,
                                      lines: 10,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Widgets.buildText("DEBIT CARD", context,
                                      weight: 500, color: "text.secondary"),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Palette.get("background.paper"),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (var card in cards)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Helpers.fetchIcons(
                                                      "credit-card", "regular",
                                                      color: "text.secondary",
                                                      size: 16.0),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Widgets.buildText(
                                                          "***${card["last4"]}",
                                                          context,
                                                          weight: 500),
                                                      Widgets.buildText(
                                                          card["bank"], context,
                                                          color:
                                                              "text.secondary",
                                                          size: 12.0),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Helpers.fetchIcons(
                                                  "caret-right", "solid",
                                                  size: 16.0),
                                            ],
                                          ),
                                        const SizedBox(height: 10.0),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Helpers.fetchIcons(
                                                  "credit-card", "regular",
                                                  color: "main.primary",
                                                  size: 16.0),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Widgets.buildText(
                                                  "Topup with new debit card",
                                                  context,
                                                  weight: 500,
                                                  color: "main.primary")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Widgets.buildText("BANK TRANSFER", context,
                                      weight: 500, color: "text.secondary"),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (account.isNotEmpty) {
                                        setState(() => isShowAccount = true);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Helpers.fetchIcons(
                                                    "priority-arrows",
                                                    "regular",
                                                    color: "text.secondary",
                                                    size: 16.0),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Widgets.buildText(
                                                          "Instant bank transfer",
                                                          context,
                                                          weight: 500),
                                                      Widgets.buildText(
                                                          account.isEmpty
                                                              ? "Securely link your bank account to enable  seamless transactions and easy fund transfers."
                                                              : "Transfer funds to the bank details",
                                                          context,
                                                          color:
                                                              "text.secondary",
                                                          lines: 4,
                                                          size: 12.0),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Helpers.fetchIcons(
                                              "caret-right", "solid",
                                              size: 16.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (isShowAccount && !isShowLimits)
                              Column(
                                children: [
                                  Image.asset("assets/images/bank-transfer.png",
                                      height: 100, fit: BoxFit.contain),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0x1A41B11A),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Widgets.buildText(
                                        "Transfer funds to the bank details provided below to top up your Naira account. Please note that your bank's transfer limits may apply.",
                                        context,
                                        lines: 10,
                                        color: "text.secondary"),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Palette.get("background.paper"),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color:
                                                Palette.get("main.primary"))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      "Account Number", context,
                                                      color: "text.secondary",
                                                      weight: 500),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Expanded(
                                                      child: DashedDivider()),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        account["accountNumber"]
                                                            .toString()));
                                              },
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      account["accountNumber"]
                                                          .toString(),
                                                      context,
                                                      weight: 500),
                                                  const SizedBox(width: 5.0),
                                                  Helpers.fetchIcons(
                                                      "duplicate", "regular",
                                                      color: "main.primary",
                                                      size: 16.0)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      "Bank Name", context,
                                                      color: "text.secondary",
                                                      weight: 500),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Expanded(
                                                      child: DashedDivider()),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: account["bank"]
                                                        .toString()));
                                              },
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      account["bank"]
                                                          .toString(),
                                                      context,
                                                      weight: 500),
                                                  const SizedBox(width: 5.0),
                                                  Helpers.fetchIcons(
                                                      "duplicate", "regular",
                                                      color: "main.primary",
                                                      size: 16.0)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      "Account Name", context,
                                                      color: "text.secondary",
                                                      weight: 500),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Expanded(
                                                      child: DashedDivider()),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: account["accountName"]
                                                        .toString()));
                                              },
                                              child: Row(
                                                children: [
                                                  Widgets.buildText(
                                                      account["accountName"]
                                                          .toString(),
                                                      context,
                                                      weight: 500),
                                                  const SizedBox(width: 5.0),
                                                  Helpers.fetchIcons(
                                                      "duplicate", "regular",
                                                      color: "main.primary",
                                                      size: 16.0)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 40.0),
                                        SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () {},
                                                style: Widgets.buildButton(
                                                    context,
                                                    background: Palette.get(
                                                        "main.primary"),
                                                    vertical: 15.0,
                                                    radius: 50.0),
                                                child: Widgets.buildText(
                                                    "Share Details", context,
                                                    isMedium: true,
                                                    color: "text.white")))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Widgets.buildText("Powered by", context),
                                      const SizedBox(width: 5.0),
                                      Image.asset(
                                          "assets/images/paystack-full.png",
                                          height: 50.0,
                                          fit: BoxFit.contain)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => isShowLimits = true);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20.0),
                                        child: Row(children: [
                                          Helpers.fetchIcons(
                                              "naira-sign", "regular",
                                              size: 20.0, color: "text.black"),
                                          const SizedBox(width: 10.0),
                                          Widgets.buildText(
                                              "Learn about your NGN account limits",
                                              context)
                                        ])),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20.0),
                                        child: Row(children: [
                                          Helpers.fetchIcons(
                                              "user-headset", "regular",
                                              size: 20.0, color: "text.black"),
                                          const SizedBox(width: 10.0),
                                          Widgets.buildText(
                                              "Need help? Contact customer support",
                                              context)
                                        ])),
                                  )
                                ],
                              ),
                            if (isShowLimits)
                              Column(
                                children: [
                                  Widgets.buildText(
                                      "What Are the Sending and Receiving Limits for Your $currency Noble Assets Wallet Account?",
                                      context,
                                      lines: 10),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(
                                                () => isShowSending = true);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: isShowSending
                                                      ? Color(0x1A41B11A)
                                                      : Palette.get(
                                                          "background.paper"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: isShowSending
                                                      ? null
                                                      : Border.all(
                                                          color: Color(
                                                              0x0D000000))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/${currencyDetails["icon"]}",
                                                      height: 30.0,
                                                      fit: BoxFit.contain),
                                                  const SizedBox(width: 5.0),
                                                  Widgets.buildText(
                                                      "Limit to send", context,
                                                      weight: 500,
                                                      color: isShowSending
                                                          ? "main.primary"
                                                          : "text.primary")
                                                ],
                                              )),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(
                                                () => isShowSending = false);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: !isShowSending
                                                      ? Color(0x1A41B11A)
                                                      : Palette.get(
                                                          "background.paper"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: !isShowSending
                                                      ? null
                                                      : Border.all(
                                                          color: Color(
                                                              0x0D000000))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/${currencyDetails["icon"]}",
                                                      height: 30.0,
                                                      fit: BoxFit.contain),
                                                  const SizedBox(width: 5.0),
                                                  Widgets.buildText(
                                                      "Limit to receive",
                                                      context,
                                                      weight: 500,
                                                      color: !isShowSending
                                                          ? "main.primary"
                                                          : "text.primary")
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  if (isShowSending)
                                    Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    "Send Limit (Single transaction)",
                                                    context,
                                                    weight: 500),
                                                const SizedBox(height: 10.0),
                                                LinearProgressIndicator(
                                                  minHeight: 20.0,
                                                  value: (num.tryParse(limits[
                                                                          "single"]
                                                                      ["spent"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0) /
                                                      (num.tryParse(limits[
                                                                          "single"]
                                                                      ["total"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0),
                                                  backgroundColor: Palette.get(
                                                      "background.default"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["single"]
                                                                      ["spent"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["single"]
                                                                      ["total"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary")
                                                    ]),
                                              ],
                                            )),
                                        const SizedBox(height: 15.0),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    "Daily Limit of ${Helpers.formatCurrency(limits["daily"]["total"].toString(), currency: currency)}",
                                                    context,
                                                    weight: 500),
                                                const SizedBox(height: 10.0),
                                                LinearProgressIndicator(
                                                  minHeight: 20.0,
                                                  value: (num.tryParse(limits[
                                                                          "daily"]
                                                                      ["spent"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0) /
                                                      (num.tryParse(limits[
                                                                          "daily"]
                                                                      ["total"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0),
                                                  backgroundColor: Palette.get(
                                                      "background.default"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["daily"]
                                                                      ["spent"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["daily"]
                                                                      ["total"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary")
                                                    ]),
                                              ],
                                            )),
                                        const SizedBox(height: 15.0),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    "Weekly Limit of ${Helpers.formatCurrency(limits["weekly"]["total"].toString(), currency: currency)}",
                                                    context,
                                                    weight: 500),
                                                const SizedBox(height: 10.0),
                                                LinearProgressIndicator(
                                                  minHeight: 20.0,
                                                  value: (num.tryParse(limits[
                                                                          "weekly"]
                                                                      ["spent"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0) /
                                                      (num.tryParse(limits[
                                                                          "weekly"]
                                                                      ["total"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0),
                                                  backgroundColor: Palette.get(
                                                      "background.default"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["weekly"]
                                                                      ["spent"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["weekly"]
                                                                      ["total"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary")
                                                    ]),
                                              ],
                                            )),
                                        const SizedBox(height: 15.0),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    "Monthly Limit of ${Helpers.formatCurrency(limits["monthly"]["total"].toString(), currency: currency)}",
                                                    context,
                                                    weight: 500),
                                                const SizedBox(height: 10.0),
                                                LinearProgressIndicator(
                                                  minHeight: 20.0,
                                                  value: (num.tryParse(limits[
                                                                          "monthly"]
                                                                      ["spent"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0) /
                                                      (num.tryParse(limits[
                                                                          "monthly"]
                                                                      ["total"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0),
                                                  backgroundColor: Palette.get(
                                                      "background.default"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["monthly"]
                                                                      ["spent"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["monthly"]
                                                                      ["total"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary")
                                                    ]),
                                              ],
                                            )),
                                      ],
                                    ),
                                  if (!isShowSending)
                                    Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    "Deposit(Per transaction) Limit",
                                                    context,
                                                    weight: 500),
                                                const SizedBox(height: 10.0),
                                                LinearProgressIndicator(
                                                  minHeight: 20.0,
                                                  value: 1.0,
                                                  backgroundColor: Palette.get(
                                                      "background.default"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                const SizedBox(height: 3.0),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["deposit"]
                                                                      ["spent"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          Helpers.formatCurrency(
                                                              limits["deposit"]
                                                                      ["total"]
                                                                  .toString(),
                                                              currency:
                                                                  currency),
                                                          context,
                                                          size: 12.0,
                                                          color:
                                                              "text.secondary")
                                                    ]),
                                              ],
                                            )),
                                      ],
                                    )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
    return result;
  }
}
