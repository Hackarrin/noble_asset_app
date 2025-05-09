import 'dart:convert';

import 'package:cribsfinder/globals/attraction_item.dart';
import 'package:cribsfinder/globals/event_item.dart';
import 'package:cribsfinder/main.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttractionModals {
  static Future<Map<String, dynamic>> filters(Map<String, dynamic> filter,
      List recentSearches, List neighbourhoods, List brands, int total) async {
    Map<String, dynamic> result = filter;
    TextEditingController startDateController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController searchController = TextEditingController();

    searchController.text = result["search"].toString();
    startDateController.text = Helpers.formatDate(
        result["startDate"].toString(),
        formatString: "MMM dd");
    categoryController.text = result["categories"].isEmpty
        ? "All Attractions"
        : (result["categories"][0]["label"] ?? "").toString();
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
                                result["endDate"] =
                                    "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
                                result["search"] = "";
                                result["categories"] = [];
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
                                hint: "Search location",
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
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Palette.getColor(
                                    context, "text", "secondary"),
                                decoration: TextDecoration.none,
                                decorationThickness: 0),
                          ),
                        ),
                        const SizedBox(width: 10.0),
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
                                  Widgets.buildText(
                                      "Search Attraction", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText(
                                          "Attraction Name", context,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      TextFormField(
                                        controller: searchController,
                                        decoration: Widgets.inputDecoration("",
                                            prefixIcon: UnconstrainedBox(
                                              child: Helpers.fetchIcons(
                                                  "search", "regular",
                                                  size: 24,
                                                  color: "main.primary"),
                                            ),
                                            isOutline: true,
                                            isFilled: true,
                                            borderColor: Palette.getColor(
                                                context,
                                                "background",
                                                "default"),
                                            isFloating: true,
                                            color: Palette.getColor(context,
                                                "background", "default"),
                                            radius: 10.0),
                                        style: GoogleFonts.nunito(
                                            color: Palette.getColor(
                                                context, "text", "other")),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          "Attraction date", context,
                                          color: "text.secondary"),
                                      Widgets.buildText("Categories", context,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
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
                                                      color: "main.primary"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res = await selectDates(
                                                  filter["startDate"]
                                                      .toString(),
                                                  filter["endDate"].toString());
                                              result["startDate"] =
                                                  res["startDate"] ?? "";
                                              result["endDate"] =
                                                  res["endDate"] ?? "";
                                              startDateController.text =
                                                  Helpers.formatDate(
                                                      res["startDate"]
                                                          .toString(),
                                                      formatString:
                                                          "MMM dd, yyyy");
                                            },
                                            style: GoogleFonts.nunito(
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
                                            controller: categoryController,
                                            decoration: Widgets.inputDecoration(
                                                "",
                                                prefixIcon: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      "apps-add", "regular",
                                                      size: 24,
                                                      color: "main.primary"),
                                                ),
                                                isOutline: true,
                                                borderColor: Colors.transparent,
                                                isFloating: true,
                                                color: Palette.getColor(
                                                    context, "text", "other")),
                                            onTap: () async {
                                              final res =
                                                  await Sheets.showSortBy(
                                                      result["categories"]
                                                              .isEmpty
                                                          ? ""
                                                          : result["categories"]
                                                                      [0]
                                                                  ["value"] ??
                                                              "",
                                                      items: Defaults
                                                          .attractionCategories,
                                                      title: "Categories",
                                                      isShowClear: false);
                                              final categoryName = Defaults
                                                  .attractionCategories
                                                  .firstWhere((item) =>
                                                      item["value"]
                                                          .toString() ==
                                                      res)["name"]
                                                  .toString();
                                              result["categories"] = [
                                                {
                                                  "label": categoryName,
                                                  "value": res
                                                }
                                              ];
                                              categoryController.text =
                                                  categoryName;
                                            },
                                            style: GoogleFonts.nunito(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Widgets.buildText("Recently Viewed", context,
                                    isMedium: true),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/attractions-search",
                                          arguments:
                                              jsonEncode(recentSearches));
                                    },
                                    child: Widgets.buildText("See all", context,
                                        color: "main.primary"))
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final item = recentSearches[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: AttractionItem(
                                      item: item, direction: "horizontal"),
                                );
                              },
                              itemCount: recentSearches.length > 3
                                  ? 3
                                  : recentSearches.length,
                            ),
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
                                result["endDate"] =
                                    "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
                                result["search"] = "";
                                result["categories"] = [];
                              });
                              startDateController.text = Helpers.formatDate(
                                  result["startDate"].toString(),
                                  formatString: "MMM dd");
                              categoryController.text = "All Events";
                              locationController.text =
                                  result["location"].toString();
                              searchController.text = "";
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
      Map<String, dynamic> filter, int total) async {
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
    List selectedRatings = filter["property_rating"] ?? [];
    var seeMoreCategories = false;
    List selectedCategories = (filter["categories"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedTimes = (filter["times"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedPolicies = (filter["policy"] ?? []).toList();

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
                                result["infants"] = "1";
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
                                  Widgets.buildText("Categories", context,
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
                                            ? Defaults.attractionCategories
                                            : Defaults.attractionCategories
                                                .getRange(0, 10)
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
                                                        .attractionCategories
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
                                                        .attractionCategories
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
                                                    Widgets.buildText(
                                                        category["name"]
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
                                  Widgets.buildText("Reviews Scores", context,
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
                                  Widgets.buildText("Time of day", context,
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
                                        for (var item in Defaults.timeofDay)
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedTimes
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedTimes
                                                        .remove(item["value"]);
                                                    filter["times"] = Defaults
                                                        .timeofDay
                                                        .where((item) =>
                                                            selectedTimes
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedTimes
                                                        .add(item["value"]);
                                                    filter["times"] = Defaults
                                                        .eventTypes
                                                        .where((item) =>
                                                            selectedTimes
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedTimes.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedTimes.contains(item["value"])
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
                                                        horizontal: 10.0),
                                                child: Row(
                                                  children: [
                                                    Widgets.buildText(
                                                        item["name"].toString(),
                                                        context,
                                                        color: selectedTimes
                                                                .contains(item[
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
                                      "Cancellation Policy", context,
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
                                        for (var item
                                            in Defaults.reservationPolicies)
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedPolicies
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedPolicies
                                                        .remove(item["value"]);
                                                    filter["policy"] =
                                                        selectedPolicies;
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedPolicies
                                                        .add(item["value"]);
                                                    filter["policy"] =
                                                        selectedPolicies;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedPolicies.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedPolicies.contains(item["value"])
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
                                                    item["label"].toString(),
                                                    context,
                                                    color: selectedPolicies
                                                            .contains(
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
                                ],
                              ),
                            ),
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
                                result["types"] = [];
                                result["startDate"] = "";
                                result["endDate"] = "";

                                seeMoreCategories = false;
                                selectedCategories = [];
                                selectedTimes = [];
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
                        Widgets.buildText("BOOK SHORT-LET", context,
                            weight: 500),
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
                                        filter["checkin"].toString(),
                                        title: "Select start date");
                                    result["checkin"] = res;
                                    startDateController.text =
                                        Helpers.formatDate(res,
                                            formatString: "MMM dd");
                                  },
                                  style: GoogleFonts.nunito(
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
                                        filter["checkout"].toString(),
                                        title: "Select end date");
                                    result["checkout"] = res;
                                    endDateController.text = Helpers.formatDate(
                                        res,
                                        formatString: "MMM dd");
                                  },
                                  style: GoogleFonts.nunito(
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
                                Widgets.buildText("Infants", context,
                                    weight: 500),
                                Widgets.buildText("Age 0 - 2", context,
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
                                            var infants = num.tryParse(
                                                        result["infants"]
                                                            .toString())
                                                    ?.toInt() ??
                                                0;
                                            infants = infants - 1 < 0
                                                ? 0
                                                : infants - 1;
                                            setState(() {
                                              result["infants"] =
                                                  infants.toString();
                                            });
                                          },
                                          child: Helpers.fetchIcons(
                                              "minus-circle", "solid",
                                              size: 30)),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Widgets.buildText(
                                          result["infants"].toString(), context,
                                          isMedium: true,
                                          color: "text.secondary"),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            final infants = (num.tryParse(
                                                            result["infants"]
                                                                .toString())
                                                        ?.toInt() ??
                                                    0) +
                                                1;
                                            setState(() {
                                              result["infants"] =
                                                  infants.toString();
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

  static void showGenre(List items, List tags, String title) async {
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
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: kToolbarHeight, bottom: 90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                              child: Widgets.buildText("Genre", context,
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
                              spacing: 10.0,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = items[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      child: Image.asset(
                                                        item["photo"],
                                                        width: 50.0,
                                                        height: 50.0,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  const SizedBox(width: 10.0),
                                                  Widgets.buildText(
                                                      item["name"].toString(),
                                                      context,
                                                      isMedium: true,
                                                      color: "text.secondary"),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                              TextButton(
                                                  onPressed: () {},
                                                  style: Widgets.buildButton(
                                                      context,
                                                      radius: 20.0,
                                                      horizontal: 20.0,
                                                      background: Palette.get(
                                                          "main.primary")),
                                                  child: Widgets.buildText(
                                                      "Follow", context,
                                                      color: "text.white"))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: items.length),
                                Widgets.buildText("Tags", context,
                                    isMedium: true),
                                Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: [
                                    for (final tag in tags)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: tag.toString() == "music"
                                              ? Palette.get("main.primary")
                                              : Color(0xFFE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        child: Widgets.buildText(
                                            tag.toString().capitalize(),
                                            context,
                                            weight: 500,
                                            color: tag.toString() == "music"
                                                ? "text.white"
                                                : "text.primary"),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static Future<Map<String, dynamic>> showTickets(
      Map<String, dynamic> item, double fee) async {
    Map<String, dynamic> res = {"ticket": "", "date": "", "time": ""};
    bool isProceed = false;
    final List tickets = item["tickets"] ?? [];
    final today = DateTime.now();
    res["date"] = Helpers.formatDateObject(today.add(const Duration(days: 1)));
    final times = (item["openingTimes"] ?? []).isEmpty
        ? [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        : item["openingTimes"];
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        useSafeArea: true,
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              constraints: BoxConstraints.loose(Size(screenWidth, 600.0)),
              decoration: BoxDecoration(
                  color: Palette.getColor(context, "background", "paper"),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 60.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                            color: Color(0x66000000),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Widgets.buildText("Choose your tickets", context,
                        isMedium: true),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(color: Color(0x14000000)),
                    Row(
                      spacing: 5.0,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Widgets.buildText(
                            "Search ticket availability by date", context),
                        TextButton(
                            onPressed: () {},
                            child: Widgets.buildText("See more", context,
                                color: "main.primary"))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 122.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final date = today.add(Duration(days: index));
                            final formattedDate =
                                Helpers.formatDateObject(date);
                            final day = Helpers.formatDateObject(date,
                                formatString: "EEEE");
                            final isAvailable =
                                (item["weekdays"] ?? []).contains(day) ||
                                    (item["weekends"] ?? []).contains(day);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, bottom: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  try {
                                    if (isAvailable &&
                                        !date.isAtSameMomentAs(today)) {
                                      final price =
                                          num.tryParse(item["price"].toString())
                                                  ?.toDouble() ??
                                              0.0;
                                      final isOpen =
                                          Helpers.handleCalendarEntry(
                                              date,
                                              item["calendar"] ?? [],
                                              price,
                                              item["listingId"] ?? "");
                                      if (isOpen != 0) {
                                        setState(
                                            () => res["date"] = formattedDate);
                                      } else {
                                        Alert.show(context, "",
                                            "This attraction is unavailable for the date selected. Please change your selection to proceed.");
                                      }
                                    } else {
                                      Alert.show(context, "",
                                          "This attraction is unavailable for the date selected. Please change your selection to proceed.");
                                    }
                                  } catch (err) {
                                    print(err);
                                  }
                                },
                                child: Stack(
                                  children: [
                                    const SizedBox(
                                      height: 122,
                                    ),
                                    IntrinsicHeight(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    formattedDate == res["date"]
                                                        ? Palette.get(
                                                            "main.primary")
                                                        : Color(0x1A000000)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: index == 0
                                                ? Palette.get(
                                                    "background.neutral")
                                                : (formattedDate == res["date"]
                                                    ? Color(0xFFE7FFDE)
                                                    : Palette.get(
                                                        "background.paper"))),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 25.0),
                                        child: Column(
                                          spacing: 5.0,
                                          children: [
                                            Widgets.buildText(
                                                Helpers.formatDateObject(date,
                                                    formatString: "EEE"),
                                                context,
                                                color: index == 0
                                                    ? "text.disabled"
                                                    : (formattedDate ==
                                                            res["date"]
                                                        ? "main.primary"
                                                        : "text.primary"),
                                                size: 12.0),
                                            Widgets.buildText(
                                                Helpers.formatDateObject(date,
                                                    formatString: "dd"),
                                                context,
                                                color: index == 0
                                                    ? "text.disabled"
                                                    : (formattedDate ==
                                                            res["date"]
                                                        ? "main.primary"
                                                        : "text.primary"),
                                                isMedium: true,
                                                size: 18.0),
                                            Widgets.buildText(
                                                Helpers.formatDateObject(date,
                                                    formatString: "MMM"),
                                                context,
                                                color: index == 0
                                                    ? "text.disabled"
                                                    : (formattedDate ==
                                                            res["date"]
                                                        ? "main.primary"
                                                        : "text.primary"),
                                                size: 12.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (index <= 1)
                                      Positioned(
                                          bottom: 0.0,
                                          left: 5.0,
                                          right: 5.0,
                                          child: Container(
                                            height: 15.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                color:
                                                    formattedDate == res["date"]
                                                        ? Palette.get(
                                                            "main.primary")
                                                        : Color(0xFF484848)),
                                            child: FittedBox(
                                              child: Widgets.buildText(
                                                  index == 0
                                                      ? "Today"
                                                      : "Tomorrow",
                                                  context,
                                                  color: "text.white",
                                                  isCenter: true,
                                                  size: 12.0),
                                            ),
                                          ))
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 10),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(color: Color(0x14000000)),
                    Row(
                      spacing: 5.0,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Widgets.buildText("Select time", context),
                        if ((item["openingTimes"] ?? []).isEmpty)
                          TextButton(
                              onPressed: () {},
                              child: Widgets.buildText("See more", context,
                                  color: "main.primary"))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Wrap(spacing: 10.0, runSpacing: 10.0, children: [
                      for (final time in times)
                        GestureDetector(
                          onTap: () {
                            setState(() => res["time"] = time.runtimeType ==
                                    String
                                ? time
                                : Helpers.formatDateObject(
                                    today.add(Duration(
                                        minutes: (30 *
                                                (num.tryParse(time.toString())
                                                        ?.toInt() ??
                                                    0)) -
                                            (today.minute - 30))),
                                    formatString: "HH:mm"));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: res["time"] ==
                                        (time.runtimeType == String
                                            ? time
                                            : Helpers.formatDateObject(today.add(Duration(minutes: (30 * (num.tryParse(time.toString())?.toInt() ?? 0)) - (today.minute - 30))),
                                                formatString: "HH:mm"))
                                    ? Palette.get("main.primary")
                                    : Palette.get("background.paper"),
                                border: Border.all(
                                    color: res["time"] ==
                                            (time.runtimeType == String
                                                ? time
                                                : Helpers.formatDateObject(
                                                    today.add(Duration(
                                                        minutes:
                                                            (30 * (num.tryParse(time.toString())?.toInt() ?? 0)) - (today.minute - 30))),
                                                    formatString: "HH:mm"))
                                        ? Palette.get("main.primary")
                                        : Color(0x1A000000))),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Widgets.buildText(
                                time.runtimeType == String
                                    ? time
                                    : Helpers.formatDateObject(
                                        today.add(Duration(
                                            minutes:
                                                (30 * (num.tryParse(time.toString())?.toInt() ?? 0)) -
                                                    (today.minute - 30))),
                                        formatString: "HH:mm"),
                                context,
                                color: res["time"] ==
                                        (time.runtimeType == String
                                            ? time
                                            : Helpers.formatDateObject(
                                                today.add(Duration(minutes: (30 * (num.tryParse(time.toString())?.toInt() ?? 0)) - (today.minute - 30))),
                                                formatString: "HH:mm"))
                                    ? "text.white"
                                    : "text.primary"),
                          ),
                        )
                    ]),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          final price = [
                            (num.tryParse(ticket["adultPrice"].toString())
                                    ?.toDouble() ??
                                0),
                            (num.tryParse(ticket["childrenPrice"].toString())
                                    ?.toDouble() ??
                                0),
                            (num.tryParse(ticket["infantPrice"].toString())
                                    ?.toDouble() ??
                                0)
                          ].firstWhere((price) => price > 0, orElse: () => 0);
                          return GestureDetector(
                            onTap: () {
                              if (ticket["remaining"].toString() == "0") {
                                Alert.show(context, "",
                                    "The ticket you tried to select is already sold out!",
                                    type: "warning");
                              } else if (res.keys
                                  .contains(ticket["name"].toString())) {
                                // remove ticket
                                setState(() => res.removeWhere((key, value) =>
                                    key == ticket["name"].toString()));
                              } else {
                                // add ticket
                                setState(
                                    () => res[ticket["name"].toString()] = 1);
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: res["ticket"] == index
                                              ? Palette.get("main.primary")
                                              : Color(0xFFDADADA))),
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    spacing: 10.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        spacing: 10.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                                color: res["ticket"] == index
                                                    ? Color(0x3341B11A)
                                                    : Palette.get(
                                                        "background.default"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: UnconstrainedBox(
                                              child: Helpers.fetchIcons(
                                                  "ticket-alt", "regular",
                                                  size: 24.0,
                                                  color: res["ticket"] == index
                                                      ? "main.primary"
                                                      : "text.black"),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            spacing: 5.0,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 5.0,
                                                children: [
                                                  FittedBox(
                                                    child: Widgets.buildText(
                                                        ticket["name"], context,
                                                        isMedium: true,
                                                        color: "text.secondary",
                                                        size: 24.0),
                                                  ),
                                                  Widgets.buildText(
                                                      ticket['isRefundable']
                                                                  .toString() ==
                                                              "0"
                                                          ? "Non-refundable"
                                                          : "Refundable",
                                                      context,
                                                      color: "text.disabled",
                                                      size: 11.0,
                                                      lines: 5),
                                                ],
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    final qtys =
                                                        await selectTicketQuantity(
                                                            ticket);
                                                    if (qtys.isNotEmpty) {
                                                      res["ticket"] = index;
                                                      setState(() => res = {
                                                            ...res,
                                                            ...qtys
                                                          });
                                                    }
                                                  },
                                                  style: Widgets.buildButton(
                                                      context,
                                                      horizontal: 20.0,
                                                      vertical: 10.0,
                                                      radius: 5.0,
                                                      sideColor: Palette.get(
                                                          "main.primary")),
                                                  child: Widgets.buildText(
                                                      "Select", context,
                                                      color: "main.primary",
                                                      weight: 500))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 10.0, right: 10.0),
                                        child: Column(
                                          spacing: 15.0,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MySeparator(
                                                color: res["ticket"] == index
                                                    ? Palette.get(
                                                        "main.primary")
                                                    : Color(0xFFDADADA)),
                                            FittedBox(
                                              child: Row(
                                                spacing: 2.0,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Widgets.buildText(
                                                      price == 0
                                                          ? "FREE"
                                                          : Helpers.formatCurrency(
                                                              price.toString()),
                                                      context,
                                                      isMedium: true,
                                                      size: 16.0,
                                                      color: "main.primary"),
                                                  if (price > 0)
                                                    Widgets.buildText(
                                                        "/Person", context,
                                                        color: "text.secondary",
                                                        size: 11.0),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (ticket["remaining"].toString() == "0")
                                  Positioned(
                                      top: 0.0,
                                      right: 15.0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get("error.main"),
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.0))),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Widgets.buildText(
                                              "Sold", context,
                                              weight: 500,
                                              size: 16.0,
                                              color: "text.white"))),
                                Positioned(
                                    bottom: 30.0,
                                    left: -23.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(70.0),
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.2,
                                                  color: res["ticket"] == index
                                                      ? Palette.get(
                                                          "main.primary")
                                                      : Color(0xFFDADADA)))),
                                      child: const SizedBox(
                                        width: 35.0,
                                        height: 35.0,
                                      ),
                                    )),
                                Positioned(
                                    bottom: 30.0,
                                    right: -23.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(70.0),
                                          border: Border(
                                              left: BorderSide(
                                                  width: 1.2,
                                                  color: res["ticket"] == index
                                                      ? Palette.get(
                                                          "main.primary")
                                                      : Color(0xFFDADADA)))),
                                      child: const SizedBox(
                                        width: 35.0,
                                        height: 35.0,
                                      ),
                                    ))
                              ],
                            ),
                          );
                        },
                        itemCount: tickets.length),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (res["ticket"].toString() != "" &&
                            res["date"].toString().isNotEmpty &&
                            res["time"].toString().isNotEmpty) {
                          showTicketsSummary(item, res, fee);
                        } else {
                          Alert.show(context, "",
                              "Please select atleast one ticket, date and time to proceed",
                              type: "warning");
                        }
                      },
                      child: Row(
                        spacing: 2.0,
                        children: [
                          Widgets.buildText("View ticket summary", context,
                              size: 16.0, weight: 500),
                          Helpers.fetchIcons("caret-down", "solid",
                              color: "main.primary", size: 16.0)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(color: Color(0x14000000)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  if (res["ticket"].toString() != "" &&
                                      res["date"].toString().isNotEmpty &&
                                      res["time"].toString().isNotEmpty) {
                                    isProceed = true;
                                    Navigator.pop(context);
                                  } else {
                                    Alert.show(context, "",
                                        "Please select atleast one ticket, date and time to proceed",
                                        type: "warning");
                                  }
                                },
                                style: Widgets.buildButton(context,
                                    background: Palette.getColor(
                                        context, "main", "primary"),
                                    vertical: 15.0,
                                    horizontal: 40.0,
                                    radius: 45.0),
                                child: Widgets.buildText("Continue", context,
                                    isMedium: true, color: "text.white")),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
    return isProceed ? res : {};
  }

  static Future<Map<String, int>> selectTicketQuantity(
      Map<String, dynamic> ticket) async {
    Map<String, int> res = {"adults": 0, "children": 0, "infants": 0};
    bool isProceed = false;
    final categories = ticket["categories"].toString().isEmpty
        ? ["adults", "children", "infants"]
        : jsonDecode(ticket["categories"].toString());
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
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText(ticket["name"], context,
                          isMedium: true),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(color: Color(0x14000000)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          ticket["isRefundable"].toString() == "0"
                              ? "Non-Refundable"
                              : "Refundable",
                          context,
                          color: "text.secondary"),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Widgets.buildText("How many tickets?", context,
                          isMedium: true),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            String title = "";
                            String priceKey = "";
                            if (category == "adults") {
                              title = "Adults (age 18 - 100)";
                              priceKey = "adultPrice";
                            } else if (category == "children") {
                              title = "Children (age 3 - 17)";
                              priceKey = "childrenPrice";
                            } else if (category == "infants") {
                              title = "Infant (age 0 -2)";
                              priceKey = "infantPrice";
                            }
                            final double price =
                                num.tryParse(ticket[priceKey].toString())
                                        ?.toDouble() ??
                                    0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 5.0,
                                children: [
                                  Column(
                                    spacing: 5.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText(title, context,
                                          color: "text.secondary"),
                                      Row(
                                        spacing: 2.0,
                                        children: [
                                          Widgets.buildText("Total:", context,
                                              color: "text.secondary"),
                                          Widgets.buildText(
                                              Helpers.formatCurrency((price *
                                                      (num.tryParse(res[
                                                                      category]
                                                                  .toString())
                                                              ?.toDouble() ??
                                                          0))
                                                  .toString()),
                                              context,
                                              weight: 500),
                                        ],
                                      )
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
                                                              res[category]
                                                                  .toString())
                                                          ?.toInt() ??
                                                      0;
                                                  qty =
                                                      qty - 1 < 0 ? 0 : qty - 1;
                                                  setState(() {
                                                    res[category] = qty;
                                                  });
                                                },
                                                child: Helpers.fetchIcons(
                                                    "minus-circle", "solid",
                                                    size: 30)),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            Widgets.buildText(
                                                res.isEmpty
                                                    ? "0"
                                                    : res[category].toString(),
                                                context,
                                                isMedium: true,
                                                color: "text.secondary"),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  int qty = (num.tryParse(res[
                                                                      category]
                                                                  .toString())
                                                              ?.toInt() ??
                                                          0) +
                                                      1;
                                                  setState(() {
                                                    res[category] = qty;
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
                          itemCount: categories.length),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(color: Color(0x14000000)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        spacing: 5.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 10.0,
                            children: [
                              Widgets.buildText("Total", context,
                                  color: "text.secondary"),
                              Widgets.buildText(
                                  Helpers.formatCurrency(((res["adults"]! *
                                              (num.tryParse(ticket["adultPrice"]
                                                          .toString())
                                                      ?.toDouble() ??
                                                  0)) +
                                          (res["children"]! *
                                              (num.tryParse(ticket[
                                                              "childrenPrice"]
                                                          .toString())
                                                      ?.toDouble() ??
                                                  0)) +
                                          (res["infants"]! *
                                              (num.tryParse(
                                                          ticket["infantPrice"]
                                                              .toString())
                                                      ?.toDouble() ??
                                                  0)))
                                      .toString()),
                                  context,
                                  weight: 500),
                            ],
                          ),
                          Widgets.buildText("Include tax & charges", context,
                              color: "text.secondary")
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    isProceed = true;
                                    Navigator.pop(context);
                                  },
                                  style: Widgets.buildButton(context,
                                      background: Palette.getColor(
                                          context, "main", "primary"),
                                      vertical: 15.0,
                                      horizontal: 40.0,
                                      radius: 45.0),
                                  child: Widgets.buildText("Continue", context,
                                      isMedium: true, color: "text.white")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          });
        });
    return isProceed ? res : {};
  }

  static Future<void> showTicketsSummary(Map<String, dynamic> attraction,
      Map<String, dynamic> selection, double fee) async {
    final tickets = (attraction["tickets"] ?? []);
    final ticket = tickets[selection["ticket"]];
    final subtotal = (selection["adults"]! *
            (num.tryParse(ticket["adultPrice"].toString())?.toDouble() ?? 0)) +
        (selection["children"]! *
            (num.tryParse(ticket["childrenPrice"].toString())?.toDouble() ??
                0)) +
        (selection["infants"]! *
            (num.tryParse(ticket["infantPrice"].toString())?.toDouble() ?? 0));
    final selectedTickets = {};
    if (selection["adults"] > 0) {
      selectedTickets["adults"] = selection["adults"];
    } else if (selection["children"] > 0) {
      selectedTickets["children"] = selection["children"];
    } else if (selection["infants"] > 0) {
      selectedTickets["infants"] = selection["infants"];
    }

    final total = subtotal + fee;
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          double ticketWidth = (screenWidth / 2.0) - 40.0;
          ticketWidth = ticketWidth < 150.0 ? 150.0 : ticketWidth;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Widgets.buildText("Summary", context,
                                isMedium: true),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Helpers.fetchIcons("cross", "solid",
                                    color: "text.secondary", size: 16.0))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: Palette.get("background.paper"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5.0,
                          children: [
                            Widgets.buildText(attraction["title"], context,
                                weight: 500, size: 16.0),
                            Row(
                              spacing: 10.0,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 2.0,
                                  children: [
                                    Helpers.fetchIcons("marker", "solid",
                                        color: "main.primary"),
                                    Widgets.buildText(
                                        attraction["location"], context,
                                        color: "text.secondary")
                                  ],
                                ),
                                Row(
                                  spacing: 2.0,
                                  children: [
                                    Helpers.fetchIcons(
                                        "calendar-clock", "solid",
                                        color: "main.primary"),
                                    Widgets.buildText(
                                        Helpers.formatDate(selection["date"],
                                            formatString: "EEE, MMM dd yy"),
                                        context,
                                        color: "text.secondary"),
                                    Widgets.buildText(
                                        selection["time"], context,
                                        color: "text.secondary")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: Palette.get("background.paper"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25.0),
                        child: Column(
                          spacing: 10.0,
                          children: [
                            for (final selectedTicket
                                in selectedTickets.keys.toList())
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 10.0,
                                children: [
                                  Expanded(
                                    child: Widgets.buildText(
                                        "${selectedTickets[selectedTicket]} X ${attraction["title"]}",
                                        context,
                                        weight: 500,
                                        size: 16.0),
                                  ),
                                  Widgets.buildText(
                                      selectedTicket.toString().capitalize(),
                                      context,
                                      weight: 500,
                                      size: 16.0),
                                ],
                              ),
                            const Divider(color: Color(0x14000000)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10.0,
                              children: [
                                Expanded(
                                  child: Widgets.buildText("Fees", context,
                                      weight: 500, size: 16.0),
                                ),
                                Widgets.buildText(
                                    Helpers.formatCurrency(fee.toString()),
                                    context,
                                    weight: 500,
                                    size: 16.0),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 10.0,
                              children: [
                                Expanded(
                                  child: Widgets.buildText("Subtotal", context,
                                      weight: 500, size: 16.0),
                                ),
                                Widgets.buildText(
                                    Helpers.formatCurrency(subtotal.toString()),
                                    context,
                                    weight: 500,
                                    size: 16.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: Palette.get("background.paper"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10.0,
                          children: [
                            Expanded(
                              child: Widgets.buildText("Total", context,
                                  weight: 500,
                                  size: 16.0,
                                  color: "main.primary"),
                            ),
                            Widgets.buildText(
                                Helpers.formatCurrency(total.toString()),
                                context,
                                weight: 500,
                                size: 16.0,
                                color: "main.primary"),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
  }

  static Future<void> selectCategories() async {
    final items = Defaults.attractionCategories;
    final selectedPref =
        await Helpers.readPref(Defaults.selectedAttractionCategories);
    List<dynamic> selected =
        selectedPref.isNotEmpty ? jsonDecode(selectedPref) : [];
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
                color: Palette.getColor(context, "background", "paper"),
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: kToolbarHeight, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TweenAnimationBuilder(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: selected.length / 5.0,
                                    ),
                                    builder: (context, value, _) =>
                                        LinearProgressIndicator(
                                      value: value,
                                      backgroundColor:
                                          Palette.get("background.default"),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Widgets.buildText("Skip", context,
                                        weight: 500,
                                        size: 13.0,
                                        color: "main.primary")),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Wrap(
                              children: [
                                Widgets.buildText("Select up to ", context,
                                    color: "text.secondary",
                                    weight: 500,
                                    size: 24.0),
                                Widgets.buildText("5", context,
                                    color: "text.secondary",
                                    weight: 500,
                                    size: 24.0),
                                Widgets.buildText(
                                    " Favorite Attractions", context,
                                    color: "text.secondary",
                                    weight: 500,
                                    size: 24.0),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Widgets.buildText(
                                "We will suggest attractions based on what you like",
                                context,
                                color: "text.disabled"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15.0),
                            color: Palette.get("background.paper"),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10.0,
                              children: [
                                Wrap(
                                  spacing: 20.0,
                                  runSpacing: 20.0,
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    for (final item in items)
                                      GestureDetector(
                                        onTap: () {
                                          if (selected.contains(
                                              item["value"].toString())) {
                                            setState(() => selected.remove(
                                                item["value"].toString()));
                                          } else {
                                            setState(() => selected = [
                                                  ...selected,
                                                  item["value"].toString()
                                                ]);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: selected.contains(
                                                    item["value"].toString())
                                                ? Palette.get("main.primary")
                                                : Color(0xFFE5E5E5),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 25.0),
                                          child: Widgets.buildText(
                                              (item["nameFull"] ?? item["name"])
                                                  .toString()
                                                  .capitalize(),
                                              context,
                                              weight: 500,
                                              color: selected.contains(
                                                      item["value"].toString())
                                                  ? "text.white"
                                                  : "text.primary"),
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Helpers.writePref(
                                    Defaults.selectedAttractionCategories,
                                    jsonEncode(selected));
                                Navigator.pop(context);
                              },
                              style: Widgets.buildButton(context,
                                  background: Palette.getColor(
                                      context, "main", "primary"),
                                  vertical: 15.0,
                                  horizontal: 40.0,
                                  radius: 45.0),
                              child: Widgets.buildText("Continue", context,
                                  isMedium: true, color: "text.white")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static void showIncluded(List includeds, List notIncluded,
      {List restrictions = const [],
      List information = const [],
      List faq = const [],
      String title = ""}) async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:
                            Palette.getColor(context, "background", "default"),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.0,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Widgets.buildText("Included", context,
                                isMedium: true, color: "text.secondary"),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                for (final item in includeds)
                                  IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        Helpers.fetchIcons(
                                            "check-double", "solid",
                                            color: "main.primary"),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Expanded(
                                          child: Widgets.buildText(
                                              item.toString(), context,
                                              color: "text.disabled", lines: 5),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            Widgets.buildText("Not Included", context,
                                isMedium: true, color: "text.secondary"),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                for (final item in notIncluded)
                                  IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        Helpers.fetchIcons("cross", "solid",
                                            color: "error.main", size: 10.0),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Expanded(
                                          child: Widgets.buildText(
                                              item.toString(), context,
                                              color: "text.disabled", lines: 5),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            if (restrictions.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15.0),
                                  Widgets.buildText("Restrictions", context,
                                      isMedium: true, color: "text.secondary"),
                                  const SizedBox(height: 15.0),
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      for (final item in restrictions)
                                        IntrinsicWidth(
                                          child: Row(
                                            children: [
                                              Helpers.fetchIcons(
                                                  "check-double", "solid",
                                                  color: "main.primary"),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Expanded(
                                                child: Widgets.buildText(
                                                    item.toString(), context,
                                                    color: "text.disabled",
                                                    lines: 5),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            if (restrictions.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15.0),
                                  Widgets.buildText(
                                      "Additional Information", context,
                                      isMedium: true, color: "text.secondary"),
                                  const SizedBox(height: 15.0),
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      for (final item in information)
                                        IntrinsicWidth(
                                          child: Row(
                                            children: [
                                              Helpers.fetchIcons(
                                                  "check-double", "solid",
                                                  color: "main.primary"),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Expanded(
                                                child: Widgets.buildText(
                                                    item.toString(), context,
                                                    color: "text.disabled",
                                                    lines: 5),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            if (faq.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15.0),
                                  Widgets.buildText(
                                      "FAQs about $title", context,
                                      isMedium: true, color: "text.secondary"),
                                  const SizedBox(height: 15.0),
                                  Column(
                                    spacing: 10.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (final item in faq)
                                        Column(
                                          spacing: 5.0,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Widgets.buildText(
                                                item["question"], context,
                                                lines: 5, weight: 500),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Widgets.buildText(
                                                item["answer"],
                                                context,
                                                lines: 5,
                                                color: "text.disabled",
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ],
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: double.infinity,
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
                                child: Widgets.buildText("OK", context,
                                    isMedium: true, color: "text.white")),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  static Future<Map<String, String>> selectDates(
      String startDate, String endDate) async {
    final List dates = [
      {"name": "Today", "value": "today"},
      {"name": "This Week", "value": "week"},
      {"name": "This Month", "value": "month"},
      {"name": "Start Date", "value": "start_date"},
      {"name": "End Date", "value": "end_date"}
    ];
    Map<String, String> result = {"startDate": "", "endDate": ""};
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:
                            Widgets.buildText("Date", context, isMedium: true),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            for (var date in dates)
                              IntrinsicWidth(
                                child: Row(
                                  spacing: 10.0,
                                  children: [
                                    UnconstrainedBox(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (date["value"] == "start_date") {
                                            // load up date.
                                            final res = await Sheets.selectDate(
                                                "",
                                                title: "Select start date");
                                            result["startDate"] = res;
                                            setState(() =>
                                                result["startDate"] = res);
                                          } else if (date["value"] ==
                                              "end_date") {
                                            // load up date.
                                            final res = await Sheets.selectDate(
                                                "",
                                                title: "Select end date");
                                            setState(
                                                () => result["endDate"] = res);
                                          } else {
                                            // other
                                            setState(() {
                                              result["startDate"] =
                                                  date["value"];
                                              result["endDate"] = "";
                                            });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: (!date["value"].toString().contains("_") && result["startDate"] == date["value"]) ||
                                                      (date["value"] == "start_date" &&
                                                          result["startDate"]
                                                              .toString()
                                                              .contains("-")) ||
                                                      (date["value"] == "end_date" &&
                                                          result["endDate"]
                                                              .toString()
                                                              .contains("-"))
                                                  ? Palette.getColor(
                                                      context, "main", "primary")
                                                  : Palette.getColor(
                                                      context, "background", "paper"),
                                              border: Border.all(
                                                  color: (!date["value"].toString().contains("_") && result["startDate"] == date["value"]) ||
                                                          (date["value"] == "start_date" && result["startDate"].toString().contains("-")) ||
                                                          (date["value"] == "end_date" && result["endDate"].toString().contains("-"))
                                                      ? Palette.get("main.primary")
                                                      : Color(0x1A000000)),
                                              borderRadius: BorderRadius.circular(25.0)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 25.0),
                                          child: Row(
                                            children: [
                                              if (date["value"]
                                                  .toString()
                                                  .contains("_"))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Helpers.fetchIcons(
                                                      "calendar-clock",
                                                      "regular",
                                                      size: 16.0,
                                                      color: "main.primary"),
                                                ),
                                              Widgets.buildText(
                                                  date["name"].toString(),
                                                  context,
                                                  color: (!date[
                                                                      "value"]
                                                                  .toString()
                                                                  .contains(
                                                                      "_") &&
                                                              result["startDate"] ==
                                                                  date[
                                                                      "value"]) ||
                                                          (date["value"] ==
                                                                  "start_date" &&
                                                              result["startDate"]
                                                                  .toString()
                                                                  .contains(
                                                                      "-")) ||
                                                          (date["value"] ==
                                                                  "end_date" &&
                                                              result["endDate"]
                                                                  .toString()
                                                                  .contains("-"))
                                                      ? "text.white"
                                                      : "text.secondary"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (date["name"].toString() == "Start Date")
                                      Widgets.buildText("to", context,
                                          color: "text.black"),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Widgets.buildText("Show events from:", context,
                                isMedium: true),
                            Widgets.buildText(
                                result["startDate"].toString().isNotEmpty
                                    ? Helpers.formatDate(
                                        result["startDate"].toString(),
                                        formatString: "dd MMM, yyyy")
                                    : "",
                                context),
                            if (result["endDate"].toString().isNotEmpty)
                              Widgets.buildText("to:", context, isMedium: true),
                            Widgets.buildText(
                                result["endDate"].toString().isNotEmpty
                                    ? Helpers.formatDate(
                                        result["endDate"].toString(),
                                        formatString: "dd MMM, yyyy")
                                    : "",
                                context),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          spacing: 10.0,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  result = {"startDate": "", "endDate": ""};
                                  Navigator.pop(context);
                                },
                                child: Widgets.buildText("Clear all", context,
                                    color: "text.disabled", isMedium: true)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: Widgets.buildButton(context,
                                    background: Palette.getColor(
                                        context, "main", "primary"),
                                    vertical: 15.0,
                                    horizontal: 40.0,
                                    radius: 45.0),
                                child: Widgets.buildText("Apply", context,
                                    isMedium: true, color: "text.white")),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
    return result;
  }

  static Future<void> showPreview(Map<String, dynamic> item) async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: Palette.getColor(context, "background", "overlay"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/attraction",
                                arguments: jsonEncode(item));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 400.0,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(item["image"],
                                            width: double.infinity,
                                            height: 400.0,
                                            fit: BoxFit.cover)),
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.overlay"),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5.0,
                                        children: [
                                          Widgets.buildText(
                                              item["title"], context,
                                              isMedium: true,
                                              color: "text.white"),
                                          Widgets.buildText(
                                              "From: ${Helpers.formatCurrency(item["price"].toString())}",
                                              context,
                                              color: "text.white")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              IntrinsicWidth(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    spacing: 5.0,
                                    children: [
                                      Widgets.buildText(
                                          "View attraction", context,
                                          color: "text.disabled"),
                                      Helpers.fetchIcons("exclamation", "solid",
                                          color: "main.primary")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
