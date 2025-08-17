import 'dart:convert';

import 'package:nobleassets/globals/automobile_item.dart';
import 'package:nobleassets/globals/hotel_item.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/home_header.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({Key? key}) : super(key: key);

  @override
  _HotelHomeState createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  var selected = "hotel";
  var selectedLocation = "";
  var selectedDestination = "";
  Map<String, dynamic> profile = {};
  List<Map<String, String>> categories = [
    {"name": "Hotels", "image": "hotels.png", "id": "hotel", "type": "0"},
    {"name": "Shortlets", "image": "house.png", "id": "shortlet", "type": "2"},
    {"name": "Cars", "image": "villa.png", "id": "car", "type": "1"},
    {"name": "Deals", "image": "resorts.png", "id": "deal", "type": "0"},
  ];

  Map<dynamic, dynamic> data = {
    "featured": [
      {
        "title": "Urban Hotels",
        "image": "assets/images/hotels.jpeg",
        "id": "3836352"
      },
      {
        "title": "Urban Hotels",
        "image": "assets/images/hotels.jpeg",
        "id": "3836352"
      },
      {
        "title": "Urban Hotels",
        "image": "assets/images/hotels.jpeg",
        "id": "3836352"
      },
    ],
    "recentSearches": [
      {
        "name": "BW Starfire",
        "date": "15 - 18 Jan",
        "guest": "7 adults",
        "image": "assets/images/hotels.jpeg"
      },
      {
        "name": "BW Starfire",
        "date": "15 - 18 Jan",
        "guest": "7 adults",
        "image": "assets/images/hotels.jpeg"
      },
      {
        "name": "BW Starfire",
        "date": "15 - 18 Jan",
        "guest": "7 adults",
        "image": "assets/images/hotels.jpeg"
      },
      {
        "name": "BW Starfire",
        "date": "15 - 18 Jan",
        "guest": "7 adults",
        "image": "assets/images/hotels.jpeg"
      }
    ],
    "topStays": [
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      }
    ],
    "nearbyItems": [
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      }
    ],
    "items": [
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456",
        "isBreakfast": 1
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456",
        "isBreakfast": 1
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      },
      {
        "title": "Urban hotels",
        "image": "assets/images/hotels.jpeg",
        "location": "Osapa Lagos",
        "price": 39500,
        "rating": 4.9,
        "room": "Deluxe Room",
        "hotelId": "123456"
      }
    ],
  };
  bool loading = true;
  String error = "";

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getHome(selected);
      setState(() {
        data = res;
        loading = false;
        selectedLocation =
            res.containsKey("locations") && res["locations"].isNotEmpty
                ? res["locations"].keys.first
                : "";
        selectedDestination =
            res.containsKey("destinations") && res["destinations"].isNotEmpty
                ? res["destinations"].keys.first
                : "";
      });
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  void handleWishlistChanged(Map<dynamic, dynamic> listing) {
    final newData = Helpers.updateWishlistValue(data, listing);
    print("newData $newData");
    setState(() {
      data = newData;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final data = await Helpers.getProfile();
      setState(() {
        profile = data["user"] ?? {};
      });
      fetch();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final backgroundHeight = profile.isNotEmpty ? height * 0.25 : 160.0;
    final mainPaddingTop = backgroundHeight / 10;
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: backgroundHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash.png',
                  ),
                  fit: BoxFit.cover),
              color: Palette.getColor(context, "main", "primary"),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(120),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const SizedBox()),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 15.0, right: 15.0, top: mainPaddingTop),
              child: Column(
                children: [
                  HomeHeader(searchPage: "/hotel-search", profile: profile),
                  SizedBox(
                    height: mainPaddingTop * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Widgets.buildText("Categories", context,
                        //         isMedium: true, size: 18.0),
                        //     GestureDetector(
                        //         onTap: () {
                        //           Navigator.pushNamed(
                        //               context, "/hotel-categories",
                        //               arguments: jsonEncode(categories));
                        //         },
                        //         child: Widgets.buildText("See all", context,
                        //             color: "main.primary"))
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var category in categories)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = category["id"] ?? "";
                                      });
                                      fetch();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Palette.get("background.paper"),
                                            border: Border.all(
                                              color: selected ==
                                                      category["id"].toString()
                                                  ? Palette.get("main.primary")
                                                  : Color(0x0d000000),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          child: FittedBox(
                                            child: Image.asset(
                                              "assets/images/${category["image"]}",
                                              height: 30.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        FittedBox(
                                          child: Widgets.buildText(
                                              category["name"].toString(),
                                              context,
                                              color: selected ==
                                                      category["id"].toString()
                                                  ? "main.primary"
                                                  : "text.primary",
                                              isBold: selected ==
                                                  category["id"].toString(),
                                              size: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        if (loading)
                          Shimmer.fromColors(
                              baseColor: Palette.get("background.neutral"),
                              highlightColor: Palette.get("background.default"),
                              loop: 1,
                              child: AbsorbPointer(
                                  child:
                                      buildContent(screenWidth: screenWidth))),
                        if (error.isNotEmpty)
                          Alert.showErrorMessage(context, "",
                              message: error,
                              buttonText: "Retry",
                              padding: 50.0,
                              action: fetch),
                        if (!loading && error.isEmpty)
                          buildContent(screenWidth: screenWidth)
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContent({
    double screenWidth = 0,
  }) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        if (data.containsKey("featured"))
          ConstrainedBox(
              constraints: BoxConstraints.loose(Size(screenWidth, 230.0)),
              child: Swiper(
                outer: true,
                itemBuilder: (BuildContext context, int index) {
                  final item = (data["featured"] ?? [])[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          selected == "car"
                              ? "/automobile"
                              : "/${selected == "deal" ? "hotel" : selected}",
                          arguments: jsonEncode(item));
                    },
                    child: Container(
                      height: 180.0,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color:
                              Palette.getColor(context, "background", "paper"),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Helpers.getPhoto(item["photo"].toString(),
                                type: selected == "deal" ? "hotel" : selected,
                                text: item["title"]),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    stops: [
                                      0.1,
                                      0.9
                                    ],
                                    colors: [
                                      Colors.black.withAlpha(204),
                                      Colors.black.withAlpha(26)
                                    ])),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Widgets.buildText(
                                    item["title"].toString(), context,
                                    isMedium: true, color: "text.white"),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                                color: Color(0xB3403c3c),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Widgets.buildText("Featured", context,
                                size: 12.0, weight: 500, color: "text.white"),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: (data["featured"] ?? []).length,
                pagination: SwiperPagination(builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < config.itemCount; i += 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 0.0),
                          child: Container(
                              width: config.activeIndex == i ? 25 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: config.activeIndex == i
                                      ? Palette.getColor(
                                          context, "main", "primary")
                                      : Color(0xffd9d9d9),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                    ],
                  );
                })),
              )),
        if (data.containsKey("featured") && data["featured"].isNotEmpty)
          const SizedBox(height: 20.0),
        if (data.containsKey("recentSearches") &&
            data["recentSearches"].isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widgets.buildText("Recent Searches", context,
                  isMedium: true, size: 18.0),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/hotel-search");
                  },
                  child: Widgets.buildText("See all", context,
                      color: "main.primary"))
            ],
          ),
        if (data.containsKey("recentSearches") &&
            data["recentSearches"].isNotEmpty)
          const SizedBox(
            height: 20.0,
          ),
        if (data.containsKey("recentSearches") &&
            data["recentSearches"].isNotEmpty)
          ConstrainedBox(
              constraints: BoxConstraints.loose(Size(screenWidth, 100.0)),
              child: Swiper(
                outer: true,
                layout: SwiperLayout.CUSTOM,
                customLayoutOption: Widgets.customLayout(
                    (data["recentSearches"] ?? []).length, screenWidth,
                    offset: 130.0),
                itemHeight: 80.0,
                itemWidth: screenWidth,
                loop: true,
                itemBuilder: (BuildContext context, int index) {
                  final item = (data["recentSearches"] ?? [])[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 110.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/hotel-filter",
                            arguments: jsonEncode({
                              "category": item["name"].toString(),
                              "startDate": item["dateFrom"].toString(),
                              "endDate": item["dateTo"].toString(),
                              "guests": item["guest"].toString()
                            }));
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.getColor(
                                context, "background", "paper"),
                            border: Border.all(color: Color(0x0d000000)),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          children: [
                            Helpers.getPhoto(item["image"].toString(),
                                type: "hotel", width: 70.0, height: 70.0),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Widgets.buildText(
                                      item["name"].toString(), context,
                                      isMedium: true),
                                  const SizedBox(height: 5.0),
                                  Widgets.buildText(
                                      "${item["date"]}, ${item["guest"]}",
                                      context,
                                      color: "text.secondary"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: (data["recentSearches"] ?? []).length,
              )),
        const SizedBox(height: 20.0),
        if (data.containsKey("topStays") && data["topStays"].isNotEmpty)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Widgets.buildText(
                      selected == "car" ? "Our top rentals" : "Our top stays",
                      context,
                      isMedium: true,
                      size: 18.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/hotel-filter",
                            arguments: jsonEncode({
                              "sortBy": "popularity",
                              "category": selected == "hotel" ||
                                      selected == "deal"
                                  ? "hotel"
                                  : (selected == "shortlet" ? "apartment" : ""),
                              "type": selected
                            }));
                      },
                      child: Widgets.buildText("See all", context,
                          color: "main.primary"))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  height: 365.0,
                  width: screenWidth,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final item = (data["topStays"] ?? [])[index];
                      return SizedBox(
                        width: screenWidth - 70,
                        child: selected == "car"
                            ? AutomobileItem(
                                item: item,
                                offset: 20,
                                wishlistAction: handleWishlistChanged)
                            : HotelItem(
                                item: item,
                                offset: 20,
                                wishlistAction: handleWishlistChanged,
                              ),
                      );
                    },
                    itemCount: (data["topStays"] ?? []).length,
                  )),
            ],
          ),
        if (data.containsKey("nearbyItems") && data["nearbyItems"].isNotEmpty)
          Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Widgets.buildText(
                      "Nearby ${selected.isNotEmpty ? categories.firstWhere(
                            (category) => category["id"] == selected,
                            orElse: () => {},
                          )["name"] ?? "Hotels" : "Hotels"}",
                      context,
                      isMedium: true,
                      size: 18.0),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/hotel-filter",
                            arguments: jsonEncode({
                              "sortBy": "proximity",
                              "category": selected == "hotel" ||
                                      selected == "deal"
                                  ? "hotel"
                                  : (selected == "shortlet" ? "apartment" : ""),
                              "type": selected
                            }));
                      },
                      child: Widgets.buildText("See all", context,
                          color: "main.primary"))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final item = (data["nearbyItems"] ?? [])[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: selected == "car"
                        ? AutomobileItem(
                            item: item,
                            direction: "vertical",
                            wishlistAction: handleWishlistChanged,
                          )
                        : HotelItem(
                            item: item,
                            direction: "horizontal",
                            wishlistAction: handleWishlistChanged,
                            type: selected),
                  );
                },
                itemCount: (data["nearbyItems"] ?? []).length,
              ),
            ],
          ),
        if (data.containsKey("destinations") && data["destinations"].isNotEmpty)
          Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Widgets.buildText(
                      selected == "car"
                          ? "Get the luxury you deserve"
                          : "Discover your home away from home",
                      context,
                      isMedium: true,
                      size: 18.0),
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/hotel-filter",
                          arguments: jsonEncode({
                            "category": selected == "hotel" ||
                                    selected == "deal"
                                ? "hotel"
                                : (selected == "shortlet" ? "apartment" : ""),
                            "type": selected
                          })),
                      child: Widgets.buildText("See all", context,
                          color: "main.primary"))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                spacing: 20.0,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20.0,
                        children: [
                          for (var key in data["destinations"].keys)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDestination = key;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 4.0,
                                children: [
                                  Widgets.buildText(
                                    key,
                                    context,
                                    size: 14.0,
                                    isMedium: true,
                                    color: key == selectedDestination
                                        ? "main.primary"
                                        : "text.primary",
                                  ),
                                  if (key == selectedDestination)
                                    Container(
                                      width: 40.0,
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Palette.get("main.primary"),
                                              width: 2.0),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                        ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final listing =
                          data["destinations"][selectedDestination][index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: selected == "car"
                            ? AutomobileItem(
                                item: listing,
                                direction: "horizontal",
                                wishlistAction: handleWishlistChanged,
                              )
                            : HotelItem(
                                item: listing,
                                direction: "horizontal",
                                type: selected,
                                wishlistAction: handleWishlistChanged,
                              ),
                      );
                    },
                    itemCount: (data["destinations"][selectedDestination] ?? [])
                        .length,
                  )
                ],
              ),
            ],
          ),
        if (data.containsKey("locations") && data["locations"].isNotEmpty)
          Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Widgets.buildText("Your home in popular locations", context,
                      isMedium: true, size: 18.0),
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/hotel-filter",
                          arguments: jsonEncode({
                            "category": selected == "hotel" ||
                                    selected == "deal"
                                ? "hotel"
                                : (selected == "shortlet" ? "apartment" : ""),
                            "type": selected
                          })),
                      child: Widgets.buildText("See all", context,
                          color: "main.primary"))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                spacing: 20.0,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20.0,
                        children: [
                          for (var key in data["locations"].keys)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedLocation = key;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 4.0,
                                children: [
                                  Widgets.buildText(
                                    key,
                                    context,
                                    size: 14.0,
                                    isMedium: true,
                                    color: key == selectedLocation
                                        ? "main.primary"
                                        : "text.primary",
                                  ),
                                  if (key == selectedLocation)
                                    Container(
                                      width: 40.0,
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border(
                                          bottom: BorderSide(
                                              color:
                                                  Palette.get("main.primary"),
                                              width: 2.0),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                        ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final listing =
                          data["locations"][selectedLocation][index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: selected == "car"
                            ? AutomobileItem(
                                item: listing,
                                wishlistAction: handleWishlistChanged)
                            : HotelItem(
                                item: listing,
                                type: selected,
                                wishlistAction: handleWishlistChanged,
                              ),
                      );
                    },
                    itemCount:
                        (data["locations"][selectedLocation] ?? []).length,
                  )
                ],
              ),
            ],
          ),
        if (data.containsKey("items") && data["items"].isNotEmpty)
          Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final item = (data["items"] ?? [])[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: selected == "car"
                        ? AutomobileItem(
                            item: item,
                            direction: "horizontal",
                            wishlistAction: handleWishlistChanged,
                          )
                        : HotelItem(
                            item: item,
                            direction: "horizontal",
                            type: selected,
                            wishlistAction: handleWishlistChanged,
                          ),
                  );
                },
                itemCount: (data["items"] ?? []).length,
              ),
            ],
          ),
        const SizedBox(
          height: 30.0,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/hotel-filter",
                  arguments: jsonEncode({
                    "category": selected == "hotel" || selected == "deal"
                        ? "hotel"
                        : (selected == "shortlet" ? "apartment" : ""),
                    "type": selected
                  }));
            },
            child: Widgets.buildText("Load more", context,
                isMedium: true, color: "main.primary"))
      ],
    );
  }
}
