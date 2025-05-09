import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/apis.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/wallet/exchange.dart';
import 'package:cribsfinder/utils/wallet/fund.dart';
import 'package:cribsfinder/utils/wallet/transfer.dart';
import 'package:cribsfinder/utils/widget.dart';
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
  final profile = {
    "fname": "Tayo",
    "lname": "Oladele",
    "email": "info@cribsfinder.com",
    "phone": "091833383",
    "dateAdded": "2025-01-01",
    "isVerified": "1",
    "status": "1",
    "photo": "",
    "gender": "M",
    "dob": "1995-01-02",
    "address": "ibeju Lekki Lagos Nigeria"
  };
  Map<String, dynamic> _wallet = {"NGN": 100.0, "USD": 100.0, "GBP": 100.0};
  Map<String, dynamic> _withdrawalFee = {};
  List _banks = [
    {"name": "Access Bank", "code": "38293", "icon": ""},
    {"name": "Zenith Bank", "code": "38293", "icon": ""},
    {"name": "Kuda Bank", "code": "38293", "icon": ""},
    {"name": "Wema Bank", "code": "38293", "icon": ""},
    {"name": "Titan Bank", "code": "38293", "icon": ""},
    {"name": "Opay", "code": "38293", "icon": ""},
    {"name": "Moniepoint", "code": "38293", "icon": ""}
  ];
  final List<Map<String, dynamic>> _recipients = [
    {
      "accountName": "Precious Alangbe",
      "photo": "dante.png",
      "country": "NGN",
      "currency": "NGN",
      "bankCode": "132",
      "bankName": "Access Bank",
      "sortCode": "",
      "routingNumber": "",
      "accountNumber": "123456789",
      "code": "1"
    },
    {
      "accountName": "Dante Aligheri",
      "photo": "",
      "country": "GBP",
      "currency": "GBP",
      "bankCode": "",
      "bankName": "",
      "sortCode": "32783",
      "routingNumber": "Shsgsgsg",
      "accountNumber": "123456789",
      "code": "2"
    },
    {
      "accountName": "Smith",
      "photo": "",
      "country": "USD",
      "currency": "USD",
      "bankCode": "",
      "bankName": "",
      "sortCode": "32783",
      "routingNumber": "Shsgsgsg",
      "accountNumber": "123456789",
      "code": "3"
    },
    {
      "accountName": "Ola",
      "photo": "",
      "country": "NGN",
      "currency": "NGN",
      "sortCode": "32783",
      "routingNumber": "Shsgsgsg",
      "bankCode": "132",
      "bankName": "Kuda Bank",
      "accountNumber": "123456789",
      "code": "4"
    },
  ];
  final String _coins = "100.0";
  final String _referrals = "40";
  final List _transactions = [
    {
      "type": 0,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 1,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 2,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 3,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 4,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 5,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 6,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "NGN",
    }
  ];
  bool _isVisible = true;
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
  Map<String, dynamic> exchangeValues = {
    "amount": "",
    "recipientAmount": "",
    "reference": "",
    "currencyFrom": "NGN",
    "currencyTo": "",
    "account": "",
    "exchangeRate": 0,
    "isFocused": "from",
    "fees": 0,
    "total": 0,
    "isNewRecipient": 0,
    "isConfirmed": 0,
    "note": "",
  };
  Map<String, dynamic> otherPayoutAccount = {
    "bank": {"code": "", "name": ""},
    "accountNumber": "",
    "accountName": "",
    "currency": "",
    "sortCode": "",
    "routingNumber": "",
  };
  Map<String, dynamic> dedicatedAccount = {
    "NGN": {
      "bank": "Paystack Titan",
      "accountNumber": "1234567890",
      "accountName": "Cribsfinder / John Doe"
    },
  };
  List paymentMethods = [
    {"last4": "4345", "currency": "NGN", "bank": "ACCESS BANK"},
    {"last4": "4345", "currency": "USD", "bank": "STRIPE BANK"},
    {"last4": "4345", "currency": "GBP", "bank": "BRITISH BANK"},
  ];
  Map<String, dynamic> exchangeDefaults = {
    "GBP_NGN_rate": 1200,
    "USD_NGN_rate": 1200,
  };
  Map<String, dynamic> limits = {
    "NGN": {
      "single": {"total": 5000000, "spent": 1000000},
      "daily": {"total": 6000000, "spent": 2000000},
      "weekly": {"total": 7000000, "spent": 3000000},
      "monthly": {"total": 8000000, "spent": 4000000},
      "deposit": {"total": "Unlimited", "spent": 5000000},
    },
    "USD": {
      "single": {"total": 500000, "spent": 100000},
      "daily": {"total": 600000, "spent": 200000},
      "weekly": {"total": 700000, "spent": 300000},
      "monthly": {"total": 800000, "spent": 400000},
      "deposit": {"total": "Unlimited", "spent": 500000},
    },
    "GBP": {
      "single": {"total": 500000, "spent": 100000},
      "daily": {"total": 600000, "spent": 200000},
      "weekly": {"total": 700000, "spent": 300000},
      "monthly": {"total": 800000, "spent": 400000},
      "deposit": {"total": "Unlimited", "spent": 500000},
    },
  };
  Map<String, dynamic> withdrawFee = {};
  List quickAccess = [];

  @override
  void dispose() {
    super.dispose();
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

  void handleCloseExchange() {
    setState(() {
      otherPayoutAccount = {
        "bank": {"code": "", "name": ""},
        "accountNumber": "",
        "accountName": "",
        "currency": "",
        "sortCode": "",
        "routingNumber": "",
      };
      exchangeValues = {
        "amount": "",
        "recipientAmount": "",
        "reference": "",
        "currencyFrom": "NGN",
        "currencyTo": "",
        "account": "",
        "exchangeRate": 0,
        "isFocused": "from",
        "fees": 0,
        "total": 0,
        "isNewRecipient": 0,
        "isConfirmed": 0,
        "note": "",
      };
    });
  }

  void filter() async {
    try {
      // final res = await JWT.getWallets();
    } catch (err) {
      print(err);
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
                _wallet[transferValues["currency"].toString()].toString(),
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
              _wallet[transferValues["currency"].toString()].toString(),
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
              _wallet[transferValues["currency"].toString()].toString(),
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
              _wallet[transferValues["currency"].toString()].toString(),
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
        filter();
      } else {
        final selectedCurrency = await Sheets.showWallets(
            _wallet.keys
                .map((item) => {
                      ...Defaults.walletTypes
                          .firstWhere((w) => w["value"].toString() == item),
                      "balance": _wallet[item].toString()
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
      final items = [
        {
          "name": "Add money",
          "subtitle": "Add money to your account",
          "icon": "plus-small",
          "value": "topup"
        },
        {
          "name": "Create an invoice",
          "subtitle": "Draft and send invoice",
          "icon": "receipt",
          "value": "invoice"
        },
        {
          "name": "Send payment link",
          "subtitle": "Get paid faster by sharing a link",
          "icon": "link",
          "value": "link"
        }
      ];
      final selected = await Sheets.showOptions(
          "Get Paid",
          "Choose Your Preferred Payment Method to Receive Funds in Your Cribsfinder Wallet.",
          items,
          isCustomBackground: true);
      if (selected.isNotEmpty && selected["value"].toString().isNotEmpty) {
        if (selected["value"].toString() == "topup") {
          final selectedCurrency = await Sheets.showWallets(
              _wallet.keys
                  .map((item) => {
                        ...Defaults.walletTypes
                            .firstWhere((w) => w["value"].toString() == item),
                        "balance": _wallet[item].toString()
                      })
                  .toList(),
              title: "Add Money",
              subtitle:
                  "Choose Your Preferred Payment Method to Receive Funds in Your Cribsfinder Wallet.");
          final res = await WalletTopup.fundAccount(
              paymentMethods
                  .where(
                      (item) => item["currency"].toString() == selectedCurrency)
                  .toList(),
              dedicatedAccount[selectedCurrency] ?? {},
              limits[selectedCurrency],
              selectedCurrency);
        }
      }
    } catch (err) {
      print("error $err");
    }
  }

  void handleExchange(String method, String pin) async {
    try {
      String errorMessage = "";
      bool isShowExchangeModal = false;

      if (exchangeValues["amount"].toString() != "" &&
          (num.tryParse(exchangeValues["amount"].toString())?.toDouble() ?? 0) >
              0 &&
          (num.tryParse(exchangeValues["recipientAmount"].toString())
                      ?.toDouble() ??
                  0) >
              0) {
        if ((num.tryParse(exchangeValues["total"].toString())?.toDouble() ??
                0) <=
            0) {
          if (exchangeValues["currencyFrom"].toString() ==
              exchangeValues["currencyTo"]) {
            setState(() {
              transferValues = {
                ...transferValues,
                "currency": exchangeValues["currencyFrom"].toString(),
                "amount": exchangeValues["amount"].toString()
              };
            });
            handleCloseExchange();
            handleTransfer("", "");
          } else {
            setState(() {
              exchangeValues = {
                ...exchangeValues,
                "total": (num.tryParse(exchangeValues["amount"].toString())
                            ?.toDouble() ??
                        0) +
                    (num.tryParse(exchangeValues["fees"].toString())
                            ?.toDouble() ??
                        0)
              };
            });
            isShowExchangeModal = true;
          }
        } else if (exchangeValues["isNewRecipient"].toString() == "1" &&
            exchangeValues["account"].toString().isEmpty) {
          if (otherPayoutAccount["accountNumber"].toString().isNotEmpty) {
            if (otherPayoutAccount["currency"].toString() == "NGN" &&
                (otherPayoutAccount["bank"]["code"] ?? "").toString().isEmpty) {
              errorMessage = "Please set a valid bank account to proceed.";
            }
            if (otherPayoutAccount["currency"].toString() == "USD" &&
                otherPayoutAccount["routingNumber"].toString().isEmpty) {
              errorMessage = "Please set a valid routing number to proceed.";
            }
            if (otherPayoutAccount["currency"].toString() != "NGN" &&
                otherPayoutAccount["accountName"].toString().isEmpty) {
              errorMessage = "Please set a valid account name to proceed.";
            }
          } else {
            errorMessage = "Please set a valid account number to proceed.";
          }
          if (errorMessage.isEmpty) {
            await Future.delayed(Duration(milliseconds: 500));
            Alert.showLoading(context, "Saving recipient...");
            final recipient = await JWT.addPayoutAccount(otherPayoutAccount);
            setState(() {
              exchangeValues = {
                ...exchangeValues,
                "account": recipient["code"] ?? "",
              };
              otherPayoutAccount = {
                ...otherPayoutAccount,
                "bank": {
                  "code": otherPayoutAccount["bank"]["code"].toString(),
                  "name": recipient["bankName"] ??
                      otherPayoutAccount["bank"]["name"].toString()
                },
                "accountName": recipient["accountName"] ?? ""
              };
            });
            Alert.hideLoading(context);
          }
          isShowExchangeModal = true;
        } else if (exchangeValues["account"].toString().isNotEmpty &&
            exchangeValues["isConfirmed"].toString() == "0") {
          setState(() {
            exchangeValues = {...exchangeValues, "isConfirmed": 1};
          });
          isShowExchangeModal = true;
        } else if (exchangeValues["isConfirmed"].toString() == "1" &&
            method.isEmpty) {
          WalletExchange.show(exchangeValues, _wallet, exchangeDefaults,
              otherPayoutAccount: otherPayoutAccount);
          final res = await Sheets.showPINVerify();
          Navigator.pop(context);
          if (res.isNotEmpty) {
            handleExchange("pin", res);
          } else {
            isShowExchangeModal = true;
          }
        }
        if (!isShowExchangeModal && method.isNotEmpty) {
          await Future.delayed(Duration(milliseconds: 500));
          Alert.showLoading(context, "Processing...");
          await JWT.exchangeWallet(exchangeValues, method, pin);
          Alert.show(context, "", "Your wallet exchange is successful!",
              type: "success");
          handleCloseExchange();
          filter();
        }
      } else {
        setState(() {
          exchangeValues = {
            ...exchangeValues,
            "currencyTo": _wallet.keys.length > 1
                ? _wallet.keys.toList()[1]
                : exchangeValues["currencyFrom"]
          };
          isShowExchangeModal = true;
        });
      }
      if (isShowExchangeModal) {
        final recipients = _recipients
            .where((item) =>
                item["currency"].toString() ==
                exchangeValues["currencyTo"].toString())
            .toList();
        final res = await WalletExchange.show(
            exchangeValues, _wallet, exchangeDefaults,
            otherPayoutAccount: otherPayoutAccount,
            recipients: recipients, setOtherPayoutAccount: (otherAccount) {
          setState(() {
            otherPayoutAccount = {...otherPayoutAccount, ...otherAccount};
          });
        }, errorMessage: errorMessage);
        if (res["isCancelled"]) {
          handleCloseExchange();
        } else {
          setState(() {
            isShowExchangeModal = false;
            exchangeValues = {...res};
          });
          print(exchangeValues);
          handleExchange("", "");
        }
      }
    } catch (err) {
      Alert.show(context, "", err.toString().split(":").last.trim(),
          type: "error");
    }
    Alert.hideLoading(context);
  }

  void menuSelected(String item) {
    if (item.startsWith("/")) {
      Navigator.pushNamed(context, item);
    } else if (item.isEmpty) {
      // nothing
    } else {
      switch (item) {
        case "airtime":
          // nothing
          break;
        case "data": // nothing
          break;
        case "power": // nothing
          break;
        case "cable": // nothing
          break;
        case "exchange":
          handleCloseExchange();
          handleExchange("", "");
          break;
        case "transfer":
          handleCloseTransfer();
          handleTransfer("", "");
          break;
        case "deposit":
          handlePay();
          break;
        case "limits":
          WalletTopup.fundAccount([], {}, limits["NGN"], "NGN",
              showLimits: true);
          break;
      }
    }
  }

  void checkAccess() async {
    try {
      String selectedPref = await Helpers.readPref(Defaults.quickAccess);
      List selected =
          (selectedPref.isEmpty ? Defaults.defaultQuickAccess : selectedPref)
              .split(",");
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

  void setDefaults() async {
    try {
      final banks = await JWT.getBanks();
      final withdrawFee = await JWT.getWithdrawFee();
      final eDefaults = await JWT.getExchangeRateFees();
      print("defaults = $eDefaults");
      setState(() {
        _banks = banks;
        _withdrawalFee = withdrawFee;
        exchangeDefaults = eDefaults;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      checkAccess();
      setDefaults();
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
          elevation: 0,
          backgroundColor: Palette.getColor(context, "background", "paper"),
          foregroundColor: Palette.getColor(context, "text", "disabled"),
          toolbarHeight: 80.0,
          title: Row(children: [
            Helpers.getProfilePhoto(context, height: 40.0),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.buildText(
                    "${profile["fname"]} ${profile["lname"]}", context,
                    isMedium: true),
                Widgets.buildText("Good morning", context),
              ],
            )
          ]),
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0x1A41B11A),
                  borderRadius: BorderRadius.circular(20.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              margin: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: [
                  Helpers.fetchIcons("coins", "solid",
                      size: 16.0, color: "warning.main"),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText(
                      "Earned ${Helpers.formatCurrency(_coins)}", context,
                      size: 11.0, isMedium: true)
                ],
              ),
            )
          ],
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
                        customLayoutOption: Widgets.customLayout(
                            _wallet.keys.length + 2, screenWidth,
                            offset: 60.0),
                        itemHeight: 180.0,
                        itemWidth: screenWidth,
                        loop: true,
                        itemBuilder: (BuildContext context, int index) {
                          var currency = "";
                          if (_wallet.keys.length > index) {
                            currency = _wallet.keys.toList()[index];
                          } else if (index == _wallet.keys.length) {
                            currency = "ADD";
                          } else if (index == _wallet.keys.length + 1) {
                            currency = "REFERRAL";
                          }
                          return WalletBalance(
                              overview: {..._wallet, "REFERRAL": _referrals},
                              type: currency,
                              coins: _coins,
                              isVisible: _isVisible,
                              setVisible: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              handleAddAccount: () {
                                if (currency == "ADD") {
                                  Navigator.pushNamed(
                                      context, "/add-wallet-account");
                                } else if (currency != "REFERRAL") {
                                  // handleOpenDeposit();
                                }
                              });
                        },
                        itemCount: _wallet.keys.length + 2,
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
                        GestureDetector(
                          onTap: () async {
                            final selected = await Sheets.showWalletMenu();
                            checkAccess();
                            menuSelected(selected);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border:
                                        Border.all(color: Color(0x0D000000))),
                                padding: const EdgeInsets.all(15.0),
                                child: Helpers.fetchIcons(
                                    "menu-dots-vertical", "solid",
                                    size: 20.0, color: "text.black"),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Widgets.buildText("More", context)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(screenWidth, 180.0)),
                      child: Swiper(
                        outer: true,
                        layout: SwiperLayout.DEFAULT,
                        itemHeight: 180.0,
                        itemWidth: screenWidth,
                        loop: true,
                        autoplay: true,
                        autoplayDelay: 7000,
                        duration: 1000,
                        itemBuilder: (BuildContext context, int index) {
                          Widget content = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Widgets.buildText(
                                        "Invite your friends or vendors and earn between ₦2,000 and ₦10,000!",
                                        context,
                                        lines: 4,
                                        weight: 500),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Palette.get("main.primary"),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Helpers.fetchIcons("user", "regular",
                                        color: "main.primary", size: 20.0),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/referrals");
                                  },
                                  style: Widgets.buildButton(context,
                                      background: Color(0x1A41B11A),
                                      horizontal: 15.0,
                                      vertical: 15.0,
                                      radius: 50.0),
                                  child: Widgets.buildText(
                                      "Invite friends", context,
                                      color: "main.primary", weight: 500))
                            ],
                          );
                          if (index == 1 || index == 2) {
                            content = Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Widgets.buildText(
                                            "1 ${index == 1 ? "GBP" : "USD"} = ${Helpers.formatCurrency(exchangeDefaults["${index == 1 ? "GBP" : "USD"}_NGN_rate"].toString())}",
                                            context,
                                            isMedium: true,
                                            size: 20.0),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        SizedBox(
                                          width: 100.0,
                                          child: Stack(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                    "assets/images/GBP.png",
                                                    height: 30.0,
                                                    width: 30.0,
                                                    fit: BoxFit.cover),
                                              ),
                                              Positioned(
                                                left: 20,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                      "assets/images/NGN.png",
                                                      height: 30.0,
                                                      width: 30.0,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Widgets.buildText("Exchange rate", context,
                                        weight: 500.0, color: "text.secondary"),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () async {
                                      final selected =
                                          await Sheets.showExchangeRates(
                                              exchangeDefaults);
                                      if (selected.isNotEmpty) {
                                        setState(() {
                                          exchangeValues = {
                                            ...exchangeValues,
                                            "currencyFrom": selected["from"],
                                            "currencyTo": selected["to"]
                                          };
                                        });
                                        handleExchange("", "");
                                      }
                                    },
                                    style: Widgets.buildButton(context,
                                        background: Color(0x1A41B11A),
                                        horizontal: 15.0,
                                        vertical: 15.0,
                                        radius: 50.0),
                                    child: Widgets.buildText(
                                        "View rates", context,
                                        weight: 500.0, color: "main.primary"))
                              ],
                            );
                          } else if (index == 3) {
                            content = Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText(
                                        "${Helpers.formatCurrency(limits["NGN"]["daily"]["spent"].toString())}/  ${Helpers.formatCurrency(limits["NGN"]["daily"]["total"].toString())}",
                                        context,
                                        isMedium: true,
                                        size: 20.0),
                                    Widgets.buildText("Daily Limit", context,
                                        weight: 500.0, color: "text.secondary"),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      WalletTopup.fundAccount(
                                          [], {}, limits["NGN"], "NGN",
                                          showLimits: true);
                                    },
                                    style: Widgets.buildButton(context,
                                        background: Color(0x1A41B11A),
                                        horizontal: 15.0,
                                        vertical: 15.0,
                                        radius: 50.0),
                                    child: Widgets.buildText(
                                        "View limits", context,
                                        weight: 500.0, color: "main.primary"))
                              ],
                            );
                          } else if (index == 4) {
                            final networks = [
                              {
                                "name": "MTN",
                                "logo": "MTN.png",
                                "discount": "5%"
                              },
                              {
                                "name": "GLO",
                                "logo": "GLO.png",
                                "discount": "4%"
                              },
                              {
                                "name": "Airtel",
                                "logo": "Airtel.jpeg",
                                "discount": "6%"
                              },
                              {
                                "name": "9Mobile",
                                "logo": "9Mobile.jpeg",
                                "discount": "2%"
                              },
                            ];
                            content = Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText(
                                    "Get discounted data now", context,
                                    weight: 500.0, color: "text.secondary"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  children: [
                                    for (var network in networks)
                                      Container(
                                        width: (screenWidth - 100.0) / 2.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0x0D000000)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                "assets/images/${network["logo"]}",
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Widgets.buildText(
                                                    network["name"].toString(),
                                                    context,
                                                    isMedium: true),
                                                Widgets.buildText(
                                                    "Up to ${network["discount"].toString()}",
                                                    context),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.paper"),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Color(0x0D000000))),
                            padding: const EdgeInsets.all(15.0),
                            child: content,
                          );
                        },
                        itemCount: 5,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.get("background.paper"),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Color(0x0D000000))),
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Widgets.buildText("Send Again", context,
                                isMedium: true),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                handleTransfer("", "");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DottedBorder(
                                    radius: Radius.circular(50.0),
                                    borderType: BorderType.RRect,
                                    color: Palette.get("main.primary"),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Helpers.fetchIcons(
                                          "plus-small", "solid",
                                          size: 30.0, color: "main.primary"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText("Add New", context,
                                      color: "main.primary")
                                ],
                              ),
                            ),
                            for (final recipient in _recipients)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        transferValues = {
                                          "amount": "",
                                          "currency": recipient["currency"],
                                          "account": recipient["code"],
                                          "fees": 0,
                                          "total": 0,
                                          "isNewRecipient": 0,
                                          "isConfirmed": 0,
                                          "note": ""
                                        };
                                        otherPayoutAccount = {
                                          "bank": {
                                            "code": recipient["bankCode"],
                                            "name": recipient["bankName"]
                                          },
                                          "accountNumber":
                                              recipient["accountNumber"],
                                          "accountName":
                                              recipient["accountName"],
                                          "currency": recipient["currency"],
                                          "sortCode": recipient["sortCode"],
                                          "routingNumber":
                                              recipient["routingNumber"],
                                        };
                                      });
                                      handleTransfer("", "");
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF8F8FA),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  border: Border.all(
                                                      color:
                                                          Color(0x0D000000))),
                                              child: Helpers.getPhoto(
                                                  recipient["photo"].toString(),
                                                  text:
                                                      recipient["accountName"],
                                                  height: 50.0),
                                            ),
                                            Positioned(
                                                right: 0.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(
                                                          "background.paper"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  padding:
                                                      const EdgeInsets.all(0.5),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/images/${recipient["country"]}.png",
                                                      width: 15.0,
                                                      height: 15.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Widgets.buildText(
                                            recipient["accountName"], context)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
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
      required this.coins,
      required this.setVisible,
      required this.isVisible,
      required this.handleAddAccount});

  final Map<String, dynamic> overview;
  final Function handleAddAccount;
  final Function setVisible;
  final String type;
  final bool isVisible;
  final String coins;

  @override
  Widget build(BuildContext context) {
    final _walletBackground = {
      "NGN": "ngn-bg.png",
      "USD": "usd-bg.png",
      "GBP": "gbp-bg.png",
      "REFERRAL": "referral-bg.png"
    };
    return Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Container(
        width: double.infinity,
        height: 130.0,
        decoration: BoxDecoration(
            color: Color(0x3341B11A),
            image: type == "ADD"
                ? null
                : DecorationImage(
                    image:
                        AssetImage("assets/images/${_walletBackground[type]}"),
                    fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20.0)),
        child: DottedBorder(
          dashPattern: [6, 6],
          strokeWidth: type == "ADD" ? 1.0 : 0.0,
          color: Palette.get("main.primary"),
          radius: Radius.circular(20.0),
          borderType: BorderType.RRect,
          padding: EdgeInsets.all(type == "ADD" ? 3 : 0),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => handleAddAccount(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (type != "ADD")
                        Row(
                          children: [
                            Widgets.buildText(
                                type == "REFERRAL"
                                    ? "Your referral Overview: ${Helpers.formatNumber(overview[type].toString())}"
                                    : "Available Balance",
                                context,
                                size: 13.0,
                                color: "text.white"),
                            if (type != "REFERRAL")
                              IconButton(
                                  onPressed: () {
                                    setVisible();
                                  },
                                  icon: Helpers.fetchIcons(
                                      isVisible ? "eye-crossed" : "eye",
                                      "regular",
                                      color: "text.white",
                                      size: 14.0))
                          ],
                        ),
                      if (type == "ADD")
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.paper"),
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(5.0),
                            child: Helpers.fetchIcons("plus-small", "solid",
                                size: 30.0, color: "main.primary"),
                          ),
                        ),
                      SizedBox(height: type == "ADD" ? 20.0 : 0.0),
                      if (type == "REFERRAL")
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Widgets.buildText("Total Earned", context,
                              size: 13.0, color: "text.white"),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: Widgets.buildText(
                            type == "ADD"
                                ? "Tap to add account"
                                : Helpers.formatCurrency(
                                    (type == "REFERRAL"
                                        ? coins.toString()
                                        : overview[type].toString()),
                                    currency: type == "REFERRAL" ? "NGN" : type,
                                    isShow: isVisible),
                            context,
                            color: "text.white",
                            size: type == "ADD" ? 16.0 : 24.0,
                            isBold: type != "ADD",
                            isMedium: type == "ADD",
                            isCenter: type == "ADD"),
                      )
                    ],
                  ),
                ),
              ),
              if (type != "ADD" && type != "REFERRAL")
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      handleAddAccount();
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5.0),
                              topRight: Radius.circular(20.0))),
                      child: Center(
                          child: Helpers.fetchIcons("plus-small", "solid",
                              size: 25.0)),
                    ),
                  ),
                ),
              if (type != "ADD")
                Align(
                  alignment: type == "REFERRAL"
                      ? Alignment.topRight
                      : Alignment.bottomRight,
                  child: type == "REFERRAL"
                      ? Padding(
                          padding:
                              const EdgeInsets.only(right: 40.0, top: 30.0),
                          child: Helpers.fetchIcons("coins", "solid",
                              size: 30.0, color: "text.white"),
                        )
                      : Image.asset(
                          "assets/images/wallet-logo.png",
                          height: 80.0,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
