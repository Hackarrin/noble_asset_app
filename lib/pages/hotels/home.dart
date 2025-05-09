import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/home_header.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../utils/palette.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({Key? key}) : super(key: key);

  @override
  _HotelHomeState createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  var selected = 0;
  final data = {
    "categories": [
      {"name": "Hotels", "image": "hotels.png", "id": "hotel"},
      {"name": "Shortlets", "image": "house.png", "id": "house"},
      {"name": "Cars", "image": "villa.png", "id": "villa"},
      {"name": "Deals", "image": "resorts.png", "id": "resorts"},
    ],
    "featuredItems": [
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
    "recommendedHotels": [
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
    "nearbyHotels": [
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
    "topDestinations": [
      {
        "location": "Ado Ekiti",
        "hotels": 149938,
        "image": "assets/images/destinations.jpeg"
      },
      {
        "location": "Ado Ekiti",
        "hotels": 149938,
        "image": "assets/images/destinations.jpeg"
      },
      {
        "location": "Ado Ekiti",
        "hotels": 149938,
        "image": "assets/images/destinations.jpeg"
      },
      {
        "location": "Ado Ekiti",
        "hotels": 149938,
        "image": "assets/images/destinations.jpeg"
      },
      {
        "location": "Ado Ekiti",
        "hotels": 149938,
        "image": "assets/images/destinations.jpeg"
      },
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
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: backgroundHeight,
            decoration: BoxDecoration(
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
                  HomeHeader(searchPage: "/hotel-search"),
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
                              Widgets.buildText("Categories", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/hotel-categories",
                                        arguments:
                                            jsonEncode(data["categories"]));
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
                              for (var category in data["categories"] ?? [])
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/hotel-filter",
                                            arguments: jsonEncode({
                                              "categoryName":
                                                  category["name"].toString(),
                                              "categoryId":
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
                                                  "assets/images/${category["image"]}"),
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
                              Widgets.buildText("Our top stays", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/hotel-recommended",
                                        arguments: jsonEncode(
                                            (data["recommendedHotels"] ?? [])));
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
                                  Size(screenWidth, 365.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["recommendedHotels"] ?? []).length,
                                    screenWidth,
                                    offset: 120.0),
                                itemHeight: 365.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["recommendedHotels"] ?? [])[index];
                                  return HotelItem(item: item, offset: 100.0);
                                },
                                itemCount:
                                    (data["recommendedHotels"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Nearby Hotels", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/hotel-nearby",
                                        arguments: jsonEncode(
                                            (data["nearbyHotels"] ?? [])));
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
                              final item = (data["nearbyHotels"] ?? [])[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: HotelItem(
                                    item: item, direction: "horizontal"),
                              );
                            },
                            itemCount: (data["nearbyHotels"] ?? []).length,
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText(
                                  "Your home in popular locations", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, "/hotel-destinations"),
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 190.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["topDestinations"] ?? []).length,
                                    screenWidth,
                                    offset: 180.0),
                                itemHeight: 190.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["topDestinations"] ?? [])[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 160.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, "/hotel-destinations",
                                          arguments:
                                              item["location"].toString()),
                                      child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 5.0),
                                          decoration: BoxDecoration(
                                            color: Palette.getColor(
                                                context, "background", "paper"),
                                            border: Border.all(
                                                color: Color(0x0d000000)),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomRight,
                                                          stops: [
                                                        0.1,
                                                        0.9
                                                      ],
                                                          colors: [
                                                        Colors.black
                                                            .withAlpha(204),
                                                        Colors.black
                                                            .withAlpha(26)
                                                      ])),
                                                  child: Image.asset(
                                                    item["image"].toString(),
                                                    height: 190,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, bottom: 5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Widgets.buildText(
                                                        item["location"]
                                                            .toString(),
                                                        context,
                                                        isMedium: true,
                                                        color: "text.white"),
                                                    Widgets.buildText(
                                                        "${Helpers.formatNumber(item["hotels"].toString())} properties",
                                                        context,
                                                        color: "text.white")
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["topDestinations"] ?? []).length,
                              )),
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
                                child: HotelItem(item: item),
                              );
                            },
                            itemCount: (data["items"] ?? []).length,
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
