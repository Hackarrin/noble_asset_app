import 'dart:convert';

import 'package:nobleassets/globals/hotel_booking.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> with SingleTickerProviderStateMixin {
  final bookings = [
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "checkin": "2025-03-04 12:30:20",
      "checkout": "2025-04-04 12:30:20",
      "confirmationCode": "4378nd7343",
      "vendor": "Tayo Oladele",
      "adults": "10",
      "children": 10,
      "infants": 5,
      "dateAdded": "2025-03-03 11:00:00",
      "quantity": 5,
      "roomType": {},
      "type": "",
      "status": 4
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "checkin": "2025-03-04 12:30:20",
      "checkout": "2025-04-04 12:30:20",
      "confirmationCode": "4378nd7343",
      "vendor": "Tayo Oladele",
      "adults": "10",
      "children": 10,
      "infants": 5,
      "dateAdded": "2025-03-03 11:00:00",
      "quantity": 5,
      "roomType": {},
      "type": "",
      "status": 4
    },
  ];
  int _selectedTab = 0;
  String error = "";
  String search = "";
  String status = "";
  Map<String, dynamic> filters = {
    "listing": {},
    "dateFrom": "",
    "dateTo": "",
    "type": "all",
  };
  int page = 0;
  int perPage = 10;
  String order = "id";
  String sortBy = "reviewed";
  bool loading = true;
  bool isLoggedIn = true;
  List<dynamic> filteredWishlist = [];
  void filter() {
    if (_selectedTab == 0) {
      // upcoming
      setState(() {
        sortBy = "reviewed";
      });
    } else if (_selectedTab == 1) {
      // completed
      setState(() {
        sortBy = "vendor_reviews";
      });
    } else {
      // cancelled
      setState(() {
        sortBy = "pending";
      });
    }
    fetch();
  }

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getReviews(
          search, status, filters, page, perPage, order, sortBy);
      setState(() {
        filteredWishlist = res["data"];
        loading = false;
      });
      if (filteredWishlist.isEmpty) {
        setState(() {
          error =
              "You have not added any reviews here but don't worry, they'll show up here when they are available!";
        });
      }
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final userId = await Helpers.readPref(Defaults.userid);
      setState(() {
        isLoggedIn = userId.isNotEmpty;
      });
      if (isLoggedIn) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xfff1f1f1), width: 1),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(left: 15.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Helpers.fetchIcons(
                "arrow-small-left",
                "solid",
                size: 24,
                color: "text.other",
              )),
        ),
        title: Widgets.buildText("My Reviews", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: isLoggedIn
              ? DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.get("text.white"),
                        ),
                        child: TabBar(
                          labelStyle: GoogleFonts.nunito(
                              fontSize: 15.0, fontWeight: FontWeight.w500),
                          dividerColor: Colors.transparent,
                          indicatorWeight: 3.0,
                          dividerHeight: 2.0,
                          unselectedLabelColor: Palette.get("text.disabled"),
                          onTap: (index) {
                            setState(() {
                              _selectedTab = index;
                            });
                            filter();
                          },
                          tabs: [
                            Tab(text: "Your reviews"),
                            Tab(text: "Host's reviews"),
                            Tab(text: "Pending"),
                          ],
                        ),
                      ),
                      Expanded(
                          child: loading
                              ? Shimmer.fromColors(
                                  baseColor: Palette.get("background.neutral"),
                                  highlightColor:
                                      Palette.get("background.default"),
                                  loop: 1,
                                  child: AbsorbPointer(child: buildContent()),
                                )
                              : (error.isNotEmpty
                                  ? Alert.showErrorMessage(context, "",
                                      padding: 50.0,
                                      buttonText: "Retry",
                                      message: error,
                                      action: fetch)
                                  : buildContent()))
                    ],
                  ),
                )
              : Alert.showErrorMessage(context, "Login to view your bookings",
                  buttonText: "Login", action: () {
                  Navigator.pushNamed(context, "/login");
                }),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0, left: 0.0, right: 0.0, top: 20.0),
      child: loading || filteredWishlist.isNotEmpty
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final item =
                    loading ? bookings[index] : filteredWishlist[index];
                final dynamic roomType = item["roomType"] ?? {};
                print(
                    "dante ${"${Defaults.sectionsImagesUrl[Defaults.sectionsImagesUrl.keys.toList()[num.tryParse(item["type"].toString())?.toInt() ?? 0]]}${roomType["photo"]}"} $item");
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index + 1 == bookings.length ? 0 : 20.0,
                      left: 15.0,
                      right: 15.0),
                  child: Column(
                    spacing: 20.0,
                    children: [
                      Row(
                        spacing: 10.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Helpers.getPhoto(
                              roomType.containsKey("photo")
                                  ? roomType["photo"]
                                  : "",
                              isInitials: true,
                              type: Defaults.sectionsImagesUrl.keys.toList()[
                                  num.tryParse(item["type"].toString())
                                          ?.toInt() ??
                                      0],
                              width: 50.0,
                              height: 50.0,
                              radius: 50.0,
                              text: roomType["title"].toString()),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Widgets.buildText(
                                        roomType["title"].toString(),
                                        isMedium: true,
                                        size: 14.0,
                                        context),
                                    Container(
                                      width: item.containsKey("rating") &&
                                              item["rating"]
                                                  .toString()
                                                  .isNotEmpty
                                          ? 35.0
                                          : null,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                          color: item.containsKey("rating") &&
                                                  item["rating"]
                                                      .toString()
                                                      .isNotEmpty
                                              ? Palette.get("main.primary")
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Center(
                                        child: Widgets.buildText(
                                            item.containsKey("rating") &&
                                                    item["rating"]
                                                        .toString()
                                                        .isNotEmpty
                                                ? item["rating"].toString()
                                                : "Pending Review",
                                            context,
                                            size: item.containsKey("rating") &&
                                                    item["rating"]
                                                        .toString()
                                                        .isNotEmpty
                                                ? 15.0
                                                : 12.0,
                                            isBold: true,
                                            color: item.containsKey("rating") &&
                                                    item["rating"]
                                                        .toString()
                                                        .isNotEmpty
                                                ? "text.white"
                                                : "text.secondary",
                                            isCenter: true),
                                      ),
                                    )
                                  ],
                                ),
                                FittedBox(
                                  child: Row(
                                    spacing: 3,
                                    children: [
                                      Row(
                                        spacing: 2.0,
                                        children: [
                                          Widgets.buildText(
                                              "${Helpers.dateDiff(item["checkin"].toString(), item["checkout"].toString())} day${Helpers.dateDiff(item["checkin"].toString(), item["checkout"].toString()) > 1 ? "s" : ""}",
                                              context,
                                              size: 12.0)
                                        ],
                                      ),
                                      Widgets.buildText("•", context,
                                          color: "text.disabled"),
                                      Widgets.buildText(
                                          item.containsKey("checkin")
                                              ? Helpers.formatDistanceDate(
                                                  item["checkin"].toString(),
                                                  item["checkout"].toString())
                                              : "",
                                          context,
                                          size: 12.0),
                                    ],
                                  ),
                                ),
                                if (item["review"].toString().isNotEmpty)
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                if (item["review"].toString().isNotEmpty)
                                  Row(
                                    spacing: 10.0,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Widgets.buildText(
                                              "Your review:", context,
                                              isMedium: true, size: 14.0),
                                        ],
                                      ),
                                      Expanded(
                                        child: Widgets.buildText(
                                            item["review"].toString(), context,
                                            size: 13.0, isRight: true),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                if (item.containsKey("vendorReview") &&
                                    item["vendorReview"].toString().isNotEmpty)
                                  Column(
                                    spacing: 5.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        spacing: 10.0,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText(
                                              "Host's review:", context,
                                              isMedium: true, size: 14.0),
                                          Expanded(
                                            child: Widgets.buildText(
                                                item["vendorReview"].toString(),
                                                context,
                                                size: 13.0,
                                                isRight: true),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 20.0,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/booking",
                                                arguments: jsonEncode({
                                                  "bookingId": item["bookingId"]
                                                      .toString()
                                                }));
                                          },
                                          style: Widgets.buildButton(context,
                                              background:
                                                  Palette.get("main.secondary"),
                                              horizontal: 5.0,
                                              radius: 20.0,
                                              vertical: 0.0),
                                          child: Widgets.buildText(
                                              "View booking", context,
                                              color: "text.white",
                                              size: 13.0,
                                              isMedium: true)),
                                    ),
                                    if ((num.tryParse(item["rating"].toString())
                                                ?.toInt() ??
                                            0) ==
                                        0)
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () async {
                                              final res =
                                                  await Sheets.reviewBooking(
                                                      item);
                                              if (res) {
                                                fetch();
                                              }
                                            },
                                            style: Widgets.buildButton(context,
                                                background:
                                                    Palette.get("main.primary"),
                                                horizontal: 5.0,
                                                radius: 20.0,
                                                vertical: 0.0),
                                            child: Widgets.buildText(
                                                "Write a review", context,
                                                color: "text.white",
                                                size: 13.0,
                                                isMedium: true)),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (index < filteredWishlist.length)
                        SizedBox(
                          height: 1.0,
                          child:
                              Divider(thickness: 1.0, color: Color(0x14000000)),
                        ),
                    ],
                  ),
                );
              },
              itemCount: loading ? bookings.length : filteredWishlist.length,
            )
          : Alert.showErrorMessage(context, "No Reviews!",
              message: error, buttonText: "Explore"),
    );
  }
}
