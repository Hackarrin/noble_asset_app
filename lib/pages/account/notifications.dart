import 'dart:convert';

import 'package:cribsfinder/globals/hotel_booking.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> menus = [
    {
      "title": "Booking Notification",
      "options": [
        {
          "name": "Booking Confirmed",
          "subtext":
              "Get notified when your reservation is successfully booked",
          "value": "0"
        },
        {
          "name": "Upcoming Stay Reminder",
          "subtext": "Receive a reminder before your check-in date",
          "value": "0"
        },
        {
          "name": "Booking Modifications",
          "subtext": "Get updates when your booking details change",
          "value": "0"
        },
        {
          "name": "Check-in & Check-out Alerts",
          "subtext": "Stay updated on check-in and check-out times",
          "value": "0"
        },
        {
          "name": "Cancellation Alerts",
          "subtext": " Receive notifications if your booking is canceled",
          "value": "0"
        },
      ]
    },
    {
      "title": "Cribsfinder Wallet & Payment Notifications",
      "options": [
        {
          "name": "Payment Confirmations",
          "subtext": "Get notified when your payment is successful",
          "value": "0"
        },
        {
          "name": "Invoice & Payment Link Updates",
          "subtext": "Track sent invoices and received payments",
          "value": "0"
        },
        {
          "name": "Booking Modifications",
          "subtext": "Get updates when your booking details change",
          "value": "0"
        },
        {
          "name": "Currency Conversion Alerts",
          "subtext": "Stay updated on dollar-to-naira conversions.",
          "value": "0"
        },
        {
          "name": "Funds Received & Transfers",
          "subtext": "Know when you send or receive money",
          "value": "0"
        },
      ]
    },
    {
      "title": "Messaging & Support Notifications",
      "options": [
        {
          "name": "Messages from Vendors",
          "subtext": "Get notified when a vendor sends you a message",
          "value": "0"
        },
        {
          "name": "Support Updates",
          "subtext": "Stay informed about your support requests",
          "value": "0"
        },
        {
          "name": "Account Activities",
          "subtext": "Gent notified when someone login",
          "value": "0"
        },
      ]
    },
    {
      "title": "Offers & General Notifications",
      "options": [
        {
          "name": "Exclusive Deals & Discounts",
          "subtext": "Be the first to know about special offers",
          "value": "0"
        },
        {
          "name": "New Features & Updates",
          "subtext": "Stay up to date with the latest Cribsfinder features",
          "value": "0"
        },
        {
          "name": "Custom Reminders",
          "subtext": "Set your own booking and payment reminders",
          "value": "0"
        },
      ]
    },
  ];
  var enableBiometric = false;

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
        title: Widgets.buildText("Notification", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                child: Column(
                  children: [
                    Widgets.buildText(
                        "Stay informed and in control! Customize your notifications to receive important updates about your bookings, payments, events, and special offers. Choose what matters most to you and manage your preferences anytime in the Cribsfinder app.",
                        lines: 10,
                        context,
                        color: "text.secondary"),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        final item = menus[i];
                        final List options = (item["options"] ?? []) as List;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText(
                                    item["title"].toString(), context,
                                    size: 13.0,
                                    weight: 500,
                                    color: "text.black"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 0.0,
                                      right: 0.0,
                                      top: 10.0,
                                      bottom: 5.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = options[index];
                                      return GestureDetector(
                                        onTap: () {
                                          if (item["page"]
                                              .toString()
                                              .startsWith("/")) {
                                            Navigator.pushNamed(context,
                                                item["page"].toString());
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: Color(0x1A000000))),
                                          margin: const EdgeInsets.only(
                                              bottom: 10.0),
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 20.0,
                                              bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Widgets.buildText(
                                                          item["name"]
                                                              .toString(),
                                                          context,
                                                          size: 14.0,
                                                          weight: 400,
                                                          color:
                                                              "text.primary"),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Widgets.buildText(
                                                          item["subtext"]
                                                              .toString(),
                                                          context,
                                                          size: 11.0,
                                                          weight: 400,
                                                          lines: 3,
                                                          color:
                                                              "text.primary"),
                                                    ]),
                                              ),
                                              SizedBox(
                                                height: 30.0,
                                                child: FittedBox(
                                                  child: Switch(
                                                      inactiveTrackColor:
                                                          Color(0x80000000),
                                                      inactiveThumbColor:
                                                          Palette.get(
                                                              "text.white"),
                                                      value: item["value"]
                                                              .toString() ==
                                                          "1",
                                                      onChanged: (value) {
                                                        setState(() {
                                                          menus[i]["options"]
                                                                      [index]
                                                                  ["value"] =
                                                              value ? "1" : "0";
                                                        });
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: options.length,
                                  ),
                                )
                              ]),
                        );
                      },
                      itemCount: menus.length,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
