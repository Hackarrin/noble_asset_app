import 'package:cribsfinder/main.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/wallet/add_recipient.dart';
import 'package:cribsfinder/utils/wallet/recipients.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletExchange {
  static Future<Map<String, dynamic>> show(Map<String, dynamic> values,
      Map<String, dynamic> overview, Map<String, dynamic> exchangeDefaults,
      {Map<String, dynamic> otherPayoutAccount = const {},
      List<Map<String, dynamic>> recipients = const [],
      List<Map<String, dynamic>> banks = const [],
      Function? setOtherPayoutAccount,
      String errorMessage = ""}) async {
    Map<String, dynamic> result = {...values, "isCancelled": true};
    var amountController = MoneyMaskedTextController(
        decimalSeparator: ".",
        thousandSeparator: ",",
        leftSymbol: result["currencyFrom"].isEmpty
            ? ""
            : Defaults.walletTypes
                .firstWhere((item) =>
                    item["value"].toString() ==
                    result["currencyFrom"])["symbol"]
                .toString());
    var recipientAmountController = MoneyMaskedTextController(
        decimalSeparator: ".",
        thousandSeparator: ",",
        leftSymbol: result["currencyTo"].isEmpty
            ? ""
            : Defaults.walletTypes
                .firstWhere((item) =>
                    item["value"].toString() == result["currencyTo"])["symbol"]
                .toString());
    String isFocused = "from";
    Function generalState = () {};
    void handleExchangeCalculations() {
      try {
        final exchangeRate = result["currencyTo"].toString() ==
                result["currencyFrom"].toString()
            ? 1
            : num.tryParse(exchangeDefaults.containsKey(
                            "${result["currencyTo"]}_${result["currencyFrom"]}_rate")
                        ? exchangeDefaults[
                                "${result["currencyTo"]}_${result["currencyFrom"]}_rate"]
                            .toString()
                        : "0")
                    ?.toDouble() ??
                0;
        final double feeCap = exchangeDefaults.containsKey(
                "exchange_rate_fee_cap_${result["currencyFrom"].toString().toLowerCase()}")
            ? num.tryParse(exchangeDefaults[
                            "exchange_rate_fee_cap_${result["currencyFrom"].toString().toLowerCase()}"]
                        .toString())
                    ?.toDouble() ??
                0
            : 0;

        final amount = num.tryParse(isFocused == "from"
                    ? result["amount"].toString()
                    : result["recipientAmount"].toString())
                ?.toDouble() ??
            0;
        print({
          "exchangeDefaults": exchangeDefaults,
          "amount": amount,
          "exchangeRate": exchangeRate,
          "isFocused": isFocused,
        });

        if (isFocused == "from") {
          final double value =
              exchangeRate != 0 ? ((amount / exchangeRate) * 100) / 100 : 0;
          recipientAmountController.updateValue(value);
          result["recipientAmount"] = value;
        } else {
          final double value = (amount * exchangeRate * 100) / 100;
          amountController.updateValue(value);
          result["amount"] = value;
        }
        final feePercent =
            num.tryParse(exchangeDefaults["exchange_rate_fee"].toString())
                    ?.toDouble() ??
                0;
        double fees = (feePercent / 100) * amountController.numberValue;
        if (fees > feeCap) {
          fees = feeCap;
        }
        result["fees"] = fees;
        result["exchangeRate"] = exchangeRate;
        generalState(() {});
      } catch (err) {
        print("danted - $err");
      }
    }

    void handleAmountChange(masked, value) {
      generalState(() {
        isFocused = "from";
        result["amount"] = value;
      });
      handleExchangeCalculations();
    }

    void handleRecipientAmountChange(masked, value) {
      generalState(() {
        isFocused = "to";
        result["recipientAmount"] = value;
      });
      handleExchangeCalculations();
    }

    amountController.afterChange = handleAmountChange;
    recipientAmountController.afterChange = handleRecipientAmountChange;

    TextEditingController accountNumberController = TextEditingController();
    TextEditingController bankController = TextEditingController();
    TextEditingController sortCodeController = TextEditingController();
    TextEditingController routingNumberController = TextEditingController();
    TextEditingController accountNameController = TextEditingController();
    Future.delayed(Duration(milliseconds: 500), () {
      if (errorMessage.isNotEmpty) {
        Alert.show(navigatorKey.currentContext!, "", errorMessage,
            type: "warning");
      }
    });
    if (otherPayoutAccount.isNotEmpty &&
        result["isNewRecipient"].toString() == "1") {
      accountNumberController.text =
          otherPayoutAccount["accountNumber"].toString();
      accountNameController.text = otherPayoutAccount["accountName"].toString();
      bankController.text = otherPayoutAccount["bank"]["name"].toString();
      sortCodeController.text = otherPayoutAccount["sortCode"].toString();
      routingNumberController.text =
          otherPayoutAccount["routingNumber"].toString();
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
            generalState = setState;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Palette.getColor(context, "background", "paper"),
                  padding: const EdgeInsets.only(top: 60.0),
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
                      Expanded(
                        child: Column(
                          children: [
                            Widgets.buildText(
                                result["isConfirmed"].toString() == "1"
                                    ? "Confirm Exchange"
                                    : (result["account"].toString().isNotEmpty
                                        ? "Confirm Account"
                                        : ((result["total"].toString() == "0"
                                            ? "Send Money"
                                            : "Choose Recipient"))),
                                context,
                                isMedium: true),
                            Widgets.buildText(
                                result["isConfirmed"].toString() == "1"
                                    ? "Please confirm your exchange before proceeding"
                                    : (result["account"].toString().isNotEmpty
                                        ? "Please confirm your recipient account before proceeding"
                                        : (result["total"].toString() != "0"
                                            ? "Please select or add a new recipient to proceed"
                                            : "Enter the amount you want to send")),
                                context,
                                weight: 500,
                                size: 12.0,
                                lines: 10,
                                isCenter: true,
                                color: "text.secondary"),
                          ],
                        ),
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
                        children: [
                          if (result["total"].toString() == "0" &&
                              overview.keys.isNotEmpty)
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Palette.get("background.paper"),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        padding: const EdgeInsets.only(
                                            top: 15.0,
                                            left: 15.0,
                                            right: 15.0,
                                            bottom: 30.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Widgets.buildText(
                                                    "You send", context),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final selected =
                                                        await Sheets
                                                            .showWallets(
                                                      Defaults.walletTypes
                                                          .where((item) =>
                                                              overview.keys
                                                                  .contains(item[
                                                                      "value"]))
                                                          .toList(),
                                                      title: "Choose Currency",
                                                      subtitle:
                                                          "Choose the currency you want to send money from.",
                                                    );
                                                    amountController =
                                                        MoneyMaskedTextController(
                                                            decimalSeparator:
                                                                ".",
                                                            thousandSeparator:
                                                                ",",
                                                            leftSymbol: Defaults
                                                                .walletTypes
                                                                .firstWhere(
                                                                    (item) =>
                                                                        item["value"]
                                                                            .toString() ==
                                                                        selected)[
                                                                    "symbol"]
                                                                .toString());
                                                    amountController
                                                            .afterChange =
                                                        handleAmountChange;
                                                    setState(() {
                                                      result["currencyFrom"] =
                                                          selected;
                                                    });
                                                    handleExchangeCalculations();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0x1A000000)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Row(
                                                      children: [
                                                        if (Defaults.walletTypes
                                                            .where((item) =>
                                                                item["value"]
                                                                    .toString() ==
                                                                result["currencyFrom"]
                                                                    .toString())
                                                            .isNotEmpty)
                                                          ClipOval(
                                                            child: Image.asset(
                                                                "assets/images/${Defaults.walletTypes.firstWhere((item) => item["value"].toString() == result["currencyFrom"].toString())["icon"]}",
                                                                width: 20.0,
                                                                height: 20.0,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Widgets.buildText(
                                                            result["currencyFrom"]
                                                                .toString(),
                                                            context),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Helpers.fetchIcons(
                                                            "caret-down",
                                                            "solid",
                                                            size: 12.0)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            TextFormField(
                                              controller: amountController,
                                              decoration:
                                                  Widgets.inputDecoration("",
                                                      hint: "",
                                                      hintColor: Palette.get(
                                                          "text.primary"),
                                                      isOutline: true,
                                                      borderColor:
                                                          Color(0x1A000000),
                                                      radius: 50.0,
                                                      isFloating: true,
                                                      color: Palette.getColor(
                                                          context,
                                                          "text",
                                                          "primary")),
                                              style: GoogleFonts.nunito(
                                                  color: Palette.getColor(
                                                      context,
                                                      "text",
                                                      "primary"),
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Widgets.buildText(
                                                "Balance: ${Helpers.formatCurrency(overview[result["currencyFrom"].toString()].toString(), currency: result["currencyFrom"].toString())}",
                                                context,
                                                color: "main.primary")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Palette.get("background.paper"),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15.0,
                                                  bottom: 60.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Widgets.buildText(
                                                          "Receiver Gets",
                                                          context),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          final selected =
                                                              await Sheets
                                                                  .showWallets(
                                                            Defaults.walletTypes
                                                                .where((item) =>
                                                                    overview
                                                                        .keys
                                                                        .contains(
                                                                            item["value"]))
                                                                .toList(),
                                                            title:
                                                                "Choose Currency",
                                                            subtitle:
                                                                "Choose the currency you want to convert to.",
                                                          );
                                                          recipientAmountController = MoneyMaskedTextController(
                                                              decimalSeparator:
                                                                  ".",
                                                              thousandSeparator:
                                                                  ",",
                                                              leftSymbol: Defaults
                                                                  .walletTypes
                                                                  .firstWhere(
                                                                      (item) =>
                                                                          item["value"]
                                                                              .toString() ==
                                                                          selected)[
                                                                      "symbol"]
                                                                  .toString());
                                                          recipientAmountController
                                                                  .afterChange =
                                                              handleRecipientAmountChange;
                                                          setState(() => result[
                                                                  "currencyTo"] =
                                                              selected);
                                                          handleExchangeCalculations();
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0x1A000000)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Row(
                                                            children: [
                                                              if (Defaults
                                                                  .walletTypes
                                                                  .where((item) =>
                                                                      item["value"]
                                                                          .toString() ==
                                                                      result["currencyTo"]
                                                                          .toString())
                                                                  .isNotEmpty)
                                                                ClipOval(
                                                                  child: Image.asset(
                                                                      "assets/images/${Defaults.walletTypes.firstWhere((item) => item["value"].toString() == result["currencyTo"].toString())["icon"]}",
                                                                      width:
                                                                          20.0,
                                                                      height:
                                                                          20.0,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              const SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              Widgets.buildText(
                                                                  result["currencyTo"]
                                                                      .toString(),
                                                                  context),
                                                              const SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              Helpers.fetchIcons(
                                                                  "caret-down",
                                                                  "solid",
                                                                  size: 12.0)
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        recipientAmountController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            hint: "",
                                                            hintColor: Palette.get(
                                                                "text.primary"),
                                                            isOutline: true,
                                                            borderColor: Color(
                                                                0x1A000000),
                                                            radius: 50.0,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "primary")),
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "primary"),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Palette.get(
                                                        "main.primary"),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.0))),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Widgets.buildText(
                                                        "Exchange rate",
                                                        context,
                                                        isMedium: true,
                                                        size: 13.0),
                                                    Widgets.buildText(
                                                        "1 ${result["currencyFrom"]} = ${(num.tryParse(result["exchangeRate"].toString())?.toDouble() ?? 0) < 1 ? (num.tryParse(result["exchangeRate"].toString())?.toDouble() ?? 0).toStringAsFixed(5) : Helpers.formatNumber(result["exchangeRate"].toString())} ${result["currencyTo"]}",
                                                        context,
                                                        isMedium: true,
                                                        size: 13.0),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                                    Positioned(
                                      top: 170.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.default"),
                                              borderRadius:
                                                  BorderRadius.circular(80.0)),
                                          padding: const EdgeInsets.all(7.0),
                                          child: Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Palette.get(
                                                    "background.paper"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            padding: const EdgeInsets.all(10.0),
                                            child: Transform.rotate(
                                              angle: 20.4,
                                              child: Helpers.fetchIcons(
                                                  "exchange", "solid",
                                                  size: 16.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Widgets.buildText(
                                    "Transfer fees:  ${result["currencyFrom"].toString()} ${Helpers.formatNumber(result["fees"].toString())}",
                                    context,
                                    isMedium: true,
                                    size: 13.0)
                              ],
                            ),
                          if (result["total"].toString() != "0" &&
                              result["isNewRecipient"].toString() == "0" &&
                              result["account"].toString().isEmpty)
                            WalletRecipient(
                                setValues: (isNew, accountCode) {
                                  setState(() {
                                    result = {
                                      ...result,
                                      "isNewRecipient": isNew,
                                      "account": accountCode,
                                    };
                                  });
                                  if (isNew.toString() == "0") {
                                    result["isCancelled"] = false;
                                    Navigator.pop(context);
                                  }
                                },
                                setOtherPayoutAccount: (payoutAccount) {
                                  setOtherPayoutAccount!(payoutAccount);
                                },
                                currency: result["currencyTo"],
                                recipients: recipients,
                                otherPayoutAccount: otherPayoutAccount),
                          if (result["isConfirmed"].toString() == "0" &&
                              result["isNewRecipient"].toString() == "1")
                            WalletAddRecipient(
                                setOtherPayoutAccount: (payoutAccount) {
                                  setOtherPayoutAccount!(payoutAccount);
                                },
                                account: result["account"],
                                banks: banks,
                                otherPayoutAccount: {
                                  ...otherPayoutAccount,
                                  "currency": result["currencyTo"]
                                },
                                accountNumberController:
                                    accountNumberController,
                                bankController: bankController,
                                sortCodeController: sortCodeController,
                                routingNumberController:
                                    routingNumberController,
                                accountNameController: accountNameController),
                          if (result["isConfirmed"].toString() == "1")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Palette.get("background.paper"),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Palette.get("main.primary"))),
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText("Send", context,
                                              color: "text.disabled",
                                              size: 14.0),
                                          Widgets.buildText(
                                              Helpers.formatCurrency(
                                                  result["amount"].toString(),
                                                  currency:
                                                      result["currencyFrom"]),
                                              context,
                                              isMedium: true,
                                              size: 14.0)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText(
                                              "Transfer Fees", context,
                                              color: "text.disabled",
                                              size: 14.0),
                                          Widgets.buildText(
                                              Helpers.formatCurrency(
                                                  result["fees"].toString(),
                                                  currency:
                                                      result["currencyFrom"]),
                                              context,
                                              isMedium: true,
                                              size: 14.0)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText(
                                              "Total to Recipient", context,
                                              color: "text.disabled",
                                              size: 14.0),
                                          Widgets.buildText(
                                              Helpers.formatCurrency(
                                                  result["recipientAmount"]
                                                      .toString(),
                                                  currency:
                                                      result["currencyTo"]),
                                              context,
                                              isMedium: true,
                                              size: 14.0)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Widgets.buildText(
                                    "Exchange Rate: 1 ${result["currencyFrom"]} = ${(num.tryParse(result["exchangeRate"].toString())?.toDouble() ?? 0) < 1 ? (num.tryParse(result["exchangeRate"].toString())?.toDouble() ?? 0).toStringAsFixed(5) : Helpers.formatNumber(result["exchangeRate"].toString())} ${result["currencyTo"]}",
                                    context,
                                    isMedium: true,
                                    size: 13.0),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                          "assets/images/${Defaults.walletTypes.firstWhere((item) => item["value"] == result["currencyFrom"])["icon"]}",
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Helpers.fetchIcons("exchange", "solid",
                                        size: 16.0),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    ClipOval(
                                      child: Image.asset(
                                          "assets/images/${Defaults.walletTypes.firstWhere((item) => item["value"] == result["currencyTo"])["icon"]}",
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Widgets.buildText(
                                    "By selecting the ${result["currencyTo"]} option, you are unconditionally and irrevocably authorizing our local partner to convert the funds to ${result["currencyTo"]} for your recipient, without any involvement from Cribsfinder Send.",
                                    context,
                                    lines: 10),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Widgets.buildText("Recipient", context,
                                    isMedium: true),
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
                                  child: Row(
                                    children: [
                                      Helpers.getPhoto("",
                                          height: 30.0,
                                          text:
                                              otherPayoutAccount["accountName"]
                                                  .toString()),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText(
                                              otherPayoutAccount["accountName"]
                                                  .toString(),
                                              context,
                                              weight: 500,
                                              size: 13.0),
                                          const SizedBox(
                                            height: 1.0,
                                          ),
                                          Widgets.buildText(
                                              "${otherPayoutAccount["bank"]["name"].toString()} - ${otherPayoutAccount["accountNumber"].toString()}",
                                              context,
                                              weight: 500,
                                              size: 13.0,
                                              color: "text.secondary"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Widgets.buildText("Payment Method", context,
                                    isMedium: true),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 15.0),
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ClipOval(
                                                  child: Image.asset(
                                                "assets/images/${Defaults.walletTypes.firstWhere((item) => item["value"] == result["currencyFrom"])["icon"]}",
                                                height: 40.0,
                                                width: 40.0,
                                                fit: BoxFit.cover,
                                              ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  Defaults.walletTypes
                                                      .firstWhere((item) =>
                                                          item["value"] ==
                                                          result[
                                                              "currencyFrom"])[
                                                          "name"]
                                                      .toString(),
                                                  context,
                                                  weight: 500,
                                                  color: "text.primary"),
                                              Widgets.buildText(
                                                  result["currencyFrom"]
                                                      .toString(),
                                                  context,
                                                  weight: 500,
                                                  size: 10.0,
                                                  color: "text.disabled"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Widgets.buildText(
                                          Helpers.formatCurrency(
                                              overview[result["currencyFrom"]
                                                      .toString()]
                                                  .toString(),
                                              currency: result["currencyFrom"]
                                                  .toString()),
                                          context,
                                          isMedium: true,
                                          size: 13.0),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x1A41B11A),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Helpers.fetchIcons("time-fast", "regular",
                                          size: 20.0),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Widgets.buildText(
                                            result["currencyTo"] == "NGN"
                                                ? "We expect your transfer to arrive within a few minutes"
                                                : "We expect your transfer to arrive within 3 - 5 business days",
                                            context,
                                            lines: 5,
                                            size: 12.0),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Palette.get("background.paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, -5),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: Color(0x08000000))
                      ]),
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed: () {
                        if (result["total"].toString() == "0" &&
                            overview.keys.isNotEmpty) {
                          if (amountController.numberValue <= 0 ||
                              recipientAmountController.numberValue <= 0 ||
                              result["currencyFrom"].toString().isEmpty ||
                              result["currencyTo"].toString().isEmpty) {
                            Alert.show(context, "",
                                "Please enter a valid amount / currencies to proceed.",
                                type: "error");
                            return;
                          }
                        }
                        result["isCancelled"] = false;
                        Navigator.pop(context);
                      },
                      style: Widgets.buildButton(context,
                          radius: 50.0,
                          vertical: 15.0,
                          horizontal: 15.0,
                          background: Palette.get("main.primary")),
                      child: Widgets.buildText(
                          result["isConfirmed"].toString() == "1"
                              ? "Proceed"
                              : (result["account"].toString().isNotEmpty
                                  ? "Confirm"
                                  : (result["total"].toString() == "0"
                                      ? "Continue"
                                      : (result["isNewRecipient"] == "1"
                                          ? "Next"
                                          : "Continue"))),
                          context,
                          isMedium: true,
                          color: "text.white")),
                )
              ],
            );
          });
        });
    return result;
  }
}
