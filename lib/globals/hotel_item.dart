import 'dart:convert';

import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class HotelItem extends StatelessWidget {
  const HotelItem(
      {super.key,
      required this.item,
      this.offset = 0,
      this.direction = "vertical",
      this.isBordered = true,
      this.action,
      this.wishlistAction,
      this.type = "hotel",
      this.close});

  final Function? action;
  final Function? close;
  final Function? wishlistAction;
  final double offset;
  final bool isBordered;
  final String direction;
  final String type;
  final Map<dynamic, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          print("dante - hotel - $item");
          Navigator.pushNamed(
              context, type == "shortlet" ? "/shortlet" : "/hotel",
              arguments: jsonEncode(item));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: offset),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: direction == "horizontal" ? 10.0 : 10.0,
                vertical: 10.0),
            decoration: BoxDecoration(
                color: Palette.getColor(context, "background", "paper"),
                border:
                    isBordered ? Border.all(color: Color(0x0d000000)) : null,
                borderRadius: BorderRadius.circular(30.0)),
            child: direction == "horizontal"
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: [hotelPhoto(context), hotelContent(context)],
                  ),
          ),
        ),
      ),
    ]);
  }

  Widget hotelContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (direction == "vertical") const SizedBox(height: 10.0),
        Widgets.buildText(item["title"].toString(), context, isMedium: true),
        SizedBox(height: direction == "vertical" ? 10.0 : 15.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10.0,
            children: [
              Expanded(
                child: Row(
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
                          item["location"].toString(), context,
                          color: "text.secondary"),
                    ),
                  ],
                ),
              ),
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
        SizedBox(height: direction == "vertical" ? 10.0 : 15.0),
        Row(
          children: [
            Widgets.buildText(
                Helpers.formatCurrency(item["price"].toString()), context,
                color: "main.primary", weight: 600),
            Widgets.buildText(
              "/night",
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
        SizedBox(
            width: double.infinity,
            height: direction == "vertical" ? 200.0 : 145.0),
        Helpers.getPhoto(
            item.containsKey("photo")
                ? item["photo"].toString()
                : item["featuredPhoto"] ?? item["image"].toString(),
            type: "hotel",
            text: item["title"].toString(),
            radius: 20.0,
            height: direction == "vertical" ? 200.0 : 145.0),
        if (isBordered)
          Positioned(
            top: 10.0,
            right: close != null ? 60.0 : 10.0,
            child: GestureDetector(
              onTap: () {
                Helpers.wishlist(item, "0");
                if (wishlistAction != null) {
                  wishlistAction!(item);
                }
              },
              child: CircleAvatar(
                backgroundColor:
                    Palette.getColor(context, "background", "paper"),
                radius: 20.0,
                child: Helpers.fetchIcons(
                  "heart",
                  item["favourite"].toString() == "0" ? "regular" : "solid",
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
