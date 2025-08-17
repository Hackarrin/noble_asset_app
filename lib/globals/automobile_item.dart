import 'dart:convert';

import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AutomobileItem extends StatelessWidget {
  const AutomobileItem(
      {super.key,
      required this.item,
      this.offset = 0,
      this.direction = "vertical",
      this.isBordered = true,
      this.action,
      this.wishlistAction,
      this.close});

  final Function? action;
  final Function? close;
  final double offset;
  final bool isBordered;
  final String direction;
  final Function? wishlistAction;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    print("dante: $item");
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/automobile",
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
                        horizontal: direction == "horizontal" ? 10.0 : 20.0,
                        vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Palette.getColor(context, "background", "paper"),
                        border: isBordered
                            ? Border.all(color: Color(0x0d000000))
                            : null,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: direction == "horizontal"
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemPhoto(context),
                              Expanded(child: itemContent(context))
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemPhoto(context),
                              itemContent(context)
                            ],
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget itemContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 5.0,
            children: [
              Widgets.buildText(
                item["title"].toString(),
                context,
                weight: direction == "vertical" ? 500 : 400,
                size: direction == "vertical" ? 16.0 : 14.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Palette.get("background.default"),
                    borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: direction == "vertical" ? 5.0 : 0.0),
                child: Widgets.buildText(item["type"].toString(), context,
                    color: "main.primary", weight: 500),
              )
            ],
          ),
          SizedBox(height: direction == "vertical" ? 10.0 : 5.0),
          if (direction == "horizontal")
            Widgets.buildText(item["description"].toString(), context,
                size: 13.0, lines: 2),
          SizedBox(height: direction == "vertical" ? 0.0 : 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (direction == "vertical")
                Expanded(
                  child: Row(
                    spacing: 2.0,
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
              if (direction == "horizontal")
                Row(
                  spacing: 5.0,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Helpers.fetchIcons("star", "solid", color: "warning.main"),
                    Widgets.buildText(item["rating"].toString(), context),
                  ],
                ),
              Row(
                children: [
                  Widgets.buildText(
                      Helpers.formatCurrency(item["price"].toString()), context,
                      color: "main.primary", isMedium: true, size: 13.0),
                  Widgets.buildText(
                    "/day",
                    context,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(color: Color(0x1A000000)),
          ),
          if (direction == "vertical")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5.0,
              children: [
                if (item.containsKey("capacity"))
                  Row(
                    spacing: 5.0,
                    children: [
                      Helpers.fetchIcons("user", "solid",
                          color: "main.primary", size: 16.0),
                      Widgets.buildText(
                          "${Helpers.formatNumber((item["capacity"] ?? item["seats"]).toString())} Seats",
                          context,
                          color: "text.secondary")
                    ],
                  ),
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("gas-pump", "solid",
                        color: "main.primary", size: 16.0),
                    Widgets.buildText(item["fuelType"].toString(), context,
                        color: "text.secondary")
                  ],
                ),
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("steering-wheel", "solid",
                        color: "main.primary", size: 16.0),
                    Widgets.buildText(item["steering"].toString(), context,
                        color: "text.secondary")
                  ],
                )
              ],
            ),
          if (direction == "horizontal")
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 10.0,
                runSpacing: 5.0,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.start,
                children: [
                  if (item.containsKey("capacity"))
                    FittedBox(
                      child: Row(
                        spacing: 5.0,
                        children: [
                          Helpers.fetchIcons("user", "solid",
                              color: "main.primary", size: 16.0),
                          Widgets.buildText(
                              "${Helpers.formatNumber(item["capacity"].toString())} Seats",
                              context,
                              color: "text.secondary")
                        ],
                      ),
                    ),
                  FittedBox(
                    child: Row(
                      spacing: 5.0,
                      children: [
                        Helpers.fetchIcons("gas-pump", "solid",
                            color: "main.primary", size: 16.0),
                        Widgets.buildText(item["fuelType"].toString(), context,
                            color: "text.secondary")
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      spacing: 5.0,
                      children: [
                        Helpers.fetchIcons("steering-wheel", "solid",
                            color: "main.primary", size: 16.0),
                        Widgets.buildText(item["steering"].toString(), context,
                            color: "text.secondary")
                      ],
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget itemPhoto(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: direction == "vertical" ? 200.0 : 180.0,
            width: direction == "vertical" ? double.infinity : 150.0,
            child: Helpers.getPhoto(
                item.containsKey("photo")
                    ? item["photo"].toString()
                    : (item["image"] ?? item["featuredPhoto"]).toString(),
                type: "car",
                text: item["title"].toString(),
                radius: 20.0,
                height: direction == "vertical" ? 200.0 : 145.0)),
        if (isBordered)
          Positioned(
            top: 10.0,
            right: close != null ? 60.0 : 10.0,
            child: GestureDetector(
              onTap: () {
                Helpers.wishlist(item, "1");
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
