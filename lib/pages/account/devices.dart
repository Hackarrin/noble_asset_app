import 'dart:convert';

import 'package:cribsfinder/globals/hotel_booking.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> with SingleTickerProviderStateMixin {
  final devices = [
    {
      "name": "GSA",
      "icon": "brand-apple",
      "os": "iOS",
      "location": "ibeju lekki lagos Nigeria",
      "date": "2025-03-22 08:00:00",
      "status": "0"
    },
    {
      "name": "Samsung S20",
      "icon": "brand-android",
      "os": "Android 18.0",
      "location": "ibeju lekki lagos Nigeria",
      "date": "2025-03-22 08:00:00",
      "status": "1"
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
        title: Widgets.buildText("Device History", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Color(0x1A000000))),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = devices[index];
                          return GestureDetector(
                            onTap: () {
                              if (item["page"].toString().startsWith("/")) {
                                Navigator.pushNamed(
                                    context, item["page"].toString());
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: index == 0
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Color(0x1A000000)))),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Helpers.fetchIcons(
                                                item["icon"].toString(),
                                                "solid",
                                                size: 16.0),
                                            const SizedBox(width: 5.0),
                                            Widgets.buildText(
                                                "${item["os"].toString()} · ${item["name"].toString()}",
                                                context,
                                                size: 14.0,
                                                weight: 400,
                                                color: "text.primary"),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  item["status"].toString() ==
                                                          "0"
                                                      ? "error.main"
                                                      : "main.primary"),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          padding: const EdgeInsets.all(5.0),
                                          child: Widgets.buildText(
                                              item["status"].toString() == "0"
                                                  ? "Logged-out"
                                                  : "Logged-in",
                                              context,
                                              size: 11.0,
                                              weight: 500,
                                              color: "text.white"),
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Widgets.buildText(
                                        "${item["location"].toString()} · ${Helpers.formatDate(item["date"].toString(), formatString: "dd MMM yyyy hh:mma")}",
                                        context,
                                        size: 12.0,
                                        weight: 400,
                                        color: "text.primary"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: devices.length,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
