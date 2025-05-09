import 'dart:convert';

import 'package:afritas/globals/automobile_item.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/home_header.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AutomobileHome extends StatefulWidget {
  const AutomobileHome({Key? key}) : super(key: key);

  @override
  _AutomobileHomeState createState() => _AutomobileHomeState();
}

class _AutomobileHomeState extends State<AutomobileHome> {
  var selected = 0;
  var selectedFilter = "all";
  final Map<String, dynamic> data = {
    "brands": [
      {"name": "Toyota", "image": "assets/images/toyota.png", "id": "hotel"},
      {"name": "Benz", "image": "assets/images/benz.png", "id": "house"},
      {"name": "GMC", "image": "assets/images/gmc.png", "id": "villa"},
      {"name": "Ford", "image": "assets/images/ford.png", "id": "resorts"},
      {"name": "BMW", "image": "assets/images/bmw.png", "id": "bungalow"},
    ],
    "popularHireBrands": [
      {
        "name": "Auto Nation",
        "image": "assets/images/automobile-1.jpeg",
        "id": "hotel",
        "rating": 5
      },
      {
        "name": "Auto Brands",
        "image": "assets/images/automobile-2.jpeg",
        "id": "hotel",
        "rating": 4
      },
      {
        "name": "Auto Brands",
        "image": "assets/images/automobile-2.jpeg",
        "id": "hotel",
        "rating": 4
      },
      {
        "name": "Auto Brands",
        "image": "assets/images/automobile-2.jpeg",
        "id": "hotel",
        "rating": 4
      },
      {
        "name": "Auto Brands",
        "image": "assets/images/automobile-2.jpeg",
        "id": "hotel",
        "rating": 4
      },
    ],
    "locations": [
      {"name": "Lagos", "value": "lagos"},
      {"name": "Ajah", "value": "ajah"}
    ],
    "recentSearches": [
      {
        "name": "Mercedes Benz",
        "date": "15 - 18 Jan",
        "guest": "3 days",
        "image": "assets/images/automobile-1.jpeg"
      },
      {
        "name": "Mercedes Benz",
        "date": "15 - 18 Jan",
        "guest": "7 days",
        "image": "assets/images/automobile-1.jpeg"
      },
      {
        "name": "Mercedes Benz",
        "date": "15 - 18 Jan",
        "guest": "7 days",
        "image": "assets/images/automobile-1.jpeg"
      },
      {
        "name": "Mercedes Benz",
        "date": "15 - 18 Jan",
        "guest": "7 days",
        "image": "assets/images/automobile-1.jpeg"
      }
    ],
    "promotions": {"image": "auto-promotion.png"},
    "popular": [
      {
        "title": "4x4",
        "items": [
          {
            "title": "Land Rover",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "4x4"
          },
          {
            "title": "Land Rover",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "4x4"
          },
          {
            "title": "Land Rover",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "4x4"
          },
          {
            "title": "Land Rover",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "4x4"
          },
          {
            "title": "Land Rover",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "4x4"
          }
        ]
      },
      {
        "title": "Sedan",
        "items": [
          {
            "title": "Toyota Corolla",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "Sedan"
          },
          {
            "title": "Toyota Corolla",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "Sedan"
          },
          {
            "title": "Toyota Corolla",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "Sedan"
          },
          {
            "title": "Toyota Corolla",
            "listedBy": "Ola Alli",
            "price": "50000",
            "passengers": "6",
            "power": "Hybrid",
            "steering": "Automatic",
            "doors": "4",
            "image": "assets/images/automobile-1.jpeg",
            "favourite": "1",
            "listingId": "687128",
            "location": "3, Youngest Street",
            "type": "Sedan"
          }
        ]
      }
    ],
    "nearbyCars": [
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "rating": "4.3",
        "review": "120",
        "isNew": "1",
        "doors": "4",
        "images": [
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
        ],
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      },
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "doors": "4",
        "rating": "4.3",
        "review": "120",
        "isNew": "0",
        "image": "assets/images/automobile-1.jpeg",
        "images": [
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
        ],
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      },
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "doors": "4",
        "rating": "4.3",
        "review": "120",
        "isNew": "0",
        "image": "assets/images/automobile-1.jpeg",
        "images": [
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
        ],
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      },
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "doors": "4",
        "rating": "4.3",
        "review": "120",
        "isNew": "0",
        "image": "assets/images/automobile-1.jpeg",
        "images": [
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
          "assets/images/automobile-1.jpeg",
          "assets/images/automobile-2.jpeg",
        ],
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      }
    ],
    "featuredItems": [
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "doors": "4",
        "image": "assets/images/automobile-1.jpeg",
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      },
      {
        "title": "Land Rover",
        "listedBy": "Ola Alli",
        "price": "50000",
        "passengers": "6",
        "power": "Hybrid",
        "steering": "Automatic",
        "doors": "4",
        "image": "assets/images/automobile-1.jpeg",
        "favourite": "1",
        "listingId": "687128",
        "location": "3, Youngest Street"
      }
    ],
    "forHire": [
      {
        "type": "4x4",
        "image": "assets/images/automobile-1.jpeg",
        "cars": "1",
        "title": "4x4 for Hire"
      },
      {
        "type": "sedan",
        "image": "7376e8c82b3ab2a4df7a0f0989920d41.png",
        "cars": "1",
        "title": "Sedan"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final backgroundHeight = height * 0.25;
    final mainPaddingTop = backgroundHeight / 10;
    final popular = Helpers.flatten((data["popular"] ?? [])
        .where((item) =>
            item["title"].toString().toLowerCase() == selectedFilter ||
            selectedFilter == "all")
        .map((item) => [...(item["items"] ?? [])])
        .toList());
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: backgroundHeight,
            decoration: BoxDecoration(
              color: Palette.getColor(context, "main", "primary"),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/homebg-transparent.png',
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
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
                  HomeHeader(searchPage: '/automobile-search'),
                  SizedBox(
                    height: mainPaddingTop * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Brands", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/automobile-brands",
                                        arguments: jsonEncode(data["brands"]));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var category in (data["brands"] ?? []))
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/automobile-filter",
                                            arguments: jsonEncode({
                                              "brandName":
                                                  category["name"].toString(),
                                              "brandId":
                                                  category["id"].toString()
                                            }));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              color: Palette.getColor(context,
                                                  "background", "paper"),
                                              border: Border.all(
                                                color: Color(0x0d000000),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: FittedBox(
                                              child: Image.asset(
                                                  category["image"]),
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          FittedBox(
                                            child: Widgets.buildText(
                                                category["name"].toString(),
                                                context),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 230.0)),
                              child: Swiper(
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["featuredItems"] ?? [])[index];
                                  return Container(
                                    height: 180.0,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Palette.getColor(
                                            context, "background", "paper"),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            item["image"].toString(),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                  item["title"].toString(),
                                                  context,
                                                  isMedium: true,
                                                  color: "text.white"),
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
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Widgets.buildText(
                                              "Ads", context,
                                              size: 12.0,
                                              weight: 500,
                                              color: "text.white"),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: (data["featuredItems"] ?? []).length,
                                pagination: SwiperPagination(builder:
                                    SwiperCustomPagination(builder:
                                        (BuildContext context,
                                            SwiperPluginConfig config) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i < config.itemCount;
                                          i += 1)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 0.0),
                                          child: Container(
                                              width: config.activeIndex == i
                                                  ? 25
                                                  : 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: config.activeIndex == i
                                                      ? Palette.getColor(
                                                          context,
                                                          "main",
                                                          "primary")
                                                      : Color(0xffd9d9d9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                    ],
                                  );
                                })),
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Recent Search", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/hotel-search");
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 100.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["recentSearches"] ?? []).length,
                                    screenWidth,
                                    offset: 130.0),
                                itemHeight: 80.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["recentSearches"] ?? [])[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 110.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/hotel-filter",
                                            arguments: jsonEncode({
                                              "location":
                                                  item["name"].toString(),
                                              "startDate": "2025-01-15",
                                              "endDate": "2025-01-18",
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
                                            border: Border.all(
                                                color: Color(0x0d000000)),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                item["image"].toString(),
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Widgets.buildText(
                                                      item["name"].toString(),
                                                      context,
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
                                itemCount:
                                    (data["recentSearches"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText(
                                  "Popular car hire brands", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/automobile-recommended",
                                        arguments: jsonEncode(
                                            (data["popularHireBrands"] ?? [])));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 150.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final item =
                                    (data["popularHireBrands"] ?? [])[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/automobile-filter",
                                          arguments: jsonEncode({
                                            "vendor": item["name"].toString(),
                                          }));
                                    },
                                    child: Container(
                                      width: ((screenWidth - 50) / 2),
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color:
                                              Palette.get("background.paper"),
                                          border: Border.all(
                                              color: Color(0x0D000000))),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        spacing: 5.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.asset(
                                                  item["image"],
                                                  height: 100.0,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 5.0,
                                                right: 10.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Palette.get(
                                                        "background.paper"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    spacing: 2.0,
                                                    children: [
                                                      for (var i = 0;
                                                          i < 5;
                                                          i += 1)
                                                        Helpers.fetchIcons(
                                                            "star", "solid",
                                                            color: i <
                                                                    (num.tryParse(item["rating"].toString())
                                                                            ?.toInt() ??
                                                                        0)
                                                                ? "warning.main"
                                                                : "text.secondary",
                                                            size: 11.0)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Widgets.buildText(
                                              item["name"], context,
                                              size: 14.0)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  (data["popularHireBrands"] ?? []).length,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Nearby Cars", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/automobile-filter",
                                        arguments: jsonEncode({}));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 250.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["nearbyCars"] ?? []).length,
                                    screenWidth,
                                    offset: 80.0),
                                itemHeight: 250.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["nearbyCars"] ?? [])[index];
                                  return AutomobileItem(
                                    item: item,
                                    offset: 80.0,
                                    direction: "horizontal",
                                  );
                                },
                                itemCount: (data["nearbyCars"] ?? []).length,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  final item = index == 0
                                      ? {"title": "All"}
                                      : (data["popular"] ?? [])[index - 1];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedFilter = item["title"]
                                              .toString()
                                              .toLowerCase();
                                        });
                                      },
                                      child: Chip(
                                          backgroundColor: Palette.get(
                                              selectedFilter ==
                                                      item["title"]
                                                          .toString()
                                                          .toLowerCase()
                                                  ? "main.primary"
                                                  : "background.paper"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 10.0),
                                          label: Widgets.buildText(
                                              item["title"], context,
                                              weight: 500,
                                              size: 15.0,
                                              color: selectedFilter ==
                                                      item["title"]
                                                          .toString()
                                                          .toLowerCase()
                                                  ? "text.white"
                                                  : "text.secondary")),
                                    ),
                                  );
                                },
                                itemCount: (data["popular"] ?? []).length + 1),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = popular[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: AutomobileItem(item: item),
                              );
                            },
                            itemCount: popular.length,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Widgets.buildText("Load more", context,
                                  isMedium: true, color: "main.primary"))
                        ],
                      ),
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
}
