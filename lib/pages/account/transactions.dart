import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final profile = {
    "fname": "Olamide",
    "lname": "Owoeye",
    "email": "info@useafritas.com",
    "phone": "091833383",
    "dateAdded": "2025-01-01",
    "isVerified": "1",
    "status": "1",
    "photo": "",
    "gender": "M",
    "dob": "1995-01-02",
    "address": "ibeju Lekki Lagos Nigeria"
  };
  String _walletBalance = '100000';
  String _currency = "NGN";
  String _date = "";
  String _category = "";
  String _status = "";
  Map<String, dynamic> _wallet = {"NGN": 100.0, "USD": 100.0, "GBP": 100.0};
  Map<String, dynamic> _overview = {
    "totalPaid": 100.0,
    "totalPending": 900.0,
    "total": 1000.0,
    "customers": 0.0,
    "vendors": 10.0,
    "activeCustomers": 0,
    "activeVendors": 5
  };
  final List _transactions = [
    {
      "type": 0,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 1,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 2,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 3,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 4,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 5,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 6,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 7,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "USD",
    },
    {
      "type": 8,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "NGN",
    },
    {
      "type": 9,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "USD",
    },
    {
      "type": 10,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "NGN",
    },
    {
      "type": 11,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "NGN",
    },
    {
      "type": 12,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "USD",
    },
    {
      "type": 13,
      "amount": 940343,
      "title": "Roland Emmanuel",
      "date": "2025-02-03",
      "currency": "NGN",
    },
  ];
  Map<String, List> groupedTransactions = {};
  String _sort = "";

  void groupTransactions() {
    try {
      Map<String, List> transactions = {};
      for (var i = 0; i < _transactions.length; i += 1) {
        final date = _transactions[i]["date"].toString().split(" ")[0];
        if (transactions.containsKey(date)) {
          transactions[date]!.add(_transactions[i]);
        } else {
          transactions[date] = [_transactions[i]];
        }
      }
      setState(() {
        groupedTransactions = transactions;
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      groupTransactions();
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          elevation: 0,
          backgroundColor: Palette.getColor(context, "background", "paper"),
          foregroundColor: Palette.getColor(context, "text", "disabled"),
          toolbarHeight: 80.0,
          title: Column(
            children: [
              Widgets.buildText("Transactions", context, isMedium: true),
              Widgets.buildText(
                "${Helpers.formatCurrency(_walletBalance, currency: _currency)} available",
                context,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () async {
                    final res = await Sheets.showSortBy(_sort, items: [
                      {"name": "All", "value": ""},
                      {"name": "Active", "value": "1"},
                      {"name": "Inactive", "value": "0"},
                    ]);
                    setState(() {
                      _sort = res;
                    });
                  },
                  style: Widgets.buildButton(context,
                      sideColor: Color(0xFFF1F1F1), radius: 50.0),
                  icon: Helpers.fetchIcons("cloud-download-alt", "regular",
                      size: 17.0)),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: Widgets.inputDecoration("",
                        color: Palette.get("background.paper"),
                        radius: 60.0,
                        hint: "Search by transaction name",
                        isFilled: true,
                        isOutline: true,
                        hintColor: Palette.get("text.secondary"),
                        prefixIcon: UnconstrainedBox(
                            child: Helpers.fetchIcons("search", "regular",
                                color: "main.primary", size: 18.0))),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var title = "";
                          if (index == 0) {
                            title = "Date";
                          } else if (index == 1) {
                            title = "All Categories";
                          } else if (index == 2) {
                            title = "Status";
                          } else if (index == 3) {
                            title = "Currency";
                          }
                          return GestureDetector(
                            onTap: () async {
                              print("index $index");
                              if (index == 0) {
                                final res = await Sheets.showSortBy(_date,
                                    items: [
                                      {"name": "All Date", "value": ""},
                                      {
                                        "name": "Last Week",
                                        "value": "last_week"
                                      },
                                      {
                                        "name": "Last 30 days",
                                        "value": "last_30_days"
                                      },
                                      {
                                        "name": "Custom Range",
                                        "value": "custom"
                                      },
                                    ],
                                    title: "Date filters",
                                    isShowClear: false);
                                if (res == "custom") {
                                  final date = await Sheets.selectDate("",
                                      isRange: true,
                                      title: "Select custom range");
                                  setState(() {
                                    _date = date;
                                  });
                                } else {
                                  setState(() {
                                    _date = res;
                                  });
                                }
                              } else if (index == 1) {
                                final res = await Sheets.showSortBy(_category,
                                    items: Defaults.walletTransactionType,
                                    title: "Select Categories",
                                    isShowClear: false,
                                    isShowIcon: true);
                                setState(() {
                                  _category = res;
                                });
                              } else if (index == 2) {
                                final res = await Sheets.showSortBy(_status,
                                    items: [
                                      {"name": "All Status", "value": ""},
                                      {"name": "Successful", "value": "1"},
                                      {"name": "In Progress", "value": "2"},
                                      {"name": "Failed", "value": "0"},
                                    ],
                                    title: "Transaction Status",
                                    isShowClear: false);
                                setState(() {
                                  _status = res;
                                });
                              } else if (index == 3) {
                                final res = await Sheets.showSortBy(_status,
                                    items: _wallet.keys
                                        .map((item) => {
                                              ...Defaults.walletTypes
                                                  .firstWhere((w) =>
                                                      w["value"].toString() ==
                                                      item),
                                              "balance":
                                                  _wallet[item].toString()
                                            })
                                        .toList(),
                                    title: "Currency",
                                    isShowClear: false,
                                    isCurrency: true);
                                setState(() {
                                  _status = res;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.get("background.paper"),
                                  borderRadius: BorderRadius.circular(30.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              margin: const EdgeInsets.only(right: 15.0),
                              child: Row(
                                children: [
                                  Widgets.buildText(title, context,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Helpers.fetchIcons("caret-down", "solid")
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: 4),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final date = groupedTransactions.keys.toList()[index];
                        final transactions = groupedTransactions[date] ?? [];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets.buildText(
                                  Helpers.formatDate(date,
                                      formatString: "MMM d, yyyy"),
                                  context,
                                  color: "text.secondary",
                                  weight: 500),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.paper"),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border:
                                        Border.all(color: Color(0x0D000000))),
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = transactions[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                      color: Color(0x1A23813F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  child: Helpers.fetchIcons(
                                                      Defaults
                                                          .walletTransactionType[
                                                              num.tryParse(item[
                                                                              "type"]
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
                                                            item["date"]
                                                                .toString(),
                                                            formatString:
                                                                "MMM d, yyyy"),
                                                        context,
                                                        size: 12.0,
                                                        color:
                                                            "text.secondary"),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Widgets.buildText(
                                                    "${item["type"].toString() == "8" ? "+" : "-"}${Helpers.formatCurrency(item["amount"].toString(), currency: item["currency"])}",
                                                    context,
                                                    weight: 500,
                                                    color: item["type"]
                                                                .toString() ==
                                                            "8"
                                                        ? "success.main"
                                                        : "text.primary"),
                                                Widgets.buildText(
                                                    "Successful", context,
                                                    size: 12.0,
                                                    color: "success.main"),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: transactions.length),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: groupedTransactions.length),
                ],
              ),
            ),
          ),
        ));
  }
}

class TransactionsCard extends StatelessWidget {
  const TransactionsCard(
      {super.key,
      required this.value,
      required this.type,
      required this.secondaryValue});

  final String value;
  final String type;
  final String secondaryValue;

  @override
  Widget build(BuildContext context) {
    final typeText = {
      "totalPaid": "Total Paid",
      "total": "Total Amount Made",
      "customers": "Referred Customers",
      "vendors": "Referred Vendors"
    };
    final secondaryText = {
      "totalPaid": "Pending Payments",
      "total": "",
      "customers": "Active Customers",
      "vendors": "Active Vendors"
    };
    return Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: Container(
        width: double.infinity,
        height: 130.0,
        decoration: BoxDecoration(
            color: Color(0xFFEBEBF9),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widgets.buildText(
                typeText[type].toString(),
                context,
                size: 13.0,
              ),
              SizedBox(height: 20.0),
              Widgets.buildText(
                  Helpers.formatCurrency(value.toString()), context,
                  size: 24.0, isMedium: true),
              SizedBox(height: 20.0),
              if ((secondaryText[type] ?? "").isNotEmpty)
                Widgets.buildText(
                    "${secondaryText[type]}: ${Helpers.formatCurrency(secondaryValue.toString())}",
                    context,
                    color: "text.secondary"),
            ],
          ),
        ),
      ),
    );
  }
}
