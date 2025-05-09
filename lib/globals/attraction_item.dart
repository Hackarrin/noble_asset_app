import 'dart:convert';
import 'dart:ui';

import 'package:cribsfinder/utils/bookings/attraction.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';

class AttractionItem extends StatelessWidget {
  const AttractionItem(
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
          Navigator.pushNamed(context, "/attraction",
              arguments: jsonEncode(item));
        },
        child: Padding(
          padding: EdgeInsets.only(right: offset),
          child: SizedBox(
            width: double.infinity,
            height: direction == "vertical" ? 350.0 : 180.0,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: direction == "vertical" ? 350.0 : 180.0,
                  decoration: BoxDecoration(
                    color: Palette.get("background.paper"),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: direction == "vertical" && !isRegular
                      ? const EdgeInsets.all(10.0)
                      : null,
                  child: Stack(
                    children: [
                      if (direction == "horizontal")
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            right: 10.0,
                            left: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              itemPhoto(context),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(child: itemContent(context))
                            ],
                          ),
                        ),
                      if (direction == "vertical")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemPhoto(context),
                            Expanded(child: itemContent(context)),
                          ],
                        ),
                      if (direction == "vertical")
                        Positioned(
                          top: offset > 0 || isRegular ? 20.0 : 10.0,
                          left: offset > 0 || isRegular ? 20.0 : 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.paper"),
                                borderRadius: BorderRadius.circular(80)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              children: [
                                Helpers.fetchIcons(
                                  "star",
                                  "solid",
                                  color: "warning.main",
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                  item["rating"].toString(),
                                  context,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!(direction == "vertical" && !isRegular))
                        Positioned(
                            bottom: direction == "vertical" ? 0 : null,
                            top: direction == "horizontal" ? 0 : null,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.get("success.main"),
                                  borderRadius: BorderRadius.only(
                                      topRight: direction == "vertical"
                                          ? Radius.zero
                                          : Radius.circular(20.0),
                                      bottomRight: direction == "horizontal"
                                          ? Radius.zero
                                          : Radius.circular(20.0))),
                              padding: const EdgeInsets.all(10.0),
                              child: Widgets.buildText("Buy", context,
                                  isMedium: true, color: "text.white"),
                            ))
                    ],
                  ),
                ),
                if (direction == "vertical" && offset > 0.0 && !isRegular)
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
      padding: direction == "vertical" && isRegular
          ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
          : const EdgeInsets.all(0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              color: offset > 0
                  ? Palette.get("background.paper")
                  : Color(0x82FFFFFF),
              border: !isRegular && direction == "vertical"
                  ? null
                  : Border.all(color: Palette.get("background.paper")),
              borderRadius: !isRegular && direction == "vertical"
                  ? BorderRadius.zero
                  : BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (offset == 0.0 && !isRegular)
                      const SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.only(
                          right: direction == "horizontal" ? 50.0 : 0.0),
                      child: Widgets.buildText(
                          item["title"].toString(), context,
                          isMedium: true, weight: 500),
                    ),
                    SizedBox(height: direction == "vertical" ? 0.0 : 5.0),
                    if (direction == "horizontal")
                      Container(
                        decoration: BoxDecoration(
                            color: Palette.get("background.default"),
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Widgets.buildText(
                            item["category"].toString().isNotEmpty
                                ? Defaults.attractionCategories
                                    .firstWhere(
                                        (i) =>
                                            i["value"].toString() ==
                                            item["category"].toString(),
                                        orElse: () => {"name": ""})["name"]
                                    .toString()
                                : "",
                            context,
                            weight: 400,
                            size: 11.0),
                      ),
                    SizedBox(height: direction == "vertical" ? 5.0 : 5.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (direction == "vertical")
                            Widgets.buildText(
                                item["duration"].toString(), context),
                          if (direction == "vertical")
                            const SizedBox(width: 5.0),
                          if (direction == "horizontal" || isRegular)
                            Row(
                              mainAxisAlignment: direction == "vertical"
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
                                Widgets.buildText(
                                    item["location"].toString(), context,
                                    color: "text.secondary",
                                    isRight: direction == "vertical"),
                              ],
                            ),
                        ]),
                    SizedBox(height: direction == "vertical" ? 5.0 : 10.0),
                    if (direction == "vertical" && !isRegular)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          Widgets.buildText(
                              item["location"].toString(), context,
                              color: "text.secondary",
                              isRight: direction == "vertical"),
                        ],
                      ),
                    if (direction == "horizontal")
                      Row(
                        spacing: 5.0,
                        children: [
                          Row(
                            children: [
                              Helpers.fetchIcons(
                                "star",
                                "solid",
                                color: "warning.main",
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Widgets.buildText(
                                  item["rating"].toString(), context,
                                  color: "text.secondary"),
                            ],
                          ),
                          Widgets.buildText(
                              "(${Helpers.formatNumber(item["reviews"].toString())} review${item["reviews"].toString() == "0" ? "" : "s"})",
                              context)
                        ],
                      ),
                    SizedBox(height: direction == "vertical" ? 5.0 : 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (offset == 0.0 &&
                            !(direction == "vertical" && !isRegular))
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
                                          item["genre"][n]["photo"].toString(),
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
                        Row(
                          children: [
                            Widgets.buildText(
                                Helpers.formatCurrency(
                                    item["price"].toString()),
                                context,
                                isMedium: true,
                                size: 13.0,
                                color: "main.primary"),
                            Widgets.buildText("/person", context,
                                color: "text.secondary"),
                          ],
                        ),
                      ],
                    ),
                    if (direction == "vertical" && !isRegular)
                      const SizedBox(
                        height: 10.0,
                      ),
                    if (direction == "vertical" && !isRegular)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {},
                            style: Widgets.buildButton(context,
                                vertical: 10.0,
                                horizontal: 10.0,
                                radius: 5.0,
                                background: Palette.get("main.primary")),
                            child: Widgets.buildText("Buy", context,
                                color: "text.white", isMedium: true)),
                      )
                  ],
                ),
              ),
              if (offset == 0 && direction == "vertical" && isRegular)
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
    );
  }

  Widget itemPhoto(BuildContext context) {
    return SizedBox(
      width: direction == "vertical" ? double.infinity : 120,
      height: direction == "vertical"
          ? isRegular
              ? 230.0
              : 160.0
          : 160.0,
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
                    "heart",
                    "regular",
                    size: 20.0,
                    color: "main.primary",
                  ),
                ),
              ),
            ),
          if (direction == "horizontal")
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: GestureDetector(
                onTap: () {
                  AttractionModals.showPreview(item);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0x80000000),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: const EdgeInsets.all(5.0),
                  child: Helpers.fetchIcons(
                    "arrow-up-right-and-arrow-down-left-from-center",
                    "regular",
                    size: 18.0,
                    color: "text.white",
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
