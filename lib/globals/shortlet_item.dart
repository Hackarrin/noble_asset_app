import 'dart:convert';

import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShortletItem extends StatelessWidget {
  const ShortletItem(
      {super.key,
      required this.item,
      this.offset = 0,
      this.direction = "vertical",
      this.isBordered = true,
      this.action,
      this.close});

  final Function? action;
  final Function? close;
  final double offset;
  final bool isBordered;
  final String direction;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/shortlet",
              arguments: jsonEncode(item));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: offset),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: direction == "horizontal" ? 10.0 : 10.0,
                        vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Palette.getColor(context, "background", "paper"),
                        border: isBordered
                            ? Border.all(color: Color(0x0d000000))
                            : null,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: direction == "horizontal"
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: !isBordered ? 100 : 150,
                                  child: hotelPhoto(context)),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(child: hotelContent(context))
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hotelPhoto(context),
                              hotelContent(context)
                            ],
                          ),
                  )
                ],
              ),
              if (((item["isBreakfast"] ?? "").toString() == "1" ||
                      (item["isGuestFavourite"] ?? "").toString() == "1") &&
                  isBordered)
                Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      width: (item["isGuestFavourite"] ?? "").toString() == "1"
                          ? 130
                          : 150,
                      height: 33,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/breakfast-bg.png"),
                              fit: BoxFit.contain)),
                      padding: EdgeInsets.only(left: 18.0, top: 2.0),
                      child: Widgets.buildText(
                          (item["isGuestFavourite"] ?? "").toString() == "1"
                              ? "Guest Favorite"
                              : "Breakfast included",
                          context,
                          color: "text.white"),
                    )),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget hotelContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        if (direction == "horizontal")
          Row(
            children: [
              Helpers.fetchIcons(
                "star",
                "solid",
                color: "warning.main",
                size: 10.0,
              ),
              const SizedBox(
                width: 2.0,
              ),
              Widgets.buildText(
                item["rating"].toString(),
                context,
              )
            ],
          ),
        if (direction == "vertical")
          Widgets.buildText(item["title"].toString(), context, isMedium: true),
        if (direction == "horizontal")
          Widgets.buildText(item["title"].toString(), context,
              weight: 400, size: 15.0),
        SizedBox(height: direction == "vertical" ? 10.0 : 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Widgets.buildText("Hosted by ${item['host']}", context,
                weight: 500, size: 13.0),
          ),
          if (direction == "vertical") const SizedBox(width: 5.0),
          if (direction == "vertical")
            Row(
              children: [
                Helpers.fetchIcons(
                  "star",
                  "solid",
                  color: "warning.main",
                  size: 10.0,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Widgets.buildText(
                  item["rating"].toString(),
                  context,
                )
              ],
            ),
        ]),
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
              child: Widgets.buildText(item["location"].toString(), context,
                  color: "text.secondary"),
            ),
          ],
        ),
        SizedBox(height: direction == "vertical" ? 10.0 : 15.0),
        Row(
          children: [
            Widgets.buildText(
                Helpers.formatCurrency(item["price"].toString()), context,
                color: "main.primary", weight: 600),
            Widgets.buildText(
              "/day",
              context,
            ),
          ],
        ),
      ],
    );
  }

  Widget hotelPhoto(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
              item.containsKey("image")
                  ? item["image"].toString()
                  : item["images"][0],
              width: double.infinity,
              height: direction == "vertical" ? 200.0 : 145.0,
              fit: BoxFit.cover),
        ),
        if (isBordered)
          Positioned(
            top: 10.0,
            right: close != null ? 60.0 : 10.0,
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor:
                    Palette.getColor(context, "background", "paper"),
                radius: 20.0,
                child: Helpers.fetchIcons(
                  "heart",
                  "regular",
                  size: 20.0,
                  color: "main.primary",
                ),
              ),
            ),
          ),
        if (close != null)
          Positioned(
            top: 10.0,
            right: 10.0,
            child: GestureDetector(
              onTap: () {
                close!();
              },
              child: CircleAvatar(
                backgroundColor:
                    Palette.getColor(context, "background", "paper"),
                radius: 20.0,
                child: Transform.rotate(
                  angle: -math.pi / 4,
                  child: Helpers.fetchIcons(
                    "plus-small",
                    "regular",
                    size: 26.0,
                    color: "text.black",
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
