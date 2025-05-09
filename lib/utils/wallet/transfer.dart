import 'package:afritas/main.dart';
import 'package:afritas/utils/alert.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletTransfer {
  static Future<Map<String, dynamic>> show(
      List recipients, String balance, String currency,
      {bool isAddRecipient = false,
      Map<String, dynamic> account = const {},
      String withdrawFee = "",
      String amount = "",
      List banks = const []}) async {
    TextEditingController accountNumberController = TextEditingController();
    TextEditingController bankController = TextEditingController();
    TextEditingController sortCodeController = TextEditingController();
    TextEditingController routingNumberController = TextEditingController();
    TextEditingController accountNameController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    var amountController = MoneyMaskedTextController(
        decimalSeparator: ".",
        thousandSeparator: ",",
        leftSymbol: currency.isEmpty
            ? "\$"
            : Defaults.walletTypes
                .firstWhere(
                    (item) => item["value"].toString() == currency)["symbol"]
                .toString());

    if (account.isNotEmpty) {
      accountNumberController.text = account["accountNumber"].toString();
      accountNameController.text = account["accountName"].toString();
      bankController.text = account["bank"]["name"].toString();
      sortCodeController.text = account["sortCode"].toString();
      routingNumberController.text = account["routingNumber"].toString();
    }
    if (amount.isNotEmpty) {
      amountController.updateValue(num.tryParse(amount)?.toDouble() ?? 0);
    }

    Map<String, dynamic> result = {};
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
                        Column(
                          children: [
                            Widgets.buildText("Make a Payment", context,
                                isMedium: true),
                            Widgets.buildText(
                                "${Helpers.formatCurrency(balance, currency: currency)} available",
                                context,
                                weight: 500,
                                size: 12.0,
                                color: "text.secondary"),
                          ],
                        ),
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
                            if (isAddRecipient || account.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      "Recipient Account", context,
                                      isMedium: true),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Palette.getColor(
                                          context, "background", "paper"),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IntrinsicHeight(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller:
                                                    accountNumberController,
                                                readOnly: account.isNotEmpty,
                                                decoration: Widgets.inputDecoration(
                                                    "",
                                                    hint:
                                                        "Enter your account number",
                                                    hintColor: Palette.get(
                                                        "text.other"),
                                                    isOutline: true,
                                                    borderColor:
                                                        Colors.transparent,
                                                    isFloating: true,
                                                    color: Palette.getColor(
                                                        context,
                                                        "text",
                                                        "other")),
                                                onChanged: (text) {
                                                  setState(() {
                                                    result["isNewRecipient"] =
                                                        "1";
                                                    result["recipient"] = result
                                                            .containsKey(
                                                                "recipient")
                                                        ? {
                                                            ...result[
                                                                "recipient"],
                                                            "accountNumber":
                                                                text
                                                          }
                                                        : {
                                                            "bank": {
                                                              "name": "",
                                                              "code": ""
                                                            },
                                                            "accountNumber":
                                                                text,
                                                            "accountName": "",
                                                            "currency":
                                                                currency,
                                                            "sortCode": "",
                                                            "routingNumber": "",
                                                          };
                                                  });
                                                },
                                                style: GoogleFonts.poppins(
                                                    color: Palette.getColor(
                                                        context,
                                                        "text",
                                                        "other")),
                                              ),
                                              Divider(
                                                  thickness: 1.0,
                                                  color: Color(0x14000000)),
                                              if (currency == "NGN")
                                                TextFormField(
                                                  readOnly: true,
                                                  controller: bankController,
                                                  decoration:
                                                      Widgets.inputDecoration(
                                                          "",
                                                          hint: "Select Bank",
                                                          hintColor:
                                                              Palette.get(
                                                                  "text.other"),
                                                          suffixIcon: account
                                                                  .isEmpty
                                                              ? UnconstrainedBox(
                                                                  child: Helpers.fetchIcons(
                                                                      "caret-right",
                                                                      "solid",
                                                                      size:
                                                                          16.0),
                                                                )
                                                              : null,
                                                          isOutline: true,
                                                          borderColor: Colors
                                                              .transparent,
                                                          isFloating: true,
                                                          color:
                                                              Palette.getColor(
                                                                  context,
                                                                  "text",
                                                                  "other")),
                                                  onTap: () async {
                                                    if (account.isNotEmpty) {
                                                      return;
                                                    }
                                                    final res =
                                                        await Sheets.showSortBy(
                                                            "",
                                                            items: banks,
                                                            title:
                                                                "Select a Bank",
                                                            isShowClear: false,
                                                            isShowIcon: true);
                                                    if (res.isNotEmpty) {
                                                      final selectedBank =
                                                          banks[num.tryParse(
                                                                      res)
                                                                  ?.toInt() ??
                                                              0];
                                                      bankController.text =
                                                          selectedBank["name"];
                                                      setState(() {
                                                        result["isNewRecipient"] =
                                                            "1";
                                                        result["recipient"] =
                                                            result.containsKey(
                                                                    "recipient")
                                                                ? {
                                                                    ...result[
                                                                        "recipient"],
                                                                    "bank": {
                                                                      "name": selectedBank[
                                                                          "name"],
                                                                      "code": selectedBank[
                                                                          "code"]
                                                                    }
                                                                  }
                                                                : {
                                                                    "bank": {
                                                                      "name": selectedBank[
                                                                          "name"],
                                                                      "code": selectedBank[
                                                                          "code"]
                                                                    },
                                                                    "accountNumber":
                                                                        "",
                                                                    "accountName":
                                                                        "",
                                                                    "currency":
                                                                        currency,
                                                                    "sortCode":
                                                                        "",
                                                                    "routingNumber":
                                                                        "",
                                                                  };
                                                      });
                                                    }
                                                  },
                                                  style: GoogleFonts.poppins(
                                                      color: Palette.getColor(
                                                          context,
                                                          "text",
                                                          "other")),
                                                ),
                                              if (currency == "USD")
                                                TextFormField(
                                                    controller:
                                                        routingNumberController,
                                                    readOnly:
                                                        account.isNotEmpty,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            hint:
                                                                "Enter your bank routing number",
                                                            hintColor:
                                                                Palette.get(
                                                                    "text.other"),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "other")),
                                                    style: GoogleFonts.poppins(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "other")),
                                                    onChanged: (text) {
                                                      setState(() {
                                                        result["isNewRecipient"] =
                                                            "1";
                                                        result["recipient"] =
                                                            result.containsKey(
                                                                    "recipient")
                                                                ? {
                                                                    ...result[
                                                                        "recipient"],
                                                                    "routingNumber":
                                                                        text
                                                                  }
                                                                : {
                                                                    "bank": {
                                                                      "name":
                                                                          "",
                                                                      "code": ""
                                                                    },
                                                                    "accountNumber":
                                                                        "",
                                                                    "accountName":
                                                                        "",
                                                                    "currency":
                                                                        currency,
                                                                    "sortCode":
                                                                        "",
                                                                    "routingNumber":
                                                                        text,
                                                                  };
                                                      });
                                                    }),
                                              if (currency == "GBP")
                                                TextFormField(
                                                    controller:
                                                        sortCodeController,
                                                    readOnly:
                                                        account.isNotEmpty,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            hint:
                                                                "Enter your bank sort code",
                                                            hintColor:
                                                                Palette.get(
                                                                    "text.other"),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "other")),
                                                    style: GoogleFonts.poppins(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "other")),
                                                    onChanged: (text) {
                                                      setState(() {
                                                        result["isNewRecipient"] =
                                                            "1";
                                                        result[
                                                                "recipient"] =
                                                            result.containsKey(
                                                                    "recipient")
                                                                ? {
                                                                    ...result[
                                                                        "recipient"],
                                                                    "sortCode":
                                                                        text
                                                                  }
                                                                : {
                                                                    "bank": {
                                                                      "name":
                                                                          "",
                                                                      "code": ""
                                                                    },
                                                                    "accountNumber":
                                                                        "",
                                                                    "accountName":
                                                                        "",
                                                                    "currency":
                                                                        currency,
                                                                    "sortCode":
                                                                        text,
                                                                    "routingNumber":
                                                                        "",
                                                                  };
                                                      });
                                                    }),
                                              Divider(
                                                  thickness: 1.0,
                                                  color: Color(0x14000000)),
                                              TextFormField(
                                                  controller:
                                                      accountNameController,
                                                  readOnly: currency == "NGN" ||
                                                      account.isNotEmpty,
                                                  decoration:
                                                      Widgets.inputDecoration(
                                                          "",
                                                          hint: "Account Name",
                                                          hintColor:
                                                              Palette.get(
                                                                  "text.other"),
                                                          isOutline: true,
                                                          borderColor: Colors
                                                              .transparent,
                                                          isFloating: true,
                                                          color:
                                                              Palette.getColor(
                                                                  context,
                                                                  "text",
                                                                  "other")),
                                                  style: GoogleFonts.poppins(
                                                      color: Palette.getColor(
                                                          context,
                                                          "text",
                                                          "other")),
                                                  onChanged: (text) {
                                                    setState(() {
                                                      result["isNewRecipient"] =
                                                          "1";
                                                      result["recipient"] =
                                                          result.containsKey(
                                                                  "recipient")
                                                              ? {
                                                                  ...result[
                                                                      "recipient"],
                                                                  "accountName":
                                                                      text
                                                                }
                                                              : {
                                                                  "bank": {
                                                                    "name": "",
                                                                    "code": ""
                                                                  },
                                                                  "accountNumber":
                                                                      "",
                                                                  "accountName":
                                                                      text,
                                                                  "currency":
                                                                      currency,
                                                                  "sortCode":
                                                                      "",
                                                                  "routingNumber":
                                                                      "",
                                                                };
                                                    });
                                                  }),
                                              if (account.isEmpty)
                                                Divider(
                                                    thickness: 1.0,
                                                    color: Color(0x14000000)),
                                              if (account.isEmpty)
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          if (result.isEmpty ||
                                                              result["recipient"]
                                                                      [
                                                                      "accountNumber"]
                                                                  .toString()
                                                                  .isEmpty) {
                                                            Alert.show(
                                                                context,
                                                                "",
                                                                "Please set a valid account number to proceed.",
                                                                type:
                                                                    "warning");
                                                            return;
                                                          }
                                                          if (result["recipient"]
                                                                          [
                                                                          "currency"]
                                                                      .toString() ==
                                                                  "NGN" &&
                                                              result["recipient"]
                                                                          [
                                                                          "bank"]
                                                                      ["code"]
                                                                  .toString()
                                                                  .isEmpty) {
                                                            Alert.show(
                                                                context,
                                                                "",
                                                                "Please set a valid bank account to proceed.",
                                                                type:
                                                                    "warning");
                                                            return;
                                                          }
                                                          if (result["recipient"]
                                                                          [
                                                                          "currency"]
                                                                      .toString() ==
                                                                  "USD" &&
                                                              result["recipient"]
                                                                      [
                                                                      "routingNumber"]
                                                                  .toString()
                                                                  .isEmpty) {
                                                            Alert.show(
                                                                context,
                                                                "",
                                                                "Please set a valid routing number to proceed.",
                                                                type:
                                                                    "warning");
                                                            return;
                                                          }
                                                          if (result["recipient"]
                                                                          [
                                                                          "currency"]
                                                                      .toString() !=
                                                                  "NGN" &&
                                                              result["recipient"]
                                                                      [
                                                                      "accountName"]
                                                                  .toString()
                                                                  .isEmpty) {
                                                            Alert.show(
                                                                context,
                                                                "",
                                                                "Please set a valid account name to proceed.",
                                                                type:
                                                                    "warning");
                                                            return;
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: Widgets.buildButton(
                                                            context,
                                                            radius: 50.0,
                                                            background: Palette.get(
                                                                "main.primary"),
                                                            vertical: 15.0),
                                                        child: Widgets.buildText(
                                                            "Next", context,
                                                            color: "text.white",
                                                            isMedium: true)))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (account.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20.0),
                                        Widgets.buildText("Amount", context,
                                            weight: 500, size: 14.0),
                                        const SizedBox(height: 10.0),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Palette.getColor(
                                                context, "background", "paper"),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          child: TextFormField(
                                              controller: amountController,
                                              readOnly: amount.isNotEmpty,
                                              decoration:
                                                  Widgets.inputDecoration("",
                                                      hint: "Amount to send",
                                                      hintColor: Palette.get(
                                                          "text.other"),
                                                      isOutline: true,
                                                      borderColor:
                                                          Colors.transparent,
                                                      isFloating: true,
                                                      color: Palette.getColor(
                                                          context,
                                                          "text",
                                                          "other")),
                                              style: GoogleFonts.poppins(
                                                  color: Palette.getColor(
                                                      context,
                                                      "text",
                                                      "other")),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (text) {
                                                setState(() {
                                                  result["amount"] = text;
                                                });
                                              }),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Widgets.buildText("Reference", context,
                                            weight: 500, size: 13.0),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Palette.getColor(
                                                context, "background", "paper"),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          child: TextFormField(
                                              controller: noteController,
                                              decoration: Widgets.inputDecoration(
                                                  "",
                                                  hint:
                                                      "What is this for? (optional)",
                                                  hintColor:
                                                      Palette.get("text.other"),
                                                  isOutline: true,
                                                  borderColor:
                                                      Colors.transparent,
                                                  isFloating: true,
                                                  color: Palette.getColor(
                                                      context,
                                                      "text",
                                                      "other")),
                                              style: GoogleFonts.poppins(
                                                  color: Palette.getColor(
                                                      context,
                                                      "text",
                                                      "other")),
                                              onChanged: (text) {
                                                setState(() {
                                                  result["note"] = text;
                                                });
                                              }),
                                        ),
                                        const SizedBox(height: 20.0),
                                        SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                                onPressed: () async {
                                                  if (result.isEmpty ||
                                                      result["amount"]
                                                          .toString()
                                                          .isEmpty) {
                                                    Alert.show(context, "",
                                                        "Please set a valid amount to proceed.",
                                                        type: "warning");
                                                    return;
                                                  } else {
                                                    final res = await Sheets
                                                        .showVerifyTransfer(
                                                            account,
                                                            balance,
                                                            currency,
                                                            result["amount"]
                                                                .toString(),
                                                            withdrawFee);
                                                    if (res) {
                                                      setState(() =>
                                                          result["amount"] =
                                                              amountController
                                                                  .numberValue
                                                                  .toString());
                                                      Navigator.pop(context);
                                                    }
                                                  }
                                                },
                                                style: Widgets.buildButton(
                                                    context,
                                                    radius: 50.0,
                                                    background: Palette.get(
                                                        "main.primary"),
                                                    vertical: 15.0),
                                                child: Widgets.buildText(
                                                    "Confirm", context,
                                                    color: "text.white",
                                                    isMedium: true)))
                                      ],
                                    )
                                ],
                              ),
                            if (!isAddRecipient && account.isEmpty)
                              GestureDetector(
                                onTap: () {
                                  setState(() => result = {
                                        "isNewRecipient": "1",
                                        "recipient": {}
                                      });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Helpers.fetchIcons(
                                              "plus-small", "solid",
                                              size: 24.0),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  "Pay someone new", context,
                                                  weight: 500, size: 14.0),
                                              Widgets.buildText(
                                                  "Create and pay a new  recipient",
                                                  context,
                                                  weight: 500,
                                                  size: 11.0,
                                                  color: "text.secondary"),
                                            ],
                                          )
                                        ]),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Helpers.fetchIcons(
                                            "caret-right", "solid",
                                            size: 24.0)
                                      ],
                                    )),
                              ),
                            const SizedBox(height: 20.0),
                            if (account.isEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      isAddRecipient ? "Recent" : "Recipients",
                                      context,
                                      isMedium: true),
                                  const SizedBox(height: 20.0),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final recipient = recipients[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                result = {
                                                  "recipient": recipient,
                                                  "isNewRecipient": "0"
                                                };
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      "background.paper"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Helpers.getPhoto(
                                                          recipient["photo"]
                                                              .toString(),
                                                          height: 30.0),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Widgets.buildText(
                                                              recipient[
                                                                      "accountName"]
                                                                  .toString(),
                                                              context,
                                                              weight: 500,
                                                              size: 13.0),
                                                          const SizedBox(
                                                            height: 1.0,
                                                          ),
                                                          Widgets.buildText(
                                                              "${recipient["bankName"].toString()} - ${recipient["accountNumber"].toString()}",
                                                              context,
                                                              weight: 500,
                                                              size: 13.0,
                                                              color:
                                                                  "text.secondary"),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Helpers.fetchIcons(
                                                      "menu-dots-vertical",
                                                      "solid",
                                                      size: 16.0)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recipients.length)
                                ],
                              )
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
