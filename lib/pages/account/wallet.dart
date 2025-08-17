import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/fetch.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/wallet/exchange.dart';
import 'package:nobleassets/utils/wallet/fund.dart';
import 'package:nobleassets/utils/wallet/transfer.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  var account = {};
  var balance = {};
  var accountNumber = "";
  var interestRate = "";
  var _isVisible = false;
  List quickAccess = [];
  Map<String, dynamic> otherPayoutAccount = {
    "bank": {"code": "", "name": ""},
    "accountNumber": "",
    "accountName": "",
    "currency": "",
    "sortCode": "",
    "routingNumber": "",
  };
  Map<String, dynamic> _withdrawalAccount = {};
  late SwiperController _controller;
  Map<String, dynamic> transferValues = {
    "amount": "",
    "currency": "",
    "account": "",
    "fees": 0,
    "total": 0,
    "isNewRecipient": 0,
    "isConfirmed": 0,
    "note": "",
  };
  List _transactions = [];
  List _recipients = [];
  List _banks = [];
  List paymentMethods = [];
  Map dedicatedAccount = {};
  Map withdrawFee = {};

  void get() async {
    try {
      Map data = await Fetch(API.getTransactions, {}, method: "get").load();
      Map res = data["body"];
      if (data["status"].toString() == "200") {
        setState(() {
          _transactions = res["data"];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleTransfer(String method, String pin) async {
    try {
      if (transferValues["currency"].toString().isNotEmpty) {
        if (transferValues["isNewRecipient"].toString() == "1" &&
            transferValues["account"].toString().isEmpty) {
          if (otherPayoutAccount["accountNumber"].toString().isNotEmpty) {
            if (otherPayoutAccount["currency"].toString() == "NGN" &&
                otherPayoutAccount["bank"]["code"].toString().isEmpty) {
              // enqueueSnackbar("Please set a valid bank account to proceed.", {
              //   variant: "warning",
              // });
              return;
            }
            if (otherPayoutAccount["currency"].toString() == "USD" &&
                otherPayoutAccount["routingNumber"].toString().isEmpty) {
              // enqueueSnackbar("Please set a valid routing number to proceed.", {
              //   variant: "warning",
              // });
              return;
            }
            if (otherPayoutAccount["currency"].toString() != "NGN" &&
                otherPayoutAccount["accountName"].toString().isEmpty) {
              // enqueueSnackbar("Please set a valid account name to proceed.", {
              //   variant: "warning",
              // });
              return;
            }
          } else {
            // show add new recipient
            final recipients = _recipients
                .where((item) =>
                    item["currency"].toString() ==
                    transferValues["currency"].toString())
                .toList();
            final selectedRecipient = await WalletTransfer.show(
                recipients,
                balance[transferValues["currency"].toString()].toString(),
                transferValues["currency"].toString(),
                isAddRecipient: true,
                banks: _banks);

            if (selectedRecipient.isNotEmpty) {
              setState(() {
                if (selectedRecipient.containsKey("recipient") &&
                    selectedRecipient["recipient"].isNotEmpty) {
                  otherPayoutAccount = {
                    ...otherPayoutAccount,
                    "bank": {
                      "code": selectedRecipient["recipient"]["bank"]["code"]
                          .toString(),
                      "name": selectedRecipient["recipient"]["bank"]["name"]
                          .toString()
                    },
                    "accountNumber": selectedRecipient["recipient"]
                            ["accountNumber"]
                        .toString(),
                    "accountName": selectedRecipient["recipient"]["accountName"]
                        .toString(),
                    "currency":
                        selectedRecipient["recipient"]["currency"].toString(),
                    "sortCode":
                        selectedRecipient["recipient"]["sortCode"].toString(),
                    "routingNumber": selectedRecipient["recipient"]
                            ["routingNumber"]
                        .toString(),
                  };
                }
              });
              Alert.showLoading(context, "Adding recipient...");
              final recipient = await JWT.addPayoutAccount(otherPayoutAccount);
              setState(() {
                transferValues = {
                  ...transferValues,
                  "isNewRecipient":
                      selectedRecipient["isNewRecipient"].toString(),
                  "account": recipient["code"].toString()
                };
                otherPayoutAccount = {
                  ...otherPayoutAccount,
                  "bank": {
                    "code": otherPayoutAccount["bank"]["code"],
                    "name": recipient["bankName"] ??
                        otherPayoutAccount["bank"]["name"]
                  },
                  "accountName": recipient["accountName"] ?? ""
                };
              });
              Alert.hideLoading(context);
              Future.delayed(Duration.zero, () {
                handleTransfer(
                  "",
                  "",
                );
              });
            } else {
              handleCloseTransfer();
            }
          }
          return;
        } else if (transferValues["account"].toString().isNotEmpty &&
            transferValues["isConfirmed"].toString() == "0") {
          final res = await WalletTransfer.show([],
              balance[transferValues["currency"].toString()].toString(),
              transferValues["currency"].toString(),
              isAddRecipient:
                  transferValues["isNewRecipient"].toString() == "1",
              account: otherPayoutAccount,
              withdrawFee: (withdrawFee[
                          "withdrawal_fee_${transferValues["currency"].toString().toLowerCase()}"] ??
                      0)
                  .toString());
          if (res["amount"].toString().isNotEmpty &&
              (num.tryParse(res["amount"].toString())?.toDouble() ?? 0) > 0) {
            setState(() {
              transferValues = {
                ...transferValues,
                "amount": res["amount"].toString(),
                "isConfirmed": 1,
                "fees": withdrawFee[
                        "withdrawal_fee_${transferValues["currency"].toString().toLowerCase()}"] ??
                    0,
                "total": (num.tryParse((withdrawFee[
                                        "withdrawal_fee_${transferValues["currency"].toString().toLowerCase()}"] ??
                                    0)
                                .toString())
                            ?.toDouble() ??
                        0) +
                    (num.tryParse(transferValues["amount"].toString())
                            ?.toDouble() ??
                        0)
              };
            });
            handleTransfer("", "");
          }
          return;
        } else if (transferValues["isConfirmed"].toString() == "1" &&
            method.isEmpty) {
          WalletTransfer.show([],
              balance[transferValues["currency"].toString()].toString(),
              transferValues["currency"].toString(),
              isAddRecipient:
                  transferValues["isNewRecipient"].toString() == "1",
              account: otherPayoutAccount,
              withdrawFee: (withdrawFee[
                          "withdrawal_fee_${transferValues["currency"].toString().toLowerCase()}"] ??
                      0)
                  .toString(),
              amount: transferValues["amount"].toString());
          final res = await Sheets.showPINVerify();
          if (res.isEmpty) {
            Navigator.pop(context);
            handleCloseTransfer();
          } else {
            handleTransfer("pin", res);
          }
          return;
        } else if (transferValues["account"].toString().isEmpty) {
          // show recipient
          final recipients = _recipients
              .where((item) =>
                  item["currency"].toString() ==
                  transferValues["currency"].toString())
              .toList();
          final selectedRecipient = await WalletTransfer.show(
              recipients,
              balance[transferValues["currency"].toString()].toString(),
              transferValues["currency"].toString());
          if (selectedRecipient.isNotEmpty) {
            setState(() {
              transferValues = {
                ...transferValues,
                "isNewRecipient":
                    selectedRecipient["isNewRecipient"].toString(),
                "account": selectedRecipient.containsKey("recipient") &&
                        selectedRecipient["recipient"].isNotEmpty
                    ? selectedRecipient["recipient"]["code"].toString()
                    : ""
              };
              if (selectedRecipient.containsKey("recipient") &&
                  selectedRecipient["recipient"].isNotEmpty) {
                otherPayoutAccount = {
                  ...otherPayoutAccount,
                  "bank": {
                    "code":
                        selectedRecipient["recipient"]["bankCode"].toString(),
                    "name":
                        selectedRecipient["recipient"]["bankName"].toString()
                  },
                  "accountNumber": selectedRecipient["recipient"]
                          ["accountNumber"]
                      .toString(),
                  "accountName":
                      selectedRecipient["recipient"]["accountName"].toString(),
                  "currency":
                      selectedRecipient["recipient"]["currency"].toString(),
                  "sortCode":
                      selectedRecipient["recipient"]["sortCode"].toString(),
                  "routingNumber": selectedRecipient["recipient"]
                          ["routingNumber"]
                      .toString(),
                };
              }
            });
            Future.delayed(Duration.zero, () {
              print("dante");
              handleTransfer(
                "",
                "",
              );
            });
          } else {
            handleCloseTransfer();
          }
          return;
        }
        // setOpenVerify(false);
        Alert.showLoading(context, "Processing...");
        await JWT.transferWallet(transferValues, method, pin);
        Alert.show(context, "Success!", "Your wallet debit is successful!",
            type: "success");
        handleCloseTransfer();
        fetch();
      } else {
        final selectedCurrency = await Sheets.showWallets(
            balance.keys
                .map((item) => {
                      ...Defaults.walletTypes
                          .firstWhere((w) => w["value"].toString() == item),
                      "balance": balance[item].toString()
                    })
                .toList(),
            isShowAdd: true);
        setState(() {
          transferValues = {...transferValues, "currency": selectedCurrency};
        });
        if (selectedCurrency.isNotEmpty) {
          handleTransfer("", "");
        }

        return;
      }
    } catch (err) {
      Alert.show(context, "", err.toString().split(":")[1], cancelAction: () {
        if (method.isNotEmpty) {
          Navigator.pop(context);
          handleTransfer("", "");
        }
      });
    }
    Alert.hideLoading(context);
  }

  void handlePay() async {
    try {
      final res = await WalletTopup.fundAccount([], account, {}, "NGN");
    } catch (err) {
      print("error $err");
    }
  }

  Future<void> fetch() async {
    if (await Helpers.readPref(Defaults.userid) != "") {
      Map<String, dynamic> data = await Helpers.getProfile();
      if (data["is_verified"] == 1) {
        Map<String, dynamic> accountDetails = await Helpers.getAccount();
        Map<String, dynamic> balanceDetails =
            await Helpers.getBalances(isOverride: true);
        Map<String, dynamic> withdrawalAccount =
            await Helpers.getWithdrawalAccount();
        final rate = await Helpers.getDefault("interest_rate");
        setState(() {
          interestRate = rate;
          account = accountDetails;
          accountNumber = account["number"] ?? "";
          balance["naira"] = balanceDetails["naira"];
          balance["dollar"] = balanceDetails["dollar"];
          balance["interestNaira"] = balanceDetails["interestNaira"];
          balance["interestDollar"] = balanceDetails["interestDollar"];
          balance["lastInterestDate"] = balanceDetails["lastInterestDate"];
          balance["interestDays"] = balanceDetails["interestDays"];
          _withdrawalAccount = withdrawalAccount;
        });
      } else {
        if (navigatorKey.currentContext != null) {
          Navigator.pushReplacementNamed(
              navigatorKey.currentContext!, '/verify');
        }
      }
    }
  }

  void menuSelected(String item) {
    if (item.startsWith("/")) {
      Navigator.pushNamed(context, item);
    } else if (item.isEmpty) {
      // nothing
    } else {
      switch (item) {
        case "transfer":
          handleCloseTransfer();
          handleTransfer("", "");
          break;
        case "deposit":
          handlePay();
          break;
        case "settings":
          WalletTopup.fundAccount([], {}, {}, "NGN", showLimits: true);
          break;
      }
    }
  }

  void checkAccess() async {
    try {
      String selectedPref = await Helpers.readPref(Defaults.defaultQuickAccess);
      List selected = Defaults.defaultQuickAccess.split(",");
      print("response acess $selectedPref");
      final mergedList = [];
      for (var list
          in Defaults.walletMenu.map((item) => item["items"]).toList()) {
        mergedList.addAll(list);
      }

      setState(() {
        quickAccess = mergedList
            .where((item) => selected.contains(item["action"].toString()))
            .toList();
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void handleCloseTransfer() {
    // setOpenTransfer(false);
    setState(() {
      otherPayoutAccount = {
        "bank": {"code": "", "name": ""},
        "accountNumber": "",
        "accountName": "",
        "currency": "",
        "sortCode": "",
        "routingNumber": "",
      };
      transferValues = {
        "amount": "",
        "currency": "",
        "account": "",
        "fees": 0,
        "total": 0,
        "isNewRecipient": 0,
        "isConfirmed": 0,
        "note": "",
      };
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      checkAccess();
      fetch();
      get();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
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
          title: Widgets.buildText("My Wallets", context, isMedium: true),
          elevation: 0,
          backgroundColor: Palette.getColor(context, "background", "paper"),
          foregroundColor: Palette.getColor(context, "text", "disabled"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(screenWidth, 180.0)),
                      child: Swiper(
                        outer: true,
                        layout: SwiperLayout.CUSTOM,
                        customLayoutOption:
                            Widgets.customLayout(2, screenWidth, offset: 60.0),
                        itemHeight: 180.0,
                        itemWidth: screenWidth,
                        loop: true,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> balance = {};
                          switch (index) {
                            case 0:
                              balance = {"NGN": balance["naira"]};
                              break;
                            case 1:
                              balance = {"USD": balance["dollar"]};
                              break;
                          }
                          return WalletBalance(
                              overview: balance,
                              type: balance.keys.first,
                              isVisible: _isVisible,
                              setVisible: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              });
                        },
                        itemCount: 2,
                        pagination: SwiperPagination(builder:
                            SwiperCustomPagination(builder:
                                (BuildContext context,
                                    SwiperPluginConfig config) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < config.itemCount; i += 1)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 0.0),
                                  child: Container(
                                      width: config.activeIndex == i ? 25 : 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: config.activeIndex == i
                                              ? Palette.getColor(
                                                  context, "main", "primary")
                                              : Color(0xffd9d9d9),
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                ),
                            ],
                          );
                        })),
                      )),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () async {
                      Sheets.showNoInterest(interestRate);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                            color: Palette.getColor(
                                context, "background", "neutral"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: balance["interestNaira"].toString().isEmpty ||
                                balance["interestNaira"].toString() == "0"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Widgets.buildText(
                                      "Loyalty Bonus Earned Per Annum", context,
                                      size: 14.0, color: "main.secondary"),
                                  const SizedBox(height: 5.0),
                                  Widgets.buildText("$interestRate%", context),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Widgets.buildText(
                                      "Loyalty Bonus Earned in ${balance["interestDays"] ?? "0"} ${(num.tryParse(balance["interestDays"].toString())?.toInt() ?? 0) > 1 ? "days" : "day"}",
                                      context,
                                      size: 14.0,
                                      color: "main.secondary"),
                                  const SizedBox(height: 5.0),
                                  Widgets.buildText(
                                      Helpers.formatCurrency(
                                          balance["interestNaira"].toString()),
                                      context,
                                      size: 26.0),
                                  const SizedBox(height: 5.0),
                                  Widgets.buildText(
                                      "at a rate of $interestRate% per annum.",
                                      context,
                                      color: "text.secondary",
                                      size: 14.0),
                                ],
                              )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.get("background.paper"),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Color(0x0D000000))),
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var i = 0; i < quickAccess.length; i += 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                menuSelected(quickAccess[i]["action"]);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: i == 0
                                            ? Color(0xFF23813F)
                                            : (i == 1
                                                ? Color(0xFFF8F8FA)
                                                : Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: i == 0
                                            ? null
                                            : Border.all(
                                                color: Color(0xFFF8F8FA))),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Helpers.fetchIcons(
                                        quickAccess[i]["icon"], "regular",
                                        size: 20.0,
                                        color: i == 0
                                            ? "text.white"
                                            : "text.black"),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText(
                                      quickAccess[i]["title"], context)
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (account.containsKey("number") && account["number"] != "")
                    const SizedBox(
                      height: 20.0,
                    ),
                  if (account.containsKey("number") && account["number"] != "")
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Palette.getColor(
                              context, "background", "neutral")),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Widgets.buildText("Fund Your Wallet", context,
                              color: "text.primary",
                              size: 16.0,
                              isBold: true,
                              isCenter: true),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Widgets.buildText("Bank: ", context,
                                  size: 16.0,
                                  isBold: true,
                                  isCenter: true,
                                  color: "text.secondary"),
                              Widgets.buildText(account["bank"] ?? "", context,
                                  size: 16.0,
                                  isBold: true,
                                  isCenter: true,
                                  color: "text.secondary"),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 200.0,
                            child: ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: account["number"] ?? ""));
                                setState(() => accountNumber = "Copied");
                                Timer(const Duration(seconds: 4), () async {
                                  setState(() =>
                                      accountNumber = account["number"] ?? "");
                                });
                              },
                              style: Widgets.buildButton(context,
                                  radius: 20.0,
                                  background: Palette.getColor(
                                      context, "text", "disabled"),
                                  vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.content_copy),
                                  const SizedBox(width: 10.0),
                                  AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                                  begin:
                                                      const Offset(0.0, -0.5),
                                                  end: const Offset(0.0, 0.0))
                                              .animate(animation),
                                          child: child,
                                        );
                                      },
                                      child: Widgets.buildText(
                                          accountNumber, context,
                                          size: 20.0,
                                          isBold: true,
                                          isCenter: true,
                                          color: "text.white")),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Widgets.buildText(
                              "This works like regular bank account number. Transfer from any source to ${account["number"] ?? ""}. Select ${account["bank"]} as the destination bank. Funds will be credited to your Wallet instantly.",
                              context,
                              size: 12.0,
                              isBold: true,
                              isCenter: true,
                              color: "text.secondary"),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Widgets.buildText("Transactions", context,
                          isMedium: true),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/transactions");
                        },
                        child: Widgets.buildText("See all", context,
                            color: "main.primary"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(screenWidth, 180.0)),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final item = _transactions[index];
                          final _walletBackground = {
                            "NGN": Color(0xFF23813F),
                            "USD": Color(0xFF403C3C),
                            "GBP": Color(0xFFf97959),
                          };
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _walletBackground[item["currency"]],
                                  borderRadius: BorderRadius.circular(20.0)),
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Palette.get("background.paper"),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Helpers.fetchIcons(
                                        Defaults
                                            .walletTransactionType[num.tryParse(
                                                        item["type"].toString())
                                                    ?.toInt() ??
                                                0]["icon"]
                                            .toString(),
                                        "regular",
                                        size: 20.0),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Widgets.buildText(item["title"], context,
                                      color: "text.white",
                                      weight: 500,
                                      size: 13.0),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText(
                                      Helpers.formatDate(
                                          item["date"].toString(),
                                          formatString: "MMM d, yyyy"),
                                      context,
                                      color: "text.white"),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: 30.0,
                                    children: [
                                      Widgets.buildText(
                                          Helpers.formatCurrency(
                                              item["amount"].toString(),
                                              currency: item["currency"]),
                                          context,
                                          color: "text.white",
                                          isMedium: true),
                                      Transform.rotate(
                                        angle: 7.0,
                                        child: Helpers.fetchIcons(
                                            "arrow-small-up", "regular",
                                            color: "text.white", size: 20.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount:
                            _transactions.length < 4 ? _transactions.length : 4,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (_transactions.length > 4)
                    Container(
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          border: Border.all(color: Color(0x0D000000)),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = _transactions[index + 3];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Color(0x1A23813F),
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Helpers.fetchIcons(
                                            Defaults.walletTransactionType[
                                                    num.tryParse(item["type"]
                                                                .toString())
                                                            ?.toInt() ??
                                                        0]["icon"]
                                                .toString(),
                                            "regular",
                                            color: "main.primary",
                                            size: 20.0),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText(
                                              item["title"], context),
                                          Widgets.buildText(
                                              Helpers.formatDate(
                                                  item["date"].toString(),
                                                  formatString: "MMM d, yyyy"),
                                              context,
                                              size: 12.0,
                                              color: "text.secondary"),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Widgets.buildText(
                                          Helpers.formatCurrency(
                                              item["amount"].toString(),
                                              currency: item["currency"]),
                                          context,
                                          weight: 500),
                                      Widgets.buildText("Successful", context,
                                          size: 12.0, color: "success.main"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: _transactions.length - 4),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}

class WalletBalance extends StatelessWidget {
  const WalletBalance(
      {super.key,
      required this.overview,
      required this.type,
      required this.setVisible,
      required this.isVisible});

  final Map<String, dynamic> overview;
  final Function setVisible;
  final String type;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final _walletTitle = {
      "NGN": "Naira Wallet",
      "USD": "Dollar Wallet",
    };
    return Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Container(
        width: double.infinity,
        height: 130.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Palette.get("main.primary"),
              Palette.get("main.secondary")
            ]),
            borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Widgets.buildText(_walletTitle[type].toString(), context,
                          size: 13.0, color: "text.white"),
                      IconButton(
                          onPressed: () {
                            setVisible();
                          },
                          icon: Helpers.fetchIcons(
                              isVisible ? "eye-crossed" : "eye", "regular",
                              color: "text.white", size: 14.0))
                    ],
                  ),
                  FittedBox(
                    child: Widgets.buildText(
                      Helpers.formatCurrency(overview[type].toString(),
                          currency: type, isShow: isVisible),
                      context,
                      color: "text.white",
                      size: 30.0,
                      isBold: true,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
