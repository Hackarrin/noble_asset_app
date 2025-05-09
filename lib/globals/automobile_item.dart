import 'dart:convert';

import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [itemPhoto(context), itemContent(context)],
                    ),
                  )
                ],
              ),
              if (direction == "vertical")
                Positioned(
                    top: 20,
                    left: 30,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.circular(80)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Widgets.buildText(
                        item["listedBy"],
                        context,
                      ),
                    )),
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
                size: direction == "vertical" ? 16.0 : 13.0,
              ),
              if (direction == "vertical")
                Container(
                  decoration: BoxDecoration(
                      color: Palette.get("background.default"),
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Widgets.buildText(item["type"].toString(), context,
                      color: "main.primary", weight: 500),
                )
            ],
          ),
          SizedBox(height: direction == "vertical" ? 10.0 : 15.0),
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
              if (direction == "horizontal" &&
                  item.containsKey("isNew") &&
                  item["isNew"].toString() == "1")
                Container(
                  decoration: BoxDecoration(
                      color: Palette.get("background.default"),
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Widgets.buildText("New to Afritas", context,
                      color: "main.primary"),
                ),
              if (direction == "horizontal" && !item.containsKey("isNew") ||
                  item["isNew"].toString() == "0")
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("star", "solid", color: "warning.main"),
                    Widgets.buildText(item["rating"].toString(), context),
                    Widgets.buildText(
                        "(${Helpers.formatCurrency(item["reviews"].toString())}+)",
                        context,
                        color: "text.disabled")
                  ],
                ),
              Row(
                children: [
                  Widgets.buildText(
                      Helpers.formatCurrency(item["price"].toString()), context,
                      color: "main.primary", isMedium: true, size: 13.0),
                  Widgets.buildText(
                    "/night",
                    context,
                  ),
                ],
              ),
            ],
          ),
          if (direction == "vertical")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(color: Color(0x1A000000)),
            ),
          if (direction == "vertical")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5.0,
              children: [
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("user", "solid",
                        color: "main.primary", size: 16.0),
                    Widgets.buildText(
                        "${Helpers.formatNumber(item["passengers"])} Seats",
                        context,
                        color: "text.secondary")
                  ],
                ),
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("gas-pump", "solid",
                        color: "main.primary", size: 16.0),
                    Widgets.buildText(item["power"], context,
                        color: "text.secondary")
                  ],
                ),
                Row(
                  spacing: 5.0,
                  children: [
                    Helpers.fetchIcons("steering-wheel", "solid",
                        color: "main.primary", size: 16.0),
                    Widgets.buildText(item["steering"], context,
                        color: "text.secondary")
                  ],
                )
              ],
            )
        ],
      ),
    );
  }

  Widget itemPhoto(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: direction == "vertical" ? 200.0 : 145.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Swiper(
                loop: true,
                itemBuilder: (BuildContext context, int index) {
                  final image = (item["images"] ?? [item["image"]])[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(image.toString(),
                        width: double.infinity,
                        height: direction == "vertical" ? 200.0 : 145.0,
                        fit: BoxFit.cover),
                  );
                },
                itemCount: (item["images"] ?? [item["image"]]).length,
                pagination: SwiperPagination(),
              ),
            )),
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
