import 'dart:convert';

import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

class HotelBooking extends StatelessWidget {
  const HotelBooking(
      {super.key, required this.item, this.action, this.isReview = false});

  final Function? action;
  final bool isReview;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/booking", arguments: jsonEncode(item));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Palette.getColor(context, "background", "paper"),
                        border: Border.all(color: Color(0x0d000000)),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 150, child: hotelPhoto(context)),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(child: hotelContent(context))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(color: Color(0x14000000)),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!isReview)
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      if (item["status"].toString() == "0") {
                                      } else {
                                        print("roomType - ${item["roomType"]}");
                                        Navigator.pushNamed(context, "/hotel",
                                            arguments: jsonEncode(
                                                item["roomType"] ?? {}));
                                      }
                                    },
                                    style: Widgets.buildButton(context,
                                        background:
                                            item["status"].toString() == "2"
                                                ? Palette.get("main.primary")
                                                : Color(0x3341B11A),
                                        vertical: 15.0,
                                        horizontal: 20.0,
                                        radius: 30.0),
                                    child: Widgets.buildText(
                                        item["status"].toString() == "0" ||
                                                item["status"].toString() == "1"
                                            ? "Cancel"
                                            : "Re-book",
                                        context,
                                        color: item["status"].toString() == "2"
                                            ? "text.white"
                                            : "main.primary",
                                        isMedium: true)),
                              ),
                            if (!isReview)
                              const SizedBox(
                                width: 10.0,
                              ),
                            if (item["status"].toString() != "2")
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      if (item["status"].toString() == "0") {
                                      } else {
                                        Navigator.pushNamed(context, "/hotel",
                                            arguments: jsonEncode(
                                                item["roomType"] ?? {}));
                                      }
                                    },
                                    style: Widgets.buildButton(context,
                                        background: Palette.get("main.primary"),
                                        vertical: 15.0,
                                        horizontal: 20.0,
                                        radius: 30.0),
                                    child: Widgets.buildText(
                                        item["status"].toString() == "4"
                                            ? "Add Reviews"
                                            : "E-receipt",
                                        context,
                                        color: "text.white",
                                        isMedium: true)),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget hotelContent(BuildContext context) {
    final stat = Defaults.bookingStatus.firstWhere((stat) =>
        stat["value"].toString() == (item["status"] ?? "0").toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Widgets.buildText(
            item.containsKey("roomType")
                ? item["roomType"] is List
                    ? (item["roomType"][0]["listingName"] ??
                            item["roomType"][0]["title"])
                        .toString()
                    : (item["roomType"]["listingName"] ??
                            item["roomType"]["title"])
                        .toString()
                : item["title"].toString(),
            context,
            isMedium: true),
        SizedBox(height: 15.0),
        Widgets.buildText(
            Helpers.formatDistanceDate(
                item["checkin"].toString(), item["checkout"].toString()),
            context,
            color: "text.secondary"),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Helpers.fetchIcons(
              "location-alt",
              "regular",
              size: 15.0,
              color: "main.primary",
            ),
            const SizedBox(
              width: 2.0,
            ),
            Expanded(
              child: Widgets.buildText(
                  item.containsKey("roomType")
                      ? item["roomType"] is List
                          ? item["roomType"][0]["location"].toString()
                          : item["roomType"]["location"].toString()
                      : item["location"].toString(),
                  context,
                  color: "text.secondary"),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          children: [
            Widgets.buildText(
                Helpers.formatCurrency(item["total"].toString()), context,
                color: "main.primary", weight: 600),
            Widgets.buildText(
              "/ ${Helpers.dateDiff(item["checkin"].toString(), item["checkout"].toString())} night${Helpers.dateDiff(item["checkin"].toString(), item["checkout"].toString()) > 1 ? "s" : ""}",
              context,
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Widgets.buildText(stat["label"].toString(), context,
            color: "${stat["color"]}.main", weight: 600),
      ],
    );
  }

  Widget hotelPhoto(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Helpers.getPhoto(
            item.containsKey("image")
                ? item["image"].toString()
                : item.containsKey("roomType")
                    ? (item["roomType"] is List
                        ? item["roomType"][0]["featuredPhoto"].toString()
                        : item["roomType"]["featuredPhoto"].toString())
                    : "",
            type: item["type"].toString() == "0"
                ? "hotel"
                : (item["type"].toString() == "1" ? "car" : "shortlet"),
            text: item.containsKey("roomType")
                ? item["roomType"] is List
                    ? item["roomType"][0]["title"].toString()
                    : item["roomType"]["title"].toString()
                : item["title"].toString(),
            height: 145.0,
          ),
        ),
      ],
    );
  }
}
