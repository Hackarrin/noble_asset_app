import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String _dateFrom = "";
  String _dateTo = "";
  String _status = "";
  final TextEditingController _search = TextEditingController();

  Map<String, dynamic> _overview = {};
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
  ];
  Map<String, List> groupedTransactions = {};
  String _sort = "";
  var loading = false;
  var error = "";

  void groupTransactions() {
    try {
      Map<String, List> transactions = {};
      for (var i = 0; i < _transactions.length; i += 1) {
        final date = _transactions[i]["dateAdded"].toString().split(" ")[0];
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

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res =
          await JWT.getTransactions(_dateFrom, _dateTo, _status, _search.text);
      print("dante ${res["images"]}");
      setState(() {
        _transactions = res["data"];
        _overview = res["overview"];
        loading = false;
        error = "";
      });
      groupTransactions();
      if (groupedTransactions.isEmpty) {
        error =
            "You do have any transaction ${_search.text.isEmpty && _dateFrom.isEmpty && _dateTo.isEmpty && _status.isEmpty ? "at the moment! Don't worry. They'll show up here when you add some." : "matching your search parameters."}";
      }
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      groupTransactions();
      fetch();
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
                "${Helpers.formatCurrency(_overview.containsKey("totalTransaction") ? _overview["totalTransaction"].toString() : "0")} spent",
                context,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: loading
                ? Shimmer.fromColors(
                    baseColor: Palette.get("background.neutral"),
                    highlightColor: Palette.get("background.default"),
                    loop: 1,
                    child: AbsorbPointer(child: buildContent(screenWidth)))
                : (error.isNotEmpty
                    ? Alert.showErrorMessage(context, "",
                        message: error, buttonText: "Retry", action: () {
                        setState(() {
                          _dateFrom = "";
                          _dateTo = "";
                          _status = "";
                        });
                        _search.text = "";
                        fetch();
                      })
                    : buildContent(screenWidth)),
          ),
        ));
  }

  Widget buildContent(double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150.0,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemExtent: 320.0,
              primary: false,
              children: [
                SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: TransactionsCard(
                      value: Helpers.formatCurrency(
                          _overview.containsKey("bookingTransactions")
                              ? _overview["bookingTransactions"].toString()
                              : "0"),
                      title: "Bookings",
                      subtitle:
                          "No. of Payments: ${Helpers.formatNumber(_overview.containsKey("bookingCount") ? _overview["bookingCount"].toString() : "0")}"),
                ),
                SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: TransactionsCard(
                      value: Helpers.formatCurrency(
                          _overview.containsKey("otherTransactions")
                              ? _overview["otherTransactions"].toString()
                              : "0"),
                      title: "Other Transactions (Refunds etc)",
                      subtitle:
                          "No. of Payments: ${Helpers.formatNumber(_overview.containsKey("bankCount") ? _overview["bankCount"].toString() : "0")}"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: _search,
            onSubmitted: (v) {
              fetch();
            },
            decoration: Widgets.inputDecoration("",
                color: Palette.get("background.paper"),
                radius: 60.0,
                hint: "Search transaction",
                isFilled: true,
                isOutline: true,
                borderColor: Palette.get("text.disabled"),
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
                    title =
                        "Date${_dateFrom.isNotEmpty ? " (${Helpers.formatDate(_dateFrom, formatString: "MMM dd,yyyy")} - ${Helpers.formatDate(_dateTo, formatString: "MMM dd,yyyy")})" : ""}";
                  } else if (index == 1) {
                    title =
                        "Status ${_status.isNotEmpty ? (_status == "1" ? "(Successful)" : "(Failed)") : ""}";
                  }
                  return GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        final date = await Sheets.selectDate("",
                            isRange: true, title: "Select start and end date");
                        final dateSplit = date.split("_");
                        setState(() {
                          _dateFrom = dateSplit.first;
                          _dateTo = dateSplit.last;
                        });
                        fetch();
                      } else if (index == 1) {
                        final res = await Sheets.showSortBy(_status,
                            items: [
                              {"name": "All Status", "value": ""},
                              {"name": "Successful", "value": "1"},
                              {"name": "Failed", "value": "0"},
                            ],
                            title: "Transaction Status",
                            isShowClear: false);
                        setState(() {
                          _status = res;
                        });
                        fetch();
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
                itemCount: 2),
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
                          Helpers.formatDate(date, formatString: "MMM d, yyyy"),
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
                            border: Border.all(color: Color(0x0D000000))),
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = transactions[index];
                              return GestureDetector(
                                onTap: () {
                                  Sheets.showTransactionDetails(item);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index + 1 == transactions.length
                                          ? 0
                                          : 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color:
                                                    Palette.get("main.primary")
                                                        .withAlpha(50),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: Helpers.fetchIcons(
                                                Defaults.walletTransactionType[
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
                                                  "#${item["bookingId"].toString()}",
                                                  context),
                                              Widgets.buildText(
                                                  Helpers.formatDate(
                                                      item["dateAdded"]
                                                          .toString(),
                                                      formatString:
                                                          "MMM d, yyyy hh:mm aaa"),
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
                                              "${item["type"].toString() == "4" ? "+" : "-"}${Helpers.formatCurrency(item["amount"].toString())}",
                                              context,
                                              weight: 500,
                                              color:
                                                  item["type"].toString() == "4"
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
    );
  }
}

class TransactionsCard extends StatelessWidget {
  const TransactionsCard(
      {super.key,
      required this.value,
      required this.title,
      required this.subtitle});

  final String value;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
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
                title,
                context,
                size: 13.0,
              ),
              SizedBox(height: 20.0),
              Widgets.buildText(
                  Helpers.formatCurrency(value.toString()), context,
                  size: 24.0, isMedium: true),
              SizedBox(height: 20.0),
              if (subtitle.isNotEmpty)
                Widgets.buildText(subtitle, context, color: "text.secondary"),
            ],
          ),
        ),
      ),
    );
  }
}
