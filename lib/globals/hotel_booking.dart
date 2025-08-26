import 'dart:convert';

import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
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
          Navigator.pushNamed(context, "/investment",
              arguments: jsonEncode(item));
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
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        hotelContent(context),
                        const SizedBox(height: 10.0),
                        const Divider(color: Color(0x14000000)),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Widgets.buildText("You'll get:", context,
                                color: "text.secondary", size: 14.0),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Widgets.buildText(
                                  Helpers.formatCurrency(
                                      item["total"].toString()),
                                  context,
                                  color: "main.primary",
                                  isMedium: true,
                                  isRight: true,
                                  size: 14.0),
                            ),
                          ],
                        ),
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
    final stat = Defaults.investmentStatus.firstWhere((stat) =>
        stat["value"].toString() == (item["status"] ?? "0").toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10.0,
          children: [
            Expanded(
                child: Widgets.buildText(item["name"].toString(), context,
                    isMedium: true)),
            Widgets.buildText(stat["label"].toString(), context,
                color: "${stat["color"]}.main", isBold: true, size: 16.0)
          ],
        ),
        SizedBox(height: 5.0),
        Widgets.buildText(item["daysLeft"].toString(), context,
            color: "text.disabled"),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Widgets.buildText("You paid:", context,
                color: "text.secondary", size: 14.0),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Widgets.buildText(
                Helpers.formatCurrency(item["paid"].toString()),
                context,
                isMedium: true,
                size: 14.0,
                isRight: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Widgets.buildText("Interest Earned:", context,
                color: "text.secondary", size: 14.0),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Widgets.buildText(
                  isRight: true,
                  Helpers.formatCurrency(item["interest"].toString()),
                  context,
                  isMedium: true,
                  size: 14.0),
            ),
          ],
        ),
        SizedBox(height: 5.0),
      ],
    );
  }
}
