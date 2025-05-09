import 'package:afritas/globals/hotel_item.dart';
import 'package:afritas/main.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/palette.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelModals {
  static Future<Map<String, dynamic>> filters(Map<String, dynamic> filter,
      List recentSearches, List neighbourhoods, List brands, int total) async {
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
                            final res = await filterOther(
                                filter, neighbourhoods, brands, total);
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          "Check-in date", context,
                                          color: "text.secondary"),
                                      Widgets.buildText(
                                          "Check-out date", context,
                                          color: "text.secondary"),
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
                                                      filter["endDate"]
                                                          .toString(),title: "select end date");
                                              result["endDate"] = res;
                                              endDateController.text =
                                                  Helpers.formatDate(res,
                                                      formatString: "MMM dd");
                                              result["duration"] =
                                                  Helpers.dateDiff(
                                                          result["startDate"]
                                                              .toString(),
                                                          res)
                                                      .toString();
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
                                  Widgets.buildText("Select Guest", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText("Adult", context,
                                              weight: 500),
                                          Widgets.buildText(
                                              "Age 18 or Above", context,
                                              color: "text.secondary"),
                                        ],
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
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var guest = num.tryParse(
                                                                  result["adults"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      guest = guest - 1 < 0
                                                          ? 0
                                                          : guest - 1;
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
                                                    result["adults"].toString(),
                                                    context,
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
                                                        size: 30,
                                                        color: "main.primary")),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText("Children", context,
                                              weight: 500),
                                          Widgets.buildText(
                                              "Age 2 to 17", context,
                                              color: "text.secondary"),
                                        ],
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
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var guest = num.tryParse(
                                                                  result["children"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      guest = guest - 1 < 0
                                                          ? 0
                                                          : guest - 1;
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
                                                    result["children"]
                                                        .toString(),
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
                                                        size: 30,
                                                        color: "main.primary")),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText("Rooms", context,
                                              weight: 500),
                                          Widgets.buildText(
                                              "Select rooms", context,
                                              color: "text.secondary"),
                                        ],
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
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var rooms = num.tryParse(
                                                                  result["rooms"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      rooms = rooms - 1 < 0
                                                          ? 0
                                                          : rooms - 1;
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
                                                    result["rooms"].toString(),
                                                    context,
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
                            Widgets.buildText("Recent Searches", context,
                                isMedium: true),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ConstrainedBox(
                                constraints: BoxConstraints.loose(
                                    Size(screenWidth, 180.0)),
                                child: Swiper(
                                  outer: true,
                                  layout: SwiperLayout.CUSTOM,
                                  customLayoutOption: Widgets.customLayout(
                                      recentSearches.length, screenWidth,
                                      offset: 80.0),
                                  itemHeight: 180.0,
                                  itemWidth: screenWidth,
                                  loop: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = recentSearches[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 70.0),
                                      child: HotelItem(
                                          item: item, direction: "horizontal"),
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
      Map<String, dynamic> filter,
      List neighbourhoods,
      List brands,
      int total) async {
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
    var seeMoreNeighbourhood = false;
    var seeMoreBrand = false;
    List selectedCategories = (filter["categories"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedFacilities = (filter["facilities"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedPolicies = (filter["policy"] ?? []).toList();
    List selectedBrands = (filter["brands"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    List selectedRatings = filter["property_rating"] ?? [];
    List selectedNeighbourhood = (filter["neighbourhood"] ?? [])
        .map((item) => item["value"].toString())
        .toList();
    Map<String, dynamic> bedroomBathrooms =
        filter["bedroom_bathroom"] ?? {"bedroom": 0, "bathroom": 0};

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
                                  Widgets.buildText(
                                      "Categories by type", context,
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
                                            ? Defaults.hotelCategories
                                            : Defaults.hotelCategories
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
                                                        .hotelCategories
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
                                                        .hotelCategories
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
                                                    Image.asset(
                                                        "assets/images/hotel-categories.png",
                                                        width: 24,
                                                        height: 24,
                                                        fit: BoxFit.contain),
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
                                  Widgets.buildText("Facilities", context,
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
                                        for (var item in (seeMoreFacilities
                                            ? Defaults.hotelFacilities
                                            : Defaults.hotelFacilities
                                                .getRange(0, 10)
                                                .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedFacilities
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedFacilities
                                                        .remove(item["value"]);
                                                    filter["facilities"] = Defaults
                                                        .hotelFacilities
                                                        .where((item) =>
                                                            selectedFacilities
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedFacilities
                                                        .add(item["value"]);
                                                    filter["facilities"] = Defaults
                                                        .hotelFacilities
                                                        .where((item) =>
                                                            selectedFacilities
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedFacilities.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedFacilities.contains(item["value"])
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
                                                      item["icon"],
                                                      "regular",
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 5.0),
                                                    Widgets.buildText(
                                                        item["label"]
                                                            .toString(),
                                                        context,
                                                        color: selectedFacilities
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
                                  Widgets.buildText("Neighbourhood", context,
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
                                            in (seeMoreNeighbourhood ||
                                                    neighbourhoods.length <= 10
                                                ? neighbourhoods
                                                : neighbourhoods
                                                    .getRange(0, 10)
                                                    .toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedNeighbourhood
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedNeighbourhood
                                                        .remove(item["value"]);
                                                    filter["neighbourhood"] =
                                                        neighbourhoods
                                                            .where((item) =>
                                                                selectedNeighbourhood
                                                                    .contains(item[
                                                                        "value"]))
                                                            .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedNeighbourhood
                                                        .add(item["value"]);
                                                    filter["neighbourhood"] =
                                                        neighbourhoods
                                                            .where((item) =>
                                                                selectedNeighbourhood
                                                                    .contains(item[
                                                                        "value"]))
                                                            .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedNeighbourhood.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedNeighbourhood.contains(item["value"])
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
                                                    color: selectedNeighbourhood
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
                                  if (neighbourhoods.length > 10)
                                    UnconstrainedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() => seeMoreNeighbourhood =
                                              !seeMoreNeighbourhood);
                                        },
                                        child: Row(
                                          children: [
                                            Widgets.buildText(
                                                seeMoreNeighbourhood
                                                    ? "See less"
                                                    : "See more",
                                                context,
                                                color: "main.primary",
                                                weight: 500),
                                            const SizedBox(width: 5.0),
                                            Helpers.fetchIcons(
                                                seeMoreNeighbourhood
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
                                      "Bedroom and Bathroom", context,
                                      weight: 500),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText("Bedrooms", context,
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
                                                                  bedroomBathrooms[
                                                                          "bedroom"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      item = item - 1 < 0
                                                          ? 0
                                                          : item - 1;
                                                      setState(() {
                                                        bedroomBathrooms[
                                                            "bedroom"] = item;
                                                        result["bedroom_bathroom"] =
                                                            bedroomBathrooms;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "minus-circle", "solid",
                                                        size: 30)),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Widgets.buildText(
                                                    bedroomBathrooms["bedroom"]
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
                                                                      bedroomBathrooms[
                                                                              "bedroom"]
                                                                          .toString())
                                                                  ?.toInt() ??
                                                              0) +
                                                          1;
                                                      setState(() {
                                                        bedroomBathrooms[
                                                            "bedroom"] = item;
                                                        result["bedroom_bathroom"] =
                                                            bedroomBathrooms;
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
                                  Divider(
                                    color: Color(0x1a000000),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText("Bathrooms", context,
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
                                                                  bedroomBathrooms[
                                                                          "bathroom"]
                                                                      .toString())
                                                              ?.toInt() ??
                                                          0;
                                                      item = item - 1 < 0
                                                          ? 0
                                                          : item - 1;
                                                      setState(() {
                                                        bedroomBathrooms[
                                                            "bathroom"] = item;
                                                        result["bedroom_bathroom"] =
                                                            bedroomBathrooms;
                                                      });
                                                    },
                                                    child: Helpers.fetchIcons(
                                                        "minus-circle", "solid",
                                                        size: 30)),
                                                const SizedBox(
                                                  width: 15.0,
                                                ),
                                                Widgets.buildText(
                                                    bedroomBathrooms["bathroom"]
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
                                                                      bedroomBathrooms[
                                                                              "bathroom"]
                                                                          .toString())
                                                                  ?.toInt() ??
                                                              0) +
                                                          1;
                                                      setState(() {
                                                        bedroomBathrooms[
                                                            "bathroom"] = item;
                                                        result["bedroom_bathroom"] =
                                                            bedroomBathrooms;
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
                                  Widgets.buildText("Brands", context,
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
                                        for (var item in (seeMoreBrand ||
                                                brands.length <= 10
                                            ? brands
                                            : brands.getRange(0, 10).toList()))
                                          UnconstrainedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (selectedBrands
                                                    .contains(item["value"])) {
                                                  // remove
                                                  setState(() {
                                                    selectedBrands
                                                        .remove(item["value"]);
                                                    filter["brands"] = brands
                                                        .where((item) =>
                                                            selectedBrands
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                } else {
                                                  // add
                                                  setState(() {
                                                    selectedBrands
                                                        .add(item["value"]);
                                                    filter["brands"] = brands
                                                        .where((item) =>
                                                            selectedBrands
                                                                .contains(item[
                                                                    "value"]))
                                                        .toList();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedBrands.contains(item["value"])
                                                        ? Palette.getColor(
                                                            context,
                                                            "background",
                                                            "default")
                                                        : Palette.getColor(
                                                            context,
                                                            "background",
                                                            "paper"),
                                                    border: Border.all(
                                                        color: selectedBrands.contains(item["value"])
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
                                  if (brands.length > 10)
                                    UnconstrainedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() =>
                                              seeMoreBrand = !seeMoreBrand);
                                        },
                                        child: Row(
                                          children: [
                                            Widgets.buildText(
                                                seeMoreBrand
                                                    ? "See less"
                                                    : "See more",
                                                context,
                                                color: "main.primary",
                                                weight: 500),
                                            const SizedBox(width: 5.0),
                                            Helpers.fetchIcons(
                                                seeMoreBrand
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
                                      "Reservation Policy", context,
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
                                result["facilities"] = [];
                                result["property_rating"] = [];
                                result["neighbourhood"] = [];
                                result["bedroom_bathroom"] = {
                                  "bedroom": 0,
                                  "bathroom": 0
                                };
                                result["brands"] = [];
                                result["policy"] = [];

                                seeMoreCategories = false;
                                seeMoreFacilities = false;
                                seeMoreNeighbourhood = false;
                                seeMoreBrand = false;
                                selectedCategories = [];
                                selectedFacilities = [];
                                selectedPolicies = [];
                                selectedBrands = [];
                                selectedRatings = [];
                                selectedNeighbourhood = [];
                                bedroomBathrooms = {
                                  "bedroom": 0,
                                  "bathroom": 0
                                };
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
}
