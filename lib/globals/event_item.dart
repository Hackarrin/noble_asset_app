import 'dart:convert';
import 'dart:ui';

import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem(
      {super.key,
      required this.item,
      this.offset = 0,
      this.direction = "vertical",
      this.isRegular = false,
      this.action,
      this.close});

  final Function? action;
  final Function? close;
  final double offset;
  final bool isRegular;
  final String direction;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/event", arguments: jsonEncode(item));
        },
        child: Padding(
          padding: EdgeInsets.only(right: offset),
          child: SizedBox(
            width: double.infinity,
            height: direction == "vertical"
                ? (offset == 0.0 && !isRegular ? 350.0 : 400.0)
                : 170.0,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: direction == "vertical"
                      ? (isRegular ? 400.0 : 350.0)
                      : 170.0,
                  decoration: direction == "vertical" && !isRegular
                      ? null
                      : BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.circular(20.0),
                          border: isRegular
                              ? Border.all(color: Color(0x0D000000))
                              : null),
                  child: Stack(
                    children: [
                      if (direction == "vertical" && !isRegular)
                        itemPhoto(context),
                      if (direction == "vertical" &&
                          offset == 0.0 &&
                          !isRegular)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: IntrinsicHeight(child: itemContent(context)),
                        ),
                      if (direction == "horizontal")
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            right: 0.0,
                            left: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: itemPhoto(context),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: itemContent(context),
                              )),
                              if (direction == "horizontal")
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Palette.get(
                                                "background.default"),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Widgets.buildText(
                                                item["date"]
                                                    .toString()
                                                    .split(" ")[0],
                                                context,
                                                weight: 500),
                                            const SizedBox(
                                              height: 2.0,
                                            ),
                                            Widgets.buildText(
                                                item["date"]
                                                            .toString()
                                                            .split(" ")
                                                            .length >
                                                        1
                                                    ? item["date"]
                                                        .toString()
                                                        .split(" ")[1]
                                                    : "",
                                                context,
                                                color: "main.primary",
                                                isMedium: true),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Palette.get(
                                              item["isLive"].toString() == "1"
                                                  ? "success.main"
                                                  : "error.main"),
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20.0))),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Widgets.buildText(
                                          item["isLive"].toString() == "1"
                                              ? "Buy"
                                              : "Sold",
                                          context,
                                          isMedium: true,
                                          color: "text.white"),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      if (isRegular)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              itemPhoto(context),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Expanded(child: itemContent(context)),
                            ],
                          ),
                        ),
                      if (direction == "vertical")
                        Positioned(
                          top: offset > 0 || isRegular ? 20.0 : 10.0,
                          left: offset > 0 || isRegular ? 20.0 : 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal:
                                    offset > 0 || isRegular ? 15.0 : 10.0),
                            child: Column(
                              children: [
                                Widgets.buildText(
                                    (offset > 0 || isRegular)
                                        ? item["date"].toString().split(" ")[0]
                                        : "Today",
                                    context,
                                    weight: 500,
                                    size: 12.0),
                                Widgets.buildText(
                                    (offset > 0 || isRegular)
                                        ? (item["date"]
                                                    .toString()
                                                    .split(" ")
                                                    .length >
                                                1
                                            ? item["date"]
                                                .toString()
                                                .split(" ")[1]
                                            : "")
                                        : item["time"].toString(),
                                    context,
                                    isMedium: true,
                                    color: "main.primary"),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (direction == "vertical" && offset > 0.0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: IntrinsicHeight(child: itemContent(context)),
                  ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget itemContent(BuildContext context) {
    return Padding(
      padding: direction == "vertical"
          ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
          : const EdgeInsets.all(0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          enabled: offset == 0.0,
          child: Container(
            decoration: BoxDecoration(
                color: offset > 0
                    ? Palette.get("background.paper")
                    : Color(0x82FFFFFF),
                border: !isRegular && direction == "vertical"
                    ? Border(
                        bottom:
                            BorderSide(color: Palette.get("background.paper")))
                    : Border.all(color: Palette.get("background.paper")),
                borderRadius: BorderRadius.circular(10)),
            padding: direction == "vertical" && !isRegular
                ? EdgeInsets.symmetric(
                    horizontal: offset > 0 ? 10.0 : 20.0, vertical: 10.0)
                : null,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isRegular
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (offset == 0.0 && !isRegular)
                        const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Widgets.buildText(
                                item["title"].toString(), context,
                                isMedium: true, weight: 500),
                          ),
                          if (direction == "vertical" && isRegular)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Widgets.buildText(
                                      Helpers.formatCurrency(
                                          item["price"].toString()),
                                      context,
                                      isMedium: true),
                                  Widgets.buildText(
                                    "/person",
                                    context,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: direction == "vertical" ? 0.0 : 5.0),
                      if (direction == "horizontal")
                        Widgets.buildText(item["subtitle"].toString(), context,
                            weight: 400, size: 11.0, lines: 2),
                      SizedBox(height: direction == "vertical" ? 10.0 : 5.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (direction == "vertical" &&
                                offset == 0.0 &&
                                !isRegular)
                              Expanded(
                                child: Widgets.buildText(
                                    "Hosted by ${item['host']}", context,
                                    weight: 500, size: 13.0),
                              ),
                            if (direction == "vertical" &&
                                offset == 0.0 &&
                                !isRegular)
                              const SizedBox(width: 5.0),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: direction == "vertical" &&
                                        offset == 0.0 &&
                                        !isRegular
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Helpers.fetchIcons(
                                    "marker",
                                    "solid",
                                    size: 15.0,
                                    color: "main.primary",
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: Widgets.buildText(
                                        item["location"].toString(), context,
                                        color: "text.secondary",
                                        isRight: offset == 0 &&
                                            direction == "vertical"),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      if (offset == 0.0)
                        SizedBox(height: direction == "vertical" ? 15.0 : 5.0),
                      if (offset == 0.0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30.0,
                              width: 30 * 3,
                              child: WidgetStack(
                                positions: RestrictedPositions(
                                  maxCoverage: 0.4,
                                  minCoverage: 0.2,
                                  align: StackAlign.left,
                                ),
                                stackedWidgets: [
                                  for (var n = 0;
                                      n < (item["genre"] ?? []).length;
                                      n++)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          border: Border.all(
                                              color: Palette.get(
                                                  "background.paper"))),
                                      child: ClipOval(
                                        child: Image.asset(
                                            item["genre"][n]["photo"]
                                                .toString(),
                                            width: 30.0,
                                            height: 30.0,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                ],
                                buildInfoWidget: (surplus, ctx) {
                                  return Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                          color: Palette.get("main.primary"),
                                          borderRadius:
                                              BorderRadius.circular(24.0)),
                                      child: Center(
                                        child: Widgets.buildText(
                                            '+$surplus', context,
                                            weight: 500,
                                            color: "text.white",
                                            size: 11.0),
                                      ));
                                },
                              ),
                            ),
                            if (direction == "vertical" && !isRegular)
                              Row(
                                children: [
                                  Widgets.buildText(
                                      Helpers.formatCurrency(
                                          item["price"].toString()),
                                      context,
                                      isMedium: true),
                                  Widgets.buildText(
                                    "/person",
                                    context,
                                  ),
                                ],
                              ),
                            if (direction == "vertical" && isRegular)
                              TextButton(
                                  onPressed: () {},
                                  style: Widgets.buildButton(context,
                                      vertical: 15.0,
                                      horizontal: 20.0,
                                      radius: 50.0,
                                      background: Palette.get("main.primary")),
                                  child: Widgets.buildText("Buy Now", context,
                                      color: "text.white"))
                          ],
                        ),
                    ],
                  ),
                ),
                if (offset > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor:
                            Palette.getColor(context, "background", "default"),
                        radius: 20.0,
                        child: Helpers.fetchIcons(
                          "heart",
                          "regular",
                          size: 20.0,
                          color: "main.primary",
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemPhoto(BuildContext context) {
    return SizedBox(
      width: direction == "vertical" ? double.infinity : 120,
      height: direction == "vertical"
          ? isRegular
              ? 230.0
              : 350.0
          : 145.0,
      child: Stack(
        children: [
          Container(
            decoration: offset > 0
                ? BoxDecoration(
                    color: Palette.get("background.paper"),
                    borderRadius: BorderRadius.circular(20.0))
                : null,
            padding: EdgeInsets.all(offset > 0 ? 10.0 : 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                  item.containsKey("image")
                      ? item["image"].toString()
                      : item["images"][0],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
            ),
          ),
          if (direction == "vertical")
            Positioned(
              top: offset > 0 ? 20.0 : 10.0,
              right: offset > 0 ? 20.0 : 10.0,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor:
                      Palette.getColor(context, "background", "paper"),
                  radius: 20.0,
                  child: Helpers.fetchIcons(
                    isRegular ? "heart" : "paper-plane-top",
                    "regular",
                    size: 20.0,
                    color: "main.primary",
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
