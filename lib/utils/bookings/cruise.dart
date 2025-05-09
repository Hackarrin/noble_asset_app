import 'dart:convert';

import 'package:afritas/main.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CruiseModals {
  static Future<Map<String, dynamic>> filters(Map<String, dynamic> filter,
      List recentSearches, List brands, int total) async {
    Map<String, dynamic> result = filter;
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();

    TextEditingController locationController = TextEditingController();

    startDateController.text = Helpers.formatDate(
        result["startDate"].toString(),
        formatString: "MMM dd");
    endDateController.text = Helpers.formatDate(result["endDate"].toString(),
        formatString: "MMM dd");
    startTimeController.text = result["startTime"].toString();
    endTimeController.text = result["endTime"].toString();
    locationController.text = result["location"].toString();

    final defaultDate = DateTime.now();
    final defaultEndDate = DateTime.now().add(Duration(days: 1));

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Palette.getColor(
            navigatorKey.currentContext!, "background", "default"),
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            final screenWidth = MediaQuery.sizeOf(context).width;
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Palette.getColor(context, "background", "paper"),
                    padding: const EdgeInsets.only(bottom: 15.0, top: 60.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xfff1f1f1), width: 1),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(left: 15.0),
                          child: IconButton(
                              onPressed: () {
                                result["location"] = "";
                                result["startDate"] =
                                    "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}";
                                result["duration"] = "1";
                                result["endDate"] =
                                    "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
                                result["adults"] = "1";
                                result["children"] = "0";
                                result["rooms"] = "1";
                                Navigator.pop(context);
                              },
                              icon: Helpers.fetchIcons(
                                "arrow-small-left",
                                "solid",
                                size: 24,
                                color: "text.other",
                              )),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: locationController,
                            decoration: Widgets.inputDecoration("",
                                isOutline: true,
                                color: Palette.getColor(
                                    context, "background", "textfield"),
                                borderColor: Palette.getColor(
                                    context, "background", "paper"),
                                hint: "Where are you going to?",
                                prefixIcon: UnconstrainedBox(
                                  child: Helpers.fetchIcons(
                                    "search",
                                    "regular",
                                    color: "main.primary",
                                    size: 20.0,
                                  ),
                                ),
                                hintColor:
                                    Palette.getColor(context, "text", "other"),
                                radius: 40.0,
                                isFilled: true,
                                isFloating: true),
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Palette.getColor(
                                    context, "text", "secondary"),
                                decoration: TextDecoration.none,
                                decorationThickness: 0),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () async {
                            final res =
                                await filterOther(filter, brands, total);
                            setState(() {
                              filter = res;
                              result = res;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "main", "primary"),
                                borderRadius: BorderRadius.circular(25.0)),
                            padding: EdgeInsets.all(15.0),
                            margin: EdgeInsets.only(right: 15.0),
                            child: Helpers.fetchIcons("bars-filter", "regular",
                                size: 15.0, color: "background.paper"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Booking date", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Widgets.buildText(
                                      "Check-in date & Time", context,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Palette.getColor(
                                            context, "background", "default"),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.all(1.0),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: TextFormField(
                                            readOnly: true,
                                            controller: startDateController,
                                            decoration: Widgets.inputDecoration(
                                                "",
                                                prefixIcon: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      "calendar-clock",
                                                      "regular",
                                                      size: 24,
                                                      color: "text.other"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res =
                                                  await Sheets.selectDate(
                                                      filter["startDate"]
                                                          .toString(),title: "Select start date");
                                              result["startDate"] = res;
                                              startDateController.text =
                                                  Helpers.formatDate(res,
                                                      formatString: "MMM dd");
                                              result["duration"] =
                                                  Helpers.dateDiff(
                                                res,
                                                result["endDate"].toString(),
                                              ).toString();
                                            },
                                            style: GoogleFonts.poppins(
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                          )),
                                          SizedBox(
                                            width: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: VerticalDivider(
                                                  thickness: 1.0,
                                                  color: Color(0x14000000)),
                                            ),
                                          ),
                                          Expanded(
                                              child: TextFormField(
                                            readOnly: true,
                                            controller: startTimeController,
                                            decoration: Widgets.inputDecoration(
                                                "",
                                                prefixIcon: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      "clock-three", "regular",
                                                      size: 24,
                                                      color: "text.other"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res =
                                                  await Sheets.selectTime(
                                                      filter["startTime"]
                                                          .toString());
                                              result["startTime"] = res;
                                              startTimeController.text = res;
                                            },
                                            style: GoogleFonts.poppins(
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Widgets.buildText(
                                      "Drop-Off date & Time", context,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Palette.getColor(
                                            context, "background", "default"),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.all(1.0),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: TextFormField(
                                            readOnly: true,
                                            controller: endDateController,
                                            decoration: Widgets.inputDecoration(
                                                "",
                                                prefixIcon: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      "calendar-clock",
                                                      "regular",
                                                      size: 24,
                                                      color: "text.other"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res =
                                                  await Sheets.selectDate(
                                                      filter["startDate"]
                                                          .toString(),title: "Select end date");
                                              result["endDate"] = res;
                                              endDateController.text =
                                                  Helpers.formatDate(res,
                                                      formatString: "MMM dd");
                                            },
                                            style: GoogleFonts.poppins(
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                          )),
                                          SizedBox(
                                            width: 5.0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: VerticalDivider(
                                                  thickness: 1.0,
                                                  color: Color(0x14000000)),
                                            ),
                                          ),
                                          Expanded(
                                              child: TextFormField(
                                            readOnly: true,
                                            controller: endTimeController,
                                            decoration: Widgets.inputDecoration(
                                                "",
                                                prefixIcon: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      "clock-three", "regular",
                                                      size: 24,
                                                      color: "text.other"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res =
                                                  await Sheets.selectTime(
                                                      filter["endTime"]
                                                          .toString());
                                              result["endTime"] = res;
                                              endTimeController.text = res;
                                            },
                                            style: GoogleFonts.poppins(
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                          ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Widgets.buildText("Continue your search", context,
                                isMedium: true),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ConstrainedBox(
                                constraints: BoxConstraints.loose(
                                    Size(screenWidth, 100.0)),
                                child: Swiper(
                                  outer: true,
                                  layout: SwiperLayout.CUSTOM,
                                  customLayoutOption: Widgets.customLayout(
                                      recentSearches.length, screenWidth,
                                      offset: 80.0),
                                  itemHeight: 100.0,
                                  itemWidth: screenWidth,
                                  loop: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = recentSearches[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 70.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/automobile-filter",
                                              arguments: jsonEncode({
                                                "location":
                                                    item["location"].toString()
                                              }));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                  vertical: 10.0),
                                              decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "paper"),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: Image.asset(
                                                      item["image"],
                                                      width: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Widgets.buildText(
                                                          item["location"]
                                                              .toString(),
                                                          context,
                                                          weight: 400,
                                                          size: 16.0),
                                                      Widgets.buildText(
                                                          "${Helpers.formatNumber(item["date"].toString())}, ${item["duration"]} days",
                                                          context,
                                                          color:
                                                              "text.secondary")
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: recentSearches.length,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: Widgets.buildButton(context,
                                  background: Palette.getColor(
                                      context, "main", "primary"),
                                  vertical: 15.0,
                                  radius: 45.0),
                              child: Widgets.buildText("Search", context,
                                  isMedium: true, color: "text.white")),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                result["location"] = "";
                                result["startDate"] =
                                    "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}";
                                ;
                                result["duration"] = "1";
                                result["endDate"] =
                                    "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
                                result["adults"] = "1";
                                result["children"] = "0";
                                result["rooms"] = "1";
                              });
                              startDateController.text = Helpers.formatDate(
                                  result["startDate"].toString(),
                                  formatString: "MMM dd");
                              endDateController.text = Helpers.formatDate(
                                  result["endDate"].toString(),
                                  formatString: "MMM dd");
                              locationController.text =
                                  result["location"].toString();
                            },
                            style:
                                Widgets.buildButton(context, horizontal: 25.0),
                            child: Widgets.buildText("Clear", context,
                                color: "main.primary", isMedium: true)),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
    return result;
  }

  static Future<Map<String, dynamic>> filterOther(
      Map<String, dynamic> filter, List vendors, int total) async {
    Map<String, dynamic> result = filter;
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    startDateController.text = Helpers.formatDate(
        result["startDate"].toString(),
        formatString: "MMM dd");
    endDateController.text = Helpers.formatDate(result["endDate"].toString(),
        formatString: "MMM dd");
    locationController.text = result["location"].toString();

    final defaultDate = DateTime.now();
    final defaultEndDate = DateTime.now().add(Duration(days: 1));

    var seeMoreCategories = false;
    var seeMoreFacilities = false;
    var seeMoreVendors = false;
    bool seeMoreBrands = false;
    bool seeMoreSpecs = false;
    var seeMoreVendor = false;
    List selectedCategories = (filter["categories"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedBrands = (filter["brands"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedRatings = filter["property_rating"] ?? [];
    List selectedSpecs = (filter["facilities"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedVendors = (filter["vendors"] ?? []);
    List selectedTransmissions = (filter["transmissions"] ?? []);

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Palette.getColor(
            navigatorKey.currentContext!, "background", "default"),
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Palette.getColor(context, "background", "paper"),
                    padding: const EdgeInsets.only(bottom: 15.0, top: 60.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xfff1f1f1), width: 1),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(left: 15.0),
                          child: IconButton(
                              onPressed: () {
                                result["location"] = "";
                                result["startDate"] =
                                    "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}";
                                ;
                                result["duration"] = "1";
                                result["endDate"] =
                                    "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
                                result["adults"] = "1";
                                result["children"] = "0";
                                result["rooms"] = "1";
                                Navigator.pop(context);
                              },
                              icon: Helpers.fetchIcons(
                                "arrow-small-left",
                                "solid",
                                size: 24,
                                color: "text.other",
                              )),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Widgets.buildText("Filters", context,
                              isMedium: true, isCenter: true),
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () async {
                            final sort =
                                await Sheets.showSortBy(result["sortBy"] ?? "");
                            setState(() => result["sortBy"] = sort);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Color(0xfff1f1f1)),
                                borderRadius: BorderRadius.circular(25.0)),
                            padding: EdgeInsets.all(15.0),
                            margin: EdgeInsets.only(right: 15.0),
                            child: Helpers.fetchIcons(
                                "sort-amount-down", "regular",
                                size: 15.0, color: "text.secondary"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Boat types", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var category in (seeMoreCategories
                                            ? Defaults.boatTypes
                                            : Defaults.boatTypes
                                                .getRange(0, 4)
                                                .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedCategories.contains(
                                                    category["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedCategories.remove(
                                                        category["value"]);
                                                    filter["categories"] = Defaults
                                                        .boatTypes
                                                        .where((category) =>
                                                            selectedCategories
                                                                .contains(
                                                                    category[
                                                                        "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedCategories
                                                        .add(category["value"]);
                                                    filter["categories"] = Defaults
                                                        .boatTypes
                                                        .where((category) =>
                                                            selectedCategories
                                                                .contains(
                                                                    category[
                                                                        "value"]))
                                                        .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedCategories.contains(
                                                            category["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context, "background", "paper"),
                                                    border: Border.all(
                                                        color: selectedCategories.contains(category["value"])
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  children: [
                                                    Helpers.fetchIcons(
                                                        category["icon"]
                                                            .toString(),
                                                        "regular",
                                                        size: 16.0),
                                                    const SizedBox(width: 5.0),
                                                    Widgets.buildText(
                                                        category["label"]
                                                            .toString(),
                                                        context,
                                                        color: selectedCategories
                                                                .contains(
                                                                    category[
                                                                        "value"])
                                                            ? "text.black"
                                                            : "text.secondary"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  UnconstrainedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() => seeMoreCategories =
                                            !seeMoreCategories);
                                      },
                                      child: Row(
                                        children: [
                                          Widgets.buildText(
                                              seeMoreCategories
                                                  ? "See less"
                                                  : "See more",
                                              context,
                                              color: "main.primary",
                                              weight: 500),
                                          const SizedBox(width: 5.0),
                                          Helpers.fetchIcons(
                                              seeMoreCategories
                                                  ? "caret-up"
                                                  : "caret-down",
                                              "solid",
                                              color: "main.primary",
                                              size: 24)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      "Categories by Type", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var category in (seeMoreBrands
                                            ? Defaults.boatCategories
                                            : Defaults.boatCategories
                                                .getRange(0, 4)
                                                .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedBrands.contains(
                                                    category["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedBrands.remove(
                                                        category["value"]);
                                                    filter["brands"] = Defaults
                                                        .boatCategories
                                                        .where((category) =>
                                                            selectedBrands
                                                                .contains(
                                                                    category[
                                                                        "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedBrands
                                                        .add(category["value"]);
                                                    filter["categories"] =
                                                        Defaults.boatCategories
                                                            .where((brand) =>
                                                                selectedBrands
                                                                    .contains(
                                                                        brand))
                                                            .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedBrands.contains(
                                                            category["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context, "background", "paper"),
                                                    border: Border.all(
                                                        color: selectedBrands.contains(category["value"])
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  spacing: 5.0,
                                                  children: [
                                                    Widgets.buildText(
                                                        category["label"]
                                                            .toString(),
                                                        context,
                                                        color: selectedBrands
                                                                .contains(
                                                                    category[
                                                                        "value"])
                                                            ? "text.black"
                                                            : "text.secondary"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  UnconstrainedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() =>
                                            seeMoreBrands = !seeMoreBrands);
                                      },
                                      child: Row(
                                        children: [
                                          Widgets.buildText(
                                              seeMoreBrands
                                                  ? "See less"
                                                  : "See more",
                                              context,
                                              color: "main.primary",
                                              weight: 500),
                                          const SizedBox(width: 5.0),
                                          Helpers.fetchIcons(
                                              seeMoreBrands
                                                  ? "caret-up"
                                                  : "caret-down",
                                              "solid",
                                              color: "main.primary",
                                              size: 24)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Price range", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        trackHeight: 20.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 17),
                                        padding: EdgeInsets.all(0.0)),
                                    child: Slider(
                                        inactiveColor: Palette.getColor(
                                            context, "background", "textfield"),
                                        min: num.tryParse(filter["minPrice"]
                                                    .toString())
                                                ?.toDouble() ??
                                            0.0,
                                        max: num.tryParse(filter["maxPrice"]
                                                    .toString())
                                                ?.toDouble() ??
                                            0.0,
                                        value: num.tryParse(
                                                    filter["price"].toString())
                                                ?.toDouble() ??
                                            0.0,
                                        onChanged: (value) {
                                          setState(() => filter["price"] =
                                              value.toString());
                                        }),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    6.0), //Same as `blurRadius` i guess
                                            decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Palette.getColor(
                                                            context,
                                                            "main",
                                                            "primary")))),
                                            child: Widgets.buildText(
                                                Helpers.formatCurrency(
                                                    filter["minPrice"]
                                                        .toString()),
                                                context,
                                                isMedium: true,
                                                color: "text.secondary"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    6.0), //Same as `blurRadius` i guess
                                            decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Palette.getColor(
                                                            context,
                                                            "main",
                                                            "primary")))),
                                            child: Widgets.buildText(
                                                Helpers.formatCurrency(
                                                    filter["maxPrice"]
                                                        .toString()),
                                                context,
                                                isMedium: true,
                                                color: "text.secondary"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Ideal For", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var category in (seeMoreSpecs
                                            ? Defaults.boatUsages
                                            : Defaults.boatUsages
                                                .getRange(0, 6)
                                                .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedSpecs
                                                    .contains(category)) {
                                                  // remove
                                                  setState(() {
                                                    selectedSpecs
                                                        .remove(category);
                                                    filter["facilities"] =
                                                        Defaults.boatUsages
                                                            .where((category) =>
                                                                selectedSpecs
                                                                    .contains(
                                                                        category))
                                                            .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedSpecs.add(category);
                                                    filter["categories"] =
                                                        Defaults.boatUsages
                                                            .where((brand) =>
                                                                selectedSpecs
                                                                    .contains(
                                                                        brand))
                                                            .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedSpecs.contains(category)
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedSpecs.contains(category)
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  spacing: 5.0,
                                                  children: [
                                                    Widgets.buildText(
                                                        category.toString(),
                                                        context,
                                                        color: selectedSpecs
                                                                .contains(
                                                                    category)
                                                            ? "text.black"
                                                            : "text.secondary"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  UnconstrainedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(
                                            () => seeMoreSpecs = !seeMoreSpecs);
                                      },
                                      child: Row(
                                        children: [
                                          Widgets.buildText(
                                              seeMoreSpecs
                                                  ? "See less"
                                                  : "See more",
                                              context,
                                              color: "main.primary",
                                              weight: 500),
                                          const SizedBox(width: 5.0),
                                          Helpers.fetchIcons(
                                              seeMoreSpecs
                                                  ? "caret-up"
                                                  : "caret-down",
                                              "solid",
                                              color: "main.primary",
                                              size: 24)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Equipment", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var category in (seeMoreSpecs
                                            ? Defaults.boatEquiments
                                            : Defaults.boatEquiments
                                                .getRange(0, 6)
                                                .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedTransmissions
                                                    .contains(category)) {
                                                  // remove
                                                  setState(() {
                                                    selectedTransmissions
                                                        .remove(category);
                                                    filter["transmissions"] = Defaults
                                                        .boatEquiments
                                                        .where((category) =>
                                                            selectedTransmissions
                                                                .contains(
                                                                    category))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedTransmissions
                                                        .add(category);
                                                    filter["transmissions"] =
                                                        Defaults.boatEquiments
                                                            .where((brand) =>
                                                                selectedTransmissions
                                                                    .contains(
                                                                        brand))
                                                            .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedTransmissions
                                                            .contains(category)
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context, "background", "paper"),
                                                    border: Border.all(
                                                        color: selectedTransmissions.contains(category)
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  spacing: 5.0,
                                                  children: [
                                                    Widgets.buildText(
                                                        category.toString(),
                                                        context,
                                                        color: selectedTransmissions
                                                                .contains(
                                                                    category)
                                                            ? "text.black"
                                                            : "text.secondary"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  UnconstrainedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(
                                            () => seeMoreSpecs = !seeMoreSpecs);
                                      },
                                      child: Row(
                                        children: [
                                          Widgets.buildText(
                                              seeMoreSpecs
                                                  ? "See less"
                                                  : "See more",
                                              context,
                                              color: "main.primary",
                                              weight: 500),
                                          const SizedBox(width: 5.0),
                                          Helpers.fetchIcons(
                                              seeMoreSpecs
                                                  ? "caret-up"
                                                  : "caret-down",
                                              "solid",
                                              color: "main.primary",
                                              size: 24)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          "Number of people", context,
                                          color: "text.secondary"),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    6.0), //Same as `blurRadius` i guess
                                            decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Palette.getColor(
                                                            context,
                                                            "main",
                                                            "primary")))),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var item = num.tryParse(
                                                                  result["occupants"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      item = item - 1 < 0
                                                          ? 0
                                                          : item - 1;
                                                      setState(() {
                                                        result["occupants"] =
                                                            item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "minus-circle", "solid",
                                                        size: 30)),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Widgets.buildText(
                                                    result["occupants"]
                                                        .toString(),
                                                    context,
                                                    isMedium: true,
                                                    color: "text.secondary"),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      final item = (num.tryParse(
                                                                      result["occupants"]
                                                                          .toString())
                                                                  ?.toInt() ??
                                                              0) +
                                                          1;
                                                      setState(() {
                                                        result["occupants"] =
                                                            item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "add", "solid",
                                                        size: 30,
                                                        color: "main.primary")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          "Number of cabinets", context,
                                          color: "text.secondary"),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    6.0), //Same as `blurRadius` i guess
                                            decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Palette.getColor(
                                                            context,
                                                            "main",
                                                            "primary")))),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var item = num.tryParse(
                                                                  result["cabinets"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      item = item - 1 < 0
                                                          ? 0
                                                          : item - 1;
                                                      setState(() {
                                                        result["cabinets"] =
                                                            item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "minus-circle", "solid",
                                                        size: 30)),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Widgets.buildText(
                                                    result["cabinets"]
                                                        .toString(),
                                                    context,
                                                    isMedium: true,
                                                    color: "text.secondary"),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      final item = (num.tryParse(
                                                                      result["cabinets"]
                                                                          .toString())
                                                                  ?.toInt() ??
                                                              0) +
                                                          1;
                                                      setState(() {
                                                        result["cabinets"] =
                                                            item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "add", "solid",
                                                        size: 30,
                                                        color: "main.primary")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          "Number of berths", context,
                                          color: "text.secondary"),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    6.0), //Same as `blurRadius` i guess
                                            decoration: BoxDecoration(
                                                color: Palette.getColor(context,
                                                    "background", "default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Palette.getColor(
                                                            context,
                                                            "main",
                                                            "primary")))),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var item = num.tryParse(
                                                                  result["berths"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      item = item - 1 < 0
                                                          ? 0
                                                          : item - 1;
                                                      setState(() {
                                                        result["berths"] = item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "minus-circle", "solid",
                                                        size: 30)),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Widgets.buildText(
                                                    result["berths"].toString(),
                                                    context,
                                                    isMedium: true,
                                                    color: "text.secondary"),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      final item = (num.tryParse(
                                                                      result["berths"]
                                                                          .toString())
                                                                  ?.toInt() ??
                                                              0) +
                                                          1;
                                                      setState(() {
                                                        result["berths"] = item;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "add", "solid",
                                                        size: 30,
                                                        color: "main.primary")),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Property rating", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var i = 5; i > 0; i -= 1)
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedRatings
                                                    .contains(i.toString())) {
                                                  // remove
                                                  setState(() {
                                                    selectedRatings
                                                        .remove(i.toString());
                                                    filter["property_rating"] =
                                                        selectedRatings;
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedRatings
                                                        .add(i.toString());
                                                    filter["property_rating"] =
                                                        selectedRatings;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedRatings.contains(i.toString())
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedRatings.contains(i.toString())
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Row(
                                                  children: [
                                                    for (var star = 0;
                                                        star < i;
                                                        star += 1)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    3.0),
                                                        child:
                                                            Helpers.fetchIcons(
                                                          "star",
                                                          "regular",
                                                          size: 18,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  UnconstrainedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() => seeMoreFacilities =
                                            !seeMoreFacilities);
                                      },
                                      child: Row(
                                        children: [
                                          Widgets.buildText(
                                              seeMoreFacilities
                                                  ? "See less"
                                                  : "See more",
                                              context,
                                              color: "main.primary",
                                              weight: 500),
                                          const SizedBox(width: 5.0),
                                          Helpers.fetchIcons(
                                              seeMoreFacilities
                                                  ? "caret-up"
                                                  : "caret-down",
                                              "solid",
                                              color: "main.primary",
                                              size: 24)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Suppliers", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        for (var item in (seeMoreVendors ||
                                                vendors.length <= 10
                                            ? vendors
                                            : vendors.getRange(0, 10).toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedVendors
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedVendors
                                                        .remove(item["value"]);
                                                    filter["vendors"] = vendors
                                                        .where((item) =>
                                                            selectedVendors
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedVendors
                                                        .add(item["value"]);
                                                    filter["vendors"] = vendors
                                                        .where((item) =>
                                                            selectedVendors
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedVendors.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedVendors.contains(item["value"])
                                                            ? Palette.getColor(
                                                                context, "text", "black")
                                                            : Palette.getColor(
                                                                context,
                                                                "background",
                                                                "textfield")),
                                                    borderRadius: BorderRadius.circular(25.0)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 15.0),
                                                child: Widgets.buildText(
                                                    item["name"].toString(),
                                                    context,
                                                    color:
                                                        selectedBrands.contains(
                                                                item["value"])
                                                            ? "text.black"
                                                            : "text.secondary"),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  if (vendors.length > 10)
                                    UnconstrainedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() =>
                                              seeMoreVendor = !seeMoreVendor);
                                        },
                                        child: Row(
                                          children: [
                                            Widgets.buildText(
                                                seeMoreVendor
                                                    ? "See less"
                                                    : "See more",
                                                context,
                                                color: "main.primary",
                                                weight: 500),
                                            const SizedBox(width: 5.0),
                                            Helpers.fetchIcons(
                                                seeMoreVendor
                                                    ? "caret-up"
                                                    : "caret-down",
                                                "solid",
                                                color: "main.primary",
                                                size: 24)
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: Widgets.buildButton(context,
                                  background: Palette.getColor(
                                      context, "main", "primary"),
                                  vertical: 15.0,
                                  radius: 45.0),
                              child: Widgets.buildText(
                                  "Search all ${Helpers.formatNumber(total.toString())} results",
                                  context,
                                  isMedium: true,
                                  color: "text.white")),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                result["categories"] = [];
                                result["price"] = result["minPrice"].toString();
                                result["facilities"] = [];
                                result["property_rating"] = [];
                                result["neighbourhood"] = [];
                                result["cabinets"] = 0;
                                result["occupants"] = 0;
                                result["berths"] = 0;
                                result["brands"] = [];
                                result["policy"] = [];

                                seeMoreCategories = false;
                                seeMoreFacilities = false;
                                selectedCategories = [];
                                selectedBrands = [];
                                selectedRatings = [];
                              });
                            },
                            style:
                                Widgets.buildButton(context, horizontal: 25.0),
                            child: Widgets.buildText("Clear", context,
                                color: "main.primary", isMedium: true)),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
    return result;
  }

  static Future<Map<String, dynamic>> filter(
      Map<String, dynamic> filter, Map<String, dynamic> data) async {
    Map<String, dynamic> result = filter;
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

    startDateController.text = Helpers.formatDate(result["checkin"].toString(),
        formatString: "MMM dd");
    endDateController.text = Helpers.formatDate(result["checkout"].toString(),
        formatString: "MMM dd");

    final defaultDate = DateTime.now();
    final defaultEndDate = DateTime.now().add(Duration(days: 1));

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Palette.getColor(
            navigatorKey.currentContext!, "background", "paper"),
        isScrollControlled: false,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.neutral"),
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                child: Widgets.buildText("10% Off", context,
                                    color: "main.primary")),
                            Row(
                              children: [
                                Helpers.fetchIcons("star", "solid",
                                    color: "warning.main"),
                                const SizedBox(width: 5.0),
                                Widgets.buildText(
                                    "${data["rating"]} (${Helpers.formatNumber(data["totalReviews"].toString())})",
                                    context,
                                    color: "text.secondary",
                                    weight: 500)
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      data["title"].toString(), context,
                                      isBold: true, color: "text.secondary"),
                                  Widgets.buildText(
                                      data["landmarks"].join(", ").toString(),
                                      context,
                                      color: "text.other",
                                      lines: 1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(30.0)),
                                padding: const EdgeInsets.all(10.0),
                                child: Helpers.fetchIcons(
                                    "land-layer-location", "solid",
                                    color: "text.white", size: 18.0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Divider(color: Color(0x14000000)),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Widgets.buildText("BOOK HOTEL", context, weight: 500),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Widgets.buildText("Check-in date", context,
                                color: "text.secondary", isMedium: true),
                            Widgets.buildText("Check-out date", context,
                                color: "text.secondary", isMedium: true),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Palette.getColor(
                                  context, "background", "paper"),
                              border: Border.all(color: Color(0x1A000000)),
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: const EdgeInsets.all(1.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  readOnly: true,
                                  controller: startDateController,
                                  decoration: Widgets.inputDecoration("",
                                      prefixIcon: UnconstrainedBox(
                                        child: Helpers.fetchIcons(
                                            "calendar-clock", "regular",
                                            size: 24, color: "text.primary"),
                                      ),
                                      isOutline: true,
                                      borderColor: Colors.transparent,
                                      isFloating: true,
                                      color: Palette.getColor(
                                          context, "text", "primary")),
                                  onTap: () async {
                                    final res = await Sheets.selectDate(
                                        filter["checkin"].toString());
                                    result["checkin"] = res;
                                    startDateController.text =
                                        Helpers.formatDate(res,
                                            formatString: "MMM dd");
                                  },
                                  style: GoogleFonts.poppins(
                                      color: Palette.getColor(
                                          context, "text", "primary")),
                                )),
                                SizedBox(
                                  width: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 5.0),
                                    child: VerticalDivider(
                                        thickness: 1.0,
                                        color: Color(0x14000000)),
                                  ),
                                ),
                                Expanded(
                                    child: TextFormField(
                                  readOnly: true,
                                  controller: endDateController,
                                  decoration: Widgets.inputDecoration("",
                                      prefixIcon: UnconstrainedBox(
                                        child: Helpers.fetchIcons(
                                            "calendar-clock", "regular",
                                            size: 24, color: "text.primary"),
                                      ),
                                      isOutline: true,
                                      borderColor: Colors.transparent,
                                      isFloating: true,
                                      color: Palette.getColor(
                                          context, "text", "primary")),
                                  onTap: () async {
                                    final res = await Sheets.selectDate(
                                        filter["checkout"].toString());
                                    result["checkout"] = res;
                                    endDateController.text = Helpers.formatDate(
                                        res,
                                        formatString: "MMM dd");
                                  },
                                  style: GoogleFonts.poppins(
                                      color: Palette.getColor(
                                          context, "text", "primary")),
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("SELECT GUEST", context,
                            weight: 500, color: "text.secondary"),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Adult", context,
                                    weight: 500),
                                Widgets.buildText("Age 18 or Above", context,
                                    color: "text.secondary"),
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
                                      bottom:
                                          6.0), //Same as `blurRadius` i guess
                                  decoration: BoxDecoration(
                                      color: Palette.getColor(
                                          context, "background", "default"),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Palette.getColor(context,
                                                  "main", "primary")))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            var guest = num.tryParse(
                                                        result["adults"]
                                                            .toString())
                                                    ?.toInt() ??
                                                0;
                                            guest =
                                                guest - 1 < 0 ? 0 : guest - 1;
                                            setState(() {
                                              result["adults"] =
                                                  guest.toString();
                                            });
                                          },
                                          child: Helpers.fetchIcons(
                                              "minus-circle", "solid",
                                              size: 30)),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Widgets.buildText(
                                          result["adults"].toString(), context,
                                          isMedium: true,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            final guest = (num.tryParse(
                                                            result["adults"]
                                                                .toString())
                                                        ?.toInt() ??
                                                    0) +
                                                1;
                                            setState(() {
                                              result["adults"] =
                                                  guest.toString();
                                            });
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
                        Divider(
                          color: Color(0x1a000000),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Children", context,
                                    weight: 500),
                                Widgets.buildText("Age 2 to 17", context,
                                    color: "text.secondary"),
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
                                      bottom:
                                          6.0), //Same as `blurRadius` i guess
                                  decoration: BoxDecoration(
                                      color: Palette.getColor(
                                          context, "background", "default"),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Palette.getColor(context,
                                                  "main", "primary")))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            var guest = num.tryParse(
                                                        result["children"]
                                                            .toString())
                                                    ?.toInt() ??
                                                0;
                                            guest =
                                                guest - 1 < 0 ? 0 : guest - 1;
                                            setState(() {
                                              result["children"] =
                                                  guest.toString();
                                            });
                                          },
                                          child: Helpers.fetchIcons(
                                              "minus-circle", "solid",
                                              size: 30)),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Widgets.buildText(
                                          result["children"].toString(),
                                          context,
                                          isMedium: true,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            final guest = (num.tryParse(
                                                            result["children"]
                                                                .toString())
                                                        ?.toInt() ??
                                                    0) +
                                                1;
                                            setState(() {
                                              result["children"] =
                                                  guest.toString();
                                            });
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
                        Divider(
                          color: Color(0x1a000000),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Rooms", context,
                                    weight: 500),
                                Widgets.buildText("Select rooms", context,
                                    color: "text.secondary"),
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
                                      bottom:
                                          6.0), //Same as `blurRadius` i guess
                                  decoration: BoxDecoration(
                                      color: Palette.getColor(
                                          context, "background", "default"),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Palette.getColor(context,
                                                  "main", "primary")))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            var rooms = num.tryParse(
                                                        result["rooms"]
                                                            .toString())
                                                    ?.toInt() ??
                                                0;
                                            rooms =
                                                rooms - 1 < 0 ? 0 : rooms - 1;
                                            setState(() {
                                              result["rooms"] =
                                                  rooms.toString();
                                            });
                                          },
                                          child: Helpers.fetchIcons(
                                              "minus-circle", "solid",
                                              size: 30)),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Widgets.buildText(
                                          result["rooms"].toString(), context,
                                          isMedium: true,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            final rooms = (num.tryParse(
                                                            result["rooms"]
                                                                .toString())
                                                        ?.toInt() ??
                                                    0) +
                                                1;
                                            setState(() {
                                              result["rooms"] =
                                                  rooms.toString();
                                            });
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
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: Widgets.buildButton(context,
                              background:
                                  Palette.getColor(context, "main", "primary"),
                              vertical: 15.0,
                              radius: 45.0),
                          child: Widgets.buildText("Search", context,
                              isMedium: true, color: "text.white")),
                    )
                  ],
                ),
              ),
            );
          });
        });
    return result;
  }

  static void showRules(List items, String title) async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Palette.getColor(context, "background", "default"),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:
                              Palette.getColor(context, "background", "paper"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      padding: EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                          top: kToolbarHeight,
                          bottom: 90.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: Widgets.buildButton(context,
                                        sideColor: Palette.get("text.disabled"),
                                        radius: 60.0),
                                    icon: Helpers.fetchIcons(
                                      "arrow-small-left",
                                      "regular",
                                      color: "text.disabled",
                                      size: 16.0,
                                    )),
                                Expanded(
                                  child: Widgets.buildText(
                                      "House rules", context,
                                      isMedium: true, isCenter: true),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 15.0),
                                color: Palette.get("background.default"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText(
                                        "Important Rules for Guests at Our Hotel",
                                        context,
                                        isMedium: true),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Widgets.buildText(
                                        "Welcome to $title \nTo ensure everyone has a pleasant and safe experience, we kindly ask all our guests to follow these important rules:",
                                        context,
                                        lines: 10),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final item = items[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      "background.paper"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                      color:
                                                          Color(0x0d000000))),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Helpers.fetchIcons(
                                                          item["icon"]
                                                              .toString(),
                                                          "regular",
                                                          size: 16.0),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Widgets.buildText(
                                                          item["title"]
                                                              .toString(),
                                                          context,
                                                          isMedium: true,
                                                          color:
                                                              "text.secondary"),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  if (item["title"]
                                                          .toString() !=
                                                      "Accepted payment methods")
                                                    Widgets.buildText(
                                                        "• ${item["description"].toString().split("\n").join("\n\n• ")}",
                                                        context,
                                                        lines: 100),
                                                  if (item["title"]
                                                          .toString() ==
                                                      "Accepted payment methods")
                                                    Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      children: [
                                                        for (final item in [
                                                          "visa",
                                                          "paypal",
                                                          "amex",
                                                          "discover",
                                                          "mastercard",
                                                          "maestro",
                                                          "stripe"
                                                        ])
                                                          SvgPicture.asset(
                                                              "assets/images/$item.svg",
                                                              height: 40.0,
                                                              fit: BoxFit
                                                                  .contain)
                                                      ],
                                                    )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: items.length),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10.0),
                        color: Palette.get("background.paper"),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: Widgets.buildButton(context,
                                background: Palette.getColor(
                                    context, "main", "primary"),
                                vertical: 15.0,
                                horizontal: 40.0,
                                radius: 45.0),
                            child: Widgets.buildText("Message Host", context,
                                isMedium: true, color: "text.white")),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  static Future<Map<String, dynamic>> selectQuantity(
      Map<String, dynamic> cruise,
      Map<String, dynamic> selection,
      double fee) async {
    bool isProceed = false;
    final defaultPrice =
        num.tryParse(cruise["price"].toString())?.toDouble() ?? 0;
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          double ticketWidth = (screenWidth / 2.0) - 40.0;
          ticketWidth = ticketWidth < 150.0 ? 150.0 : ticketWidth;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  height: 500.0,
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("Booking summary", context,
                            isMedium: true),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0x0D000000)),
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                spacing: 10.0,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.asset(
                                        (cruise["image"] ?? cruise["images"][0])
                                            .toString(),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover),
                                  ),
                                  Column(
                                    spacing: 10.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Palette.get("main.primary")),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        child: Widgets.buildText(
                                            "Yacht", context,
                                            isMedium: true,
                                            color: "main.primary",
                                            size: 13.0),
                                      ),
                                      Widgets.buildText(
                                          cruise["title"].toString(), context,
                                          isMedium: true),
                                      Row(
                                        spacing: 5.0,
                                        children: [
                                          Helpers.fetchIcons(
                                              "exclamation", "solid",
                                              color: "main.primary"),
                                          Widgets.buildText(
                                              "Non refundable", context,
                                              color: "text.secondary")
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 20.0,
                                    children: [
                                      Row(
                                        spacing: 10.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      "main.primary"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              spacing: 5.0,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  spacing: 5.0,
                                                  children: [
                                                    Widgets.buildText(
                                                        "From:", context,
                                                        color: "main.primary"),
                                                    Expanded(
                                                      child: Widgets.buildText(
                                                          cruise["location"]
                                                              .toString(),
                                                          context,
                                                          color: "text.black",
                                                          weight: 500),
                                                    ),
                                                  ],
                                                ),
                                                Widgets.buildText(
                                                    "${Helpers.formatDate(selection["checkInDate"].toString(), formatString: "dd MMM, yyyy")} · ${Helpers.formatDate("${selection["checkInDate"].toString()} ${selection["checkInTime"].toString()}", formatString: "hh:mm a")}",
                                                    context,
                                                    color: "text.secondary"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Opacity(
                                            opacity: 0.2,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      "main.primary"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Widgets.buildText(
                                              "${Helpers.hourDiff("${selection["checkInDate"].toString()} ${selection["checkInTime"].toString()}", "${selection["checkOutDate"].toString()} ${selection["checkOutTime"].toString()}")} hour${Helpers.hourDiff("${selection["checkInDate"].toString()} ${selection["checkInTime"].toString()}", "${selection["checkOutDate"].toString()} ${selection["checkOutTime"].toString()}") > 1 ? "s" : ""}",
                                              context,
                                              color: "text.secondary"),
                                        ],
                                      ),
                                      Row(
                                        spacing: 10.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      "main.primary"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              spacing: 5.0,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  spacing: 5.0,
                                                  children: [
                                                    Widgets.buildText(
                                                        "To:", context,
                                                        color: "main.primary"),
                                                    Expanded(
                                                      child: Widgets.buildText(
                                                          cruise["location"]
                                                              .toString(),
                                                          context,
                                                          color: "text.black",
                                                          weight: 500),
                                                    ),
                                                  ],
                                                ),
                                                Widgets.buildText(
                                                    "${Helpers.formatDate(selection["checkOutDate"].toString(), formatString: "dd MMM, yyyy")} · ${Helpers.formatDate("${selection["checkOutDate"].toString()} ${selection["checkOutTime"].toString()}", formatString: "hh:mm a")}",
                                                    context,
                                                    color: "text.secondary"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 5.0,
                                    top: 20.0,
                                    child: DottedBorder(
                                      dashPattern: [3, 5],
                                      color: Color(0x8041B11A),
                                      padding: EdgeInsets.zero,
                                      child: const SizedBox(
                                        width: 0,
                                        height: 40.0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 5.0,
                                    top: 83.0,
                                    child: DottedBorder(
                                      dashPattern: [3, 5],
                                      color: Color(0x8041B11A),
                                      padding: EdgeInsets.zero,
                                      child: const SizedBox(
                                        width: 0,
                                        height: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              String title = "";
                              String key = "";
                              if (index == 0) {
                                title = "Occupant";
                                key = "occupants";
                              } else {
                                title = "Quantity";
                                key = "quantity";
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 5.0,
                                  children: [
                                    Widgets.buildText(title, context,
                                        color: "text.secondary"),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15.0),
                                          margin: const EdgeInsets.only(
                                              bottom:
                                                  6.0), //Same as `blurRadius` i guess
                                          decoration: BoxDecoration(
                                              color: Palette.getColor(context,
                                                  "background", "default"),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Palette.getColor(
                                                          context,
                                                          "main",
                                                          "primary")))),
                                          child: Row(
                                            spacing: 10.0,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    var qty = num.tryParse(
                                                                selection[key]
                                                                    .toString())
                                                            ?.toInt() ??
                                                        0;
                                                    qty = qty - 1 < 0
                                                        ? 0
                                                        : qty - 1;
                                                    setState(() {
                                                      selection[key] = qty;
                                                    });
                                                  },
                                                  child: Helpers.fetchIcons(
                                                      "minus-circle", "solid",
                                                      size: 30)),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Widgets.buildText(
                                                  selection.isEmpty
                                                      ? "0"
                                                      : selection[key]
                                                          .toString(),
                                                  context,
                                                  isMedium: true,
                                                  color: "text.secondary"),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    int qty = (num.tryParse(
                                                                    selection[
                                                                            key]
                                                                        .toString())
                                                                ?.toInt() ??
                                                            0) +
                                                        1;
                                                    setState(() {
                                                      selection[key] = qty;
                                                    });
                                                  },
                                                  child: Helpers.fetchIcons(
                                                      "add", "solid",
                                                      size: 30,
                                                      color: "main.primary")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: 2),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0x0D000000))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 25.0),
                          child: Column(
                            spacing: 15.0,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Widgets.buildText("Amount", context,
                                            color: "text.disabled",
                                            size: 13.0,
                                            weight: 500),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: const DashedDivider(
                                                  color: Color(0x40000000))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.loose(
                                        Size(200.0, double.infinity)),
                                    child: Widgets.buildText(
                                        Helpers.formatCurrency((Helpers
                                                    .handleCalendarEntry(
                                                        [
                                                      selection[
                                                              "checkInDate"] ??
                                                          "",
                                                      selection[
                                                              "checkOutDate"] ??
                                                          ""
                                                    ],
                                                        cruise["calendar"] ??
                                                            [],
                                                        defaultPrice,
                                                        cruise["listingId"] ??
                                                            "") *
                                                Helpers.hourDiff(
                                                    "${selection["checkInDate"] ?? ""} ${selection["checkInTime"] ?? ""}",
                                                    "${selection["checkOutDate"] ?? ""} ${selection["checkOutTime"] ?? ""}") *
                                                (num.tryParse(selection[
                                                                "quantity"]
                                                            .toString())
                                                        ?.toInt() ??
                                                    0))
                                            .toString()),
                                        context,
                                        size: 13.0,
                                        weight: 500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Widgets.buildText("Tax & Fees", context,
                                            color: "text.disabled",
                                            size: 13.0,
                                            weight: 500),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: const DashedDivider(
                                                  color: Color(0x40000000))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.loose(
                                        Size(200.0, double.infinity)),
                                    child: Widgets.buildText(
                                        Helpers.formatCurrency(fee.toString()),
                                        context,
                                        size: 13.0,
                                        weight: 500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Widgets.buildText("Total", context,
                                            color: "text.disabled",
                                            size: 13.0,
                                            weight: 500),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: const DashedDivider(
                                                  color: Color(0x40000000))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.loose(
                                        Size(200.0, double.infinity)),
                                    child: Widgets.buildText(
                                        Helpers.formatCurrency(((Helpers
                                                        .handleCalendarEntry(
                                                            [
                                                          selection[
                                                                  "checkInDate"] ??
                                                              "",
                                                          selection[
                                                                  "checkOutDate"] ??
                                                              ""
                                                        ],
                                                            cruise["calendar"] ??
                                                                [],
                                                            defaultPrice,
                                                            cruise["listingId"] ??
                                                                "") *
                                                    Helpers.hourDiff(
                                                        "${selection["checkInDate"] ?? ""} ${selection["checkInTime"] ?? ""}",
                                                        "${selection["checkOutDate"] ?? ""} ${selection["checkOutTime"] ?? ""}") *
                                                    (num.tryParse(selection[
                                                                    "quantity"]
                                                                .toString())
                                                            ?.toInt() ??
                                                        0)) +
                                                fee)
                                            .toString()),
                                        context,
                                        size: 13.0,
                                        weight: 500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  isProceed = true;
                                  Navigator.pop(context);
                                },
                                style: Widgets.buildButton(context,
                                    background: Palette.get("main.primary"),
                                    radius: 90.0,
                                    vertical: 20.0,
                                    horizontal: 10.0),
                                child: Widgets.buildText("Continue", context,
                                    isMedium: true, color: "text.white"))),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          });
        });
    return isProceed ? selection : {};
  }
}
