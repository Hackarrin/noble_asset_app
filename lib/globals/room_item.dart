import 'dart:convert';

import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem(
      {super.key,
      required this.item,
      this.checkin,
      this.checkout,
      this.action,
      required this.index,
      required this.calendar,
      required this.numRooms,
      required this.numNights,
      required this.roomSelected,
      required this.handleCheckout,
      required this.setRoomSelected,
      required this.setNumRooms,
      this.isHotel = true});

  final Function? action;
  final Function setNumRooms;
  final int index;
  final String? checkin;
  final List calendar;
  final Map numRooms;
  final int numNights;
  final int roomSelected;
  final Function handleCheckout;
  final Function setRoomSelected;
  final String? checkout;
  final Map<String, dynamic> item;
  final bool isHotel;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/hotel", arguments: jsonEncode(item));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Palette.get("main.primary")),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Sheets.showImagePreview(
                                item["images"], item["name"].toString());
                          },
                          child: Widgets.buildText(
                              item["name"].toString(), context,
                              isUnderlined: true,
                              color: "main.primary",
                              weight: 500),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Wrap(
                          spacing: 5.0,
                          children: [
                            for (final attribute in item["attributes"])
                              Widgets.buildText(attribute, context,
                                  color: "text.secondary",
                                  weight: 500,
                                  lines: 2),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("users", "solid", size: 16.0),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Widgets.buildText(
                                "Price for ${item["occupants"]} adult${(num.tryParse(item["occupants"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                context,
                                color: "text.secondary",
                                size: 14.0)
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if ((num.tryParse(item["singleBed"].toString())
                                    ?.toInt() ??
                                0) >
                            0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("bed", "solid", size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    "${Helpers.formatNumber(item["singleBed"].toString())} single bed${(num.tryParse(item["singleBed"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                        if ((num.tryParse(item["doubleBed"].toString())
                                    ?.toInt() ??
                                0) >
                            0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("bed-alt", "solid",
                                    size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    "${Helpers.formatNumber(item["doubleBed"].toString())} double bed${(num.tryParse(item["doubleBed"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                        if ((num.tryParse(item["largeBed"].toString())
                                    ?.toInt() ??
                                0) >
                            0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("bed-alt", "solid",
                                    size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    "${Helpers.formatNumber(item["largeBed"].toString())} large bed${(num.tryParse(item["largeBed"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                        if ((num.tryParse(item["xLargeBed"].toString())
                                    ?.toInt() ??
                                0) >
                            0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("bed-alt", "solid",
                                    size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    "${Helpers.formatNumber(item["xLargeBed"].toString())} extra large bed${(num.tryParse(item["xLargeBed"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                        if ((num.tryParse(item["roomSize"].toString())
                                    ?.toInt() ??
                                0) >
                            0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("sofa-size", "solid",
                                    size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    "${Helpers.formatNumber(item["roomSize"].toString())} m",
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                        for (final amenity in item["amenities"])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons(
                                    (Defaults.hotelAmenities[amenity]
                                                ?["icon"] ??
                                            "")
                                        .toString(),
                                    "solid",
                                    size: 16.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Widgets.buildText(
                                    (Defaults.hotelAmenities[amenity]
                                                ?["name"] ??
                                            "")
                                        .toString(),
                                    context,
                                    color: "text.secondary",
                                    size: 14.0)
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  if (item["image"].toString().isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Sheets.showImagePreview(
                            item["images"], item["name"].toString());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(item["image"],
                            width: 100, height: 100, fit: BoxFit.cover),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Widgets.buildText(
                  item["other_amenities"].join(", "),
                  context,
                  lines: 2000,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (checkin != null && checkout != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (roomSelected != index)
                      Widgets.buildText(
                          "Total Price for ${Helpers.dateDiff(checkin!, checkout!)} ${isHotel ? "night" : "day"}${Helpers.dateDiff(checkin!, checkout!) > 1 ? "s" : ""}",
                          context,
                          color: "text.secondary"),
                    if (roomSelected != index) const SizedBox(height: 10.0),
                    if (roomSelected != index)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Widgets.buildText(
                                  Helpers.formatCurrency(
                                      item["price"].toString()),
                                  context,
                                  color: "main.primary",
                                  isMedium: true),
                              Widgets.buildText(
                                "/${isHotel ? "night" : "day"}",
                                context,
                              ),
                            ],
                          ),
                          const SizedBox(width: 20.0),
                          Widgets.buildText(
                              "Only ${Helpers.formatNumber(item["quantity"].toString())} left",
                              context,
                              color: "error.main",
                              weight: 500)
                        ],
                      ),
                    SizedBox(height: roomSelected != index ? 25.0 : 10.0),
                    if (roomSelected == index)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets.buildText(
                                  "${Helpers.formatNumber((numRooms[item["name"]] ?? "0").toString())} ${isHotel ? "room" : "apartment"}${(num.tryParse((numRooms[item["name"]] ?? "0").toString())?.toInt() ?? 0) > 1 ? "s" : ""} selected",
                                  context,
                                  size: 13.0),
                              const SizedBox(height: 2.0),
                              Row(
                                children: [
                                  Widgets.buildText(
                                      Helpers.formatCurrency((Helpers
                                                  .handleCalendarEntry(
                                                      [checkin, checkout],
                                                      calendar,
                                                      num.tryParse(item["price"]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0,
                                                      item["id"].toString()) *
                                              (num.tryParse((numRooms[item[
                                                                  "name"]] ??
                                                              1)
                                                          .toString())
                                                      ?.toInt() ??
                                                  1))
                                          .toString()),
                                      context,
                                      color: "main.primary",
                                      size: 16.0,
                                      weight: 500),
                                  Widgets.buildText(
                                      "/${isHotel ? "night" : "day"}", context,
                                      size: 16.0, weight: 500)
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                margin: const EdgeInsets.only(
                                    bottom: 6.0), //Same as `blurRadius` i guess
                                decoration: BoxDecoration(
                                    color: Palette.getColor(
                                        context, "background", "default"),
                                    borderRadius: BorderRadius.circular(100.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Palette.getColor(
                                                context, "main", "primary")))),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          int room = num.tryParse(
                                                      numRooms[item["name"]]
                                                          .toString())
                                                  ?.toInt() ??
                                              0;
                                          room = room - 1 < 1 ? 1 : room - 1;
                                          numRooms[item["name"]] = room;
                                          setNumRooms(numRooms);
                                        },
                                        child: Helpers.fetchIcons(
                                            "minus-circle", "solid",
                                            size: 30)),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Widgets.buildText(
                                        "${Helpers.formatNumber(numRooms[item["name"]].toString())} ${isHotel ? "room" : "apartment"}${(num.tryParse(numRooms[item["name"]].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                                        context,
                                        weight: 500,
                                        size: isHotel ? 16.0 : 12.0,
                                        color: "text.secondary"),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          int room = num.tryParse(
                                                      numRooms[item["name"]]
                                                          .toString())
                                                  ?.toInt() ??
                                              0;
                                          final qty = num.tryParse(
                                                      item["quantity"]
                                                          .toString())
                                                  ?.toInt() ??
                                              0;
                                          numRooms[item["name"]] =
                                              room + 1 > qty ? qty : room + 1;
                                          setNumRooms(numRooms);
                                        },
                                        child: Helpers.fetchIcons(
                                            "add", "solid",
                                            size: 30, color: "main.primary")),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    if (roomSelected == index) const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            if (roomSelected == index) {
                              handleCheckout();
                            } else {
                              final price =
                                  num.tryParse(item["price"].toString())
                                          ?.toDouble() ??
                                      0;
                              if (Helpers.handleCalendarEntry(
                                      [checkin, checkout],
                                      calendar,
                                      price,
                                      item["id"].toString()) >
                                  0) {
                                numRooms[item["name"]] =
                                    numRooms.containsKey(item["name"])
                                        ? numRooms[item["name"]]
                                        : 1;
                                setNumRooms(numRooms);
                                setRoomSelected(index);
                              } else {
                                // enqueueSnackbar(
                                //     "This room is not available for the date(s) selected! Please select a different date to proceed.",
                                //     {
                                //       variant: "warning",
                                //     });
                              }
                            }
                          },
                          style: Widgets.buildButton(context,
                              background: roomSelected != index
                                  ? Palette.get("main.primary").withAlpha(50)
                                  : Palette.get("main.primary"),
                              horizontal: 10.0,
                              radius: 50.0,
                              vertical: 15.0),
                          child: Widgets.buildText(
                              roomSelected == index
                                  ? "Next Step"
                                  : "Reserve this ${isHotel ? "room" : "apartment"}",
                              context,
                              isMedium: true,
                              color: roomSelected == index
                                  ? "text.white"
                                  : "main.primary")),
                    ),
                    const SizedBox(height: 15.0),
                  ],
                )
            ],
          ),
        ),
      ),
    ]);
  }
}
