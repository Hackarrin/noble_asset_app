import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class ReferralOverview extends StatefulWidget {
  const ReferralOverview({Key? key}) : super(key: key);

  @override
  _ReferralOverviewState createState() => _ReferralOverviewState();
}

class _ReferralOverviewState extends State<ReferralOverview> {
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
  Map<String, dynamic> _overview = {
    "totalPaid": 100.0,
    "totalPending": 900.0,
    "total": 1000.0,
    "customers": 0.0,
    "vendors": 10.0,
    "activeCustomers": 0,
    "activeVendors": 5
  };
  final List _referrals = [
    {
      "accountStatus": "1",
      "amount": "1000",
      "date": "2024-12-17 08:12:06",
      "name": "Test Refer",
      "status": "1",
      "usertype": "1"
    },
    {
      "accountStatus": "1",
      "amount": "1000",
      "date": "2024-12-17 08:12:06",
      "name": "Test Refer",
      "status": "1",
      "usertype": "1"
    },
    {
      "accountStatus": "1",
      "amount": "1000",
      "date": "2024-12-17 08:12:06",
      "name": "Test Refer",
      "status": "1",
      "usertype": "1"
    },
  ];
  String _sort = "";

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
          title:
              Widgets.buildText("Referrals Overview", context, isMedium: true),
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
                  icon: Helpers.fetchIcons("sort-amount-down", "solid")),
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
                  Widgets.buildText("Last 30 days", context,
                      color: "text.secondary"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(screenWidth, 180.0)),
                      child: Swiper(
                        outer: true,
                        layout: SwiperLayout.CUSTOM,
                        customLayoutOption: Widgets.customLayout(
                            _overview.keys.length + 2, screenWidth,
                            offset: 60.0),
                        itemHeight: 180.0,
                        itemWidth: screenWidth,
                        loop: true,
                        itemBuilder: (BuildContext context, int index) {
                          final columns = [
                            "totalPaid",
                            "total",
                            "customers",
                            "vendors"
                          ];
                          final column = columns[index];
                          var secondaryValue = "0.0";
                          if (column == "totalPaid") {
                            secondaryValue =
                                _overview["totalPending"].toString();
                          } else if (column == "customers") {
                            secondaryValue =
                                _overview["activeCustomers"].toString();
                          } else if (column == "vendors") {
                            secondaryValue =
                                _overview["activeVendors"].toString();
                          }
                          return ReferralOverviewCard(
                              value: _overview[column].toString(),
                              type: column,
                              secondaryValue: secondaryValue.toString());
                        },
                        itemCount: 4,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = _referrals[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              border: Border.all(color: Color(0x0D000000)),
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText("Date", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      Helpers.formatDate(
                                          item["date"].toString(),
                                          formatString: "d MMM yyyy"),
                                      context,
                                      weight: 500)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText(
                                            "Account Type", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      item["usertype"].toString() == "1"
                                          ? "CUSTOMER"
                                          : "VENDOR",
                                      context,
                                      weight: 500)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText(
                                            "Account Name", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      item["name"].toString(), context,
                                      weight: 500)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText(
                                            "Account Status", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      item["status"].toString() == "1"
                                          ? "Active"
                                          : "Inactive",
                                      context,
                                      color:
                                          "${item["status"].toString() == "1" ? "success" : "error"}.main",
                                      weight: 500)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText(
                                            "Amount Name", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      Helpers.formatCurrency(
                                          item["amount"].toString()),
                                      context,
                                      weight: 500)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Widgets.buildText(
                                            "Payout Status", context,
                                            color: "text.secondary"),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Expanded(
                                            child: DashedDivider(
                                          color: Color(0x40000000),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Widgets.buildText(
                                      item["status"].toString() == "1"
                                          ? "Paid"
                                          : "Pending",
                                      context,
                                      color:
                                          "${item["status"].toString() == "1" ? "success" : "error"}.main",
                                      weight: 500)
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: _referrals.length)
                ],
              ),
            ),
          ),
        ));
  }
}

class ReferralOverviewCard extends StatelessWidget {
  const ReferralOverviewCard(
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
