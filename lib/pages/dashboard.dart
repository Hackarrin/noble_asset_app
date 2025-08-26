import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
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

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Dashboard> {
  Map<String, dynamic> _profile = {};
  Map<String, dynamic> _wallet = {};
  Map<String, dynamic> compliance = {};
  Map<String, dynamic> profile = {};
  List<dynamic> _promos = [];
  List<dynamic> _favourites = [];
  int _accounts = 1;
  String qoute = "";

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
  List _transactions = [
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
      "accountName": "Noble Assets / John Doe"
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
          "Choose Your Preferred Payment Method to Receive Funds in Your Noble Assets Dashboard.",
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
                  "Choose Your Preferred Payment Method to Receive Funds in Your Noble Assets Dashboard.");
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

  void menuSelected(String type) {
    final action = Defaults.favouritesPages[type].toString();
    print("response $type $action");
    if (type == "wallet_topup") {
      Sheets.showComingSoon();
    } else if (type == "create_savings") {
      Navigator.pushReplacementNamed(context, "/home", arguments: "1");
    } else if (type == "create_investment") {
      Navigator.pushReplacementNamed(context, "/home", arguments: "2");
    } else if (action.isNotEmpty) {
      Navigator.pushNamed(context, "/$action");
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

      final trans = await Helpers.getInvestments();

      setState(() {
        _transactions = trans;
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
      final account = await Helpers.getProfile();
      final profile = account["profile"] ?? {};
      final wallet = account["wallets"] ?? {};
      wallet["investments"] = account["investments"] ?? 0;
      wallet["savings"] = account["savings"] ?? 0;
      List accounts = await Helpers.getAccounts();
      final isVisible = await Helpers.readPref(Defaults.showBalance);
      setState(() {
        _isVisible = isVisible == "1";
        _accounts = accounts.length;
      });
      setState(() {
        _profile = profile;
      });
      String selectedQoute = await Helpers.getQoute();
      Map<String, dynamic> company = await Helpers.getCompany();
      List<dynamic> promos = await Helpers.getPromos();
      List<dynamic> favourites = await Helpers.getFavourites();
      setState(() {
        qoute = company.isEmpty ? selectedQoute : company["name"].toString();
        _promos = promos;
        _favourites = favourites;
        _wallet = wallet;
      });
      Map<String, dynamic> checkCompliance = await Helpers.checkCompliance();
      if (checkCompliance["ret"] != "" &&
          Defaults.complianceMessage.containsKey(checkCompliance["ret"])) {
        setState(() => compliance =
            Defaults.complianceMessage[checkCompliance["ret"]] ?? {});
      } else {
        //check if biometric
      }
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
    print("response $_wallet");
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
            Helpers.getProfilePhoto(context, height: 40.0, profile: _profile),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Widgets.buildText(
                    "${Helpers.greeting()}, ${_profile["fname"]}", context,
                    isMedium: true),
                Widgets.buildText(qoute.replaceAll("\\", ""), context),
              ],
            )
          ]),
          actions: [
            if (_accounts > 1)
              GestureDetector(
                onTap: () {
                  // Sheets.showAccounts();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.get("main.secondary").withAlpha(50),
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Helpers.fetchIcons("swap", "solid",
                          size: 16.0, color: "warning.main"),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Widgets.buildText("Switch Account", context,
                          size: 11.0, isMedium: true)
                    ],
                  ),
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
                          Map<String, dynamic> balance = {};
                          switch (index) {
                            case 0:
                              balance = {"NGN": _wallet["naira"]};
                              break;
                            case 1:
                              balance = {"USD": _wallet["dollar"]};
                              break;
                            case 2:
                              balance = {"INVESTMENTS": _wallet["investments"]};
                              break;
                            case 3:
                              balance = {"SAVINGS": _wallet["savings"]};
                              break;
                          }
                          return WalletBalance(
                            overview: balance,
                            type: balance.keys.first,
                            coins: _coins,
                            isVisible: _isVisible,
                            setVisible: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                              Helpers.writePref(
                                  Defaults.showBalance, _isVisible ? "1" : "0");
                            },
                          );
                        },
                        itemCount: 4,
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
                  if (_favourites.isNotEmpty)
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
                          for (var i = 0; i < _favourites.length; i += 1)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  menuSelected(_favourites[i]["type"]);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: i == 0
                                              ? Palette.get("main.primary")
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
                                          Defaults.favouritesIcons[
                                                  _favourites[i]["type"]] ??
                                              "",
                                          "regular",
                                          size: 20.0,
                                          color: i == 0
                                              ? "text.white"
                                              : "text.black"),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Widgets.buildText(
                                        _favourites[i]["title"], context)
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  SizedBox(
                      height: compliance.containsKey("title") ? 20.0 : 1.0),
                  if (compliance.containsKey("title"))
                    Container(
                        width: MediaQuery.of(context).size.width,
                        constraints: const BoxConstraints(
                            minHeight: 100.0, maxHeight: 120.0),
                        decoration: BoxDecoration(
                          color: Palette.get("main.secondary").withAlpha(50),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets.buildText(
                                  compliance["title"] ?? "", context,
                                  size: 16.0,
                                  isBold: true,
                                  color: "text.primary"),
                              const SizedBox(height: 5.0),
                              Widgets.buildText(
                                  compliance["message"] ?? "", context,
                                  size: 15.0, color: "text.primary"),
                              const SizedBox(height: 15.0),
                              GestureDetector(
                                  onTap: () => {
                                        Navigator.pushNamed(
                                            context, compliance["page"] ?? "",
                                            arguments: compliance["info"] ?? {})
                                      },
                                  child: Widgets.buildText(
                                      compliance["actionText"] ?? "", context,
                                      size: 18.0,
                                      color: "main.secondary",
                                      isMedium: true))
                            ],
                          ),
                        )),
                  SizedBox(height: _promos.isEmpty ? 0.0 : 15.0),
                  if (_promos.isNotEmpty)
                    ConstrainedBox(
                        constraints:
                            BoxConstraints.loose(Size(screenWidth, 180.0)),
                        child: Swiper(
                          outer: true,
                          layout: SwiperLayout.DEFAULT,
                          itemHeight: 150.0,
                          itemWidth: screenWidth,
                          loop: true,
                          autoplay: _promos.length > 1,
                          autoplayDelay: 7000,
                          duration: 1000,
                          onTap: (index) {
                            final promo = _promos.elementAt(index);
                            final type = promo["type"].toString();
                            if (type == "0") {
                              // app
                              switch (promo["link"].toString().toLowerCase()) {
                                case "dashboard":
                                  setState(() {});
                                  break;
                                case "savings":
                                  Navigator.pushReplacementNamed(
                                      context, "/home",
                                      arguments: "1");
                                  break;
                                case "investments":
                                  Navigator.pushReplacementNamed(
                                      context, "/home",
                                      arguments: "2");
                                  break;
                                case "create_savings":
                                  Navigator.pushNamed(context, "/add_savings")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "create_investments":
                                  Navigator.pushNamed(
                                          context, "/add_investments")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "profile":
                                  Navigator.pushNamed(context, "/profile")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "wallet":
                                  Navigator.pushNamed(context, "/wallet")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "bill":
                                  Navigator.pushNamed(context, "/airtime")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "settings":
                                  Navigator.pushNamed(context, "/settings")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "refer":
                                  Navigator.pushNamed(context, "/refer")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "contact":
                                  Navigator.pushNamed(context, "/contact")
                                      .then((value) => setState(() => {}));
                                  break;
                                case "about":
                                  Navigator.pushNamed(context, "/about")
                                      .then((value) => setState(() => {}));
                                  break;
                                default:
                                  setState(() {});
                              }
                            } else if (type == "1") {
                              // external link
                              Helpers.openLink(promo["link"].toString(), "");
                            }
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final promo = _promos.elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${API.uRLPromoPHOTO}${promo["image"].toString()}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                placeholder: (context, url) =>
                                    const SizedBox(height: 0.0),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(height: 0.0),
                              ),
                            );
                          },
                          itemCount: 5,
                        )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Widgets.buildText("Recent Investments", context,
                          isMedium: true),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/home",
                              arguments: "2");
                        },
                        child: Widgets.buildText("See all", context,
                            color: "main.primary"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (_transactions.isNotEmpty)
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
                            final item = _transactions[index];
                            final stat = Defaults.investmentStatus.firstWhere(
                                (stat) =>
                                    stat["value"].toString() ==
                                    (item["status"] ?? "0").toString());
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/investment",
                                    arguments: jsonEncode(item));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: index + 1 < _transactions.length
                                        ? 20.0
                                        : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: Palette.get("main.primary")
                                                  .withAlpha(50),
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: Helpers.fetchIcons(
                                              Defaults.walletTransactionType[4]
                                                      ["icon"]
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
                                                item["name"].toString(),
                                                context,
                                                isMedium: true,
                                                size: 14.0),
                                            Widgets.buildText(
                                                item["daysLeft"].toString(),
                                                context,
                                                size: 12.0,
                                                color: "text.secondary"),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Widgets.buildText(
                                            Helpers.formatCurrency(
                                                item["total"].toString(),
                                                isShow: _isVisible),
                                            context,
                                            weight: 500),
                                        Widgets.buildText(
                                            stat["label"].toString(), context,
                                            size: 14.0,
                                            color:
                                                "${stat["color"].toString()}.main"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: _transactions.length),
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
      required this.isVisible});

  final Map<String, dynamic> overview;
  final Function setVisible;
  final String type;
  final bool isVisible;
  final String coins;

  @override
  Widget build(BuildContext context) {
    final _walletTitle = {
      "NGN": "Naira",
      "USD": "Dollar",
      "INVESTMENTS": "Investments",
      "SAVINGS": "Savings",
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Widgets.buildText(
                            "${!(type == "NGN" || type == "USD") ? "Total " : ""}${_walletTitle[type]} ${type == "NGN" || type == "USD" ? "Balance" : ""}",
                            context,
                            size: 13.0,
                            color: "text.white"),
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
                        type == "ADD"
                            ? "Tap to add account"
                            : Helpers.formatCurrency(
                                (type == "REFERRAL"
                                    ? coins.toString()
                                    : overview[type].toString()),
                                currency:
                                    type == "SAVINGS" || type == "INVESTMENTS"
                                        ? "NGN"
                                        : type,
                                isShow: isVisible),
                        context,
                        color: "text.white",
                        size: 30.0,
                        isBold: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
