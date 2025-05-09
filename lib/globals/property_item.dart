import 'dart:convert';

import 'package:afritas/main.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PropertyItem extends StatelessWidget {
  const PropertyItem(
      {super.key,
      required this.item,
      this.offset = 0,
      this.direction = "vertical",
      this.isDetailed = false,
      this.action,
      this.close});

  final Function? action;
  final Function? close;
  final double offset;
  final bool isDetailed;
  final String direction;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/property", arguments: jsonEncode(item));
      },
      child: Container(
          width: isDetailed ? null : 300.0,
          height: isDetailed ? null : 300.0,
          margin: EdgeInsets.only(right: offset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item["isPremium"].toString() == "1" && isDetailed)
                IntrinsicWidth(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF252387),
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        spacing: 5.0,
                        children: [
                          Helpers.fetchIcons("star", "regular",
                              color: "text.white"),
                          Widgets.buildText("Premium", context,
                              color: "text.white")
                        ],
                      )),
                ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: direction == "horizontal" ? 10.0 : 10.0,
                        vertical: 10.0),
                    decoration: BoxDecoration(
                        boxShadow:
                            (item["isPremium"].toString() == "1" && isDetailed)
                                ? [
                                    BoxShadow(
                                        color: Color(0x66252387),
                                        offset: Offset(0, -2),
                                        spreadRadius: 2,
                                        blurRadius: 4)
                                  ]
                                : null,
                        color: Palette.getColor(context, "background", "paper"),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [itemPhoto(context), itemContent(context)],
                    ),
                  ),
                  if (direction == "horizontal")
                    Positioned(
                        top: 20,
                        right: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0x80000000),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Row(
                            spacing: 2.0,
                            children: [
                              Widgets.buildText(
                                  Helpers.formatCurrency(
                                      item["price"].toString(),
                                      isCompact: true),
                                  context,
                                  isMedium: true,
                                  color: "text.white",
                                  size: 13.0),
                              Widgets.buildText(
                                  item["type"].toString() == "rent"
                                      ? "/yr"
                                      : "",
                                  context,
                                  color: "text.white")
                            ],
                          ),
                        )),
                  if (direction == "vertical" && !isDetailed)
                    Positioned(
                        top: 20,
                        left: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              borderRadius: BorderRadius.circular(80)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Widgets.buildText(
                              item["type"].toString() == "land"
                                  ? "Buy Land"
                                  : "${item["type"].toString().capitalize()} House",
                              context),
                        )),
                  if (direction == "vertical" && isDetailed)
                    Positioned(
                        top: 20,
                        left: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              borderRadius: BorderRadius.circular(80)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Widgets.buildText(
                              "Ref: ${item["ref"].toString()}", context),
                        )),
                ],
              ),
            ],
          )),
    );
  }

  Widget itemContent(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  if (!isDetailed)
                    Widgets.buildText(
                      item["name"].toString(),
                      context,
                      weight: 500,
                      size: 14.0,
                    ),
                  if (!isDetailed)
                    SizedBox(height: direction == "vertical" ? 10.0 : 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 5.0,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 2.0,
                          children: [
                            Helpers.fetchIcons(
                              "marker",
                              "solid",
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
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Palette.getColor(
                                context, "background", "default"),
                            radius: 20.0,
                            child: Helpers.fetchIcons(
                              "heart",
                              "regular",
                              size: 20.0,
                              color: "main.primary",
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: direction == "vertical" ? 10.0 : 0.0),
                  if (direction == "vertical")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10.0,
                      children: [
                        if (item["type"] != "land")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 10.0,
                            children: [
                              Row(
                                spacing: 5.0,
                                children: [
                                  Helpers.fetchIcons("bath", "solid",
                                      color: "text.black", size: 16.0),
                                  Widgets.buildText(
                                      Helpers.formatNumber(
                                          item["baths"].toString()),
                                      context,
                                      color: "text.secondary")
                                ],
                              ),
                              Row(
                                spacing: 5.0,
                                children: [
                                  Helpers.fetchIcons("couch", "solid",
                                      color: "text.black", size: 16.0),
                                  Widgets.buildText(
                                      item["garage"].toString(), context,
                                      color: "text.secondary")
                                ],
                              ),
                              Row(
                                spacing: 5.0,
                                children: [
                                  Helpers.fetchIcons("bed-empty", "solid",
                                      color: "text.black", size: 16.0),
                                  Widgets.buildText(
                                      item["beds"].toString(), context,
                                      color: "text.secondary")
                                ],
                              )
                            ],
                          ),
                        if (item["type"] == "land")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 10.0,
                            children: [
                              Row(
                                spacing: 2.0,
                                children: [
                                  Helpers.fetchIcons(
                                      "memo-circle-check", "solid",
                                      color: "text.black", size: 14.0),
                                  Widgets.buildText("C of O", context,
                                      color: "text.secondary")
                                ],
                              ),
                              Row(
                                spacing: 2.0,
                                children: [
                                  Helpers.fetchIcons("lamp-street", "solid",
                                      color: "text.black", size: 14.0),
                                  Widgets.buildText("Light", context,
                                      color: "text.secondary")
                                ],
                              ),
                              Row(
                                spacing: 2.0,
                                children: [
                                  Helpers.fetchIcons("user-shield", "solid",
                                      color: "text.black", size: 14.0),
                                  Widgets.buildText("Security", context,
                                      color: "text.secondary", size: 13.0)
                                ],
                              )
                            ],
                          ),
                        if (direction == "vertical" && !isDetailed)
                          Expanded(
                            child: Widgets.buildText(
                                Helpers.formatCurrency(
                                    item["price"].toString()),
                                context,
                                color: "main.primary",
                                isMedium: true,
                                isRight: true),
                          ),
                      ],
                    )
                ],
              ),
            ),
            if (isDetailed)
              Column(
                spacing: 5.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 1.0),
                  Widgets.buildText(
                      "Listed on ${Helpers.formatDate(item["dateAdded"].toString(), formatString: "dd MMM yyyy")}",
                      context,
                      color: "text.secondary"),
                  Widgets.buildText(
                      "Updated on ${Helpers.formatDate(item["dateUpdated"].toString(), formatString: "dd MMM yyyy")}",
                      context,
                      color: "text.secondary"),
                ],
              ),
          ],
        ),
        if (isDetailed)
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Divider(
                  color: Color(0x0D000000),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10.0,
                  children: [
                    Image.asset(
                      item["vendorPhoto"].toString(),
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      spacing: 15.0,
                      children: [
                        Row(
                          spacing: 5.0,
                          children: [
                            Helpers.fetchIcons("phone-call", "solid",
                                color: "main.primary"),
                            Widgets.buildText("Call", context,
                                color: "text.secondary")
                          ],
                        ),
                        Row(
                          spacing: 5.0,
                          children: [
                            Helpers.fetchIcons("envelope", "solid",
                                color: "main.primary"),
                            Widgets.buildText("Mail", context,
                                color: "text.secondary")
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget itemPhoto(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(item["image"].toString(),
              width: double.infinity,
              height: direction == "vertical"
                  ? isDetailed
                      ? 270
                      : 180.0
                  : 170.0,
              fit: BoxFit.cover),
        ),
        if (isDetailed)
          Container(
              width: double.infinity,
              height: 270,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 10.0,
                children: [
                  Expanded(
                    child: Widgets.buildText(item["name"].toString(), context,
                        isMedium: true, color: "text.white"),
                  ),
                  Row(
                    children: [
                      Widgets.buildText(
                          Helpers.formatCurrency(item["price"].toString()),
                          context,
                          isMedium: true,
                          color: "text.white"),
                      Widgets.buildText("/ yr", context,
                          isMedium: true, size: 13.0, color: "text.white"),
                    ],
                  ),
                ],
              )),
        if (direction == "vertical")
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
