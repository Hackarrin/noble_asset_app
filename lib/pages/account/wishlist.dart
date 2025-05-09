import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../utils/palette.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist>
    with SingleTickerProviderStateMixin {
  var selected = "";
  int _selectedTab = 0;
  late TabController tabController;
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
      "roomType": "Deluxe Room",
      "type": "",
      "status": 1
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
      "roomType": "Deluxe Room",
      "type": "",
      "status": 2
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
      "roomType": "Deluxe Room",
      "type": "",
      "status": 0
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
      "roomType": "Deluxe Room",
      "type": "",
      "status": 1
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
      "roomType": "Deluxe Room",
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
      "roomType": "Deluxe Room",
      "type": "",
      "status": 0
    },
  ];
  List<Map<String, dynamic>> filteredWishlist = [];
  void filter() {
    if (_selectedTab == 0) {
      // upcoming
      setState(() {
        filteredWishlist = bookings
            .where((item) =>
                item["status"].toString() == "0" ||
                item["status"].toString() == "1")
            .toList();
      });
    } else if (_selectedTab == 1) {
      // completed
      setState(() {
        filteredWishlist =
            bookings.where((item) => item["status"].toString() == "4").toList();
      });
    } else {
      // cancelled
      setState(() {
        filteredWishlist =
            bookings.where((item) => item["status"].toString() == "2").toList();
      });
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: selected.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff1f1f1), width: 1),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(left: 15.0),
                child: IconButton(
                    onPressed: () {
                      if (selected.isNotEmpty) {
                        setState(() {
                          selected = "";
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Helpers.fetchIcons(
                      "arrow-small-left",
                      "solid",
                      size: 24,
                      color: "text.other",
                    )),
              )
            : null,
        title: Widgets.buildText("My Wishlist", context, isMedium: true),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                style: Widgets.buildButton(context,
                    radius: 50.0, sideColor: Color(0xFFF1F1F1)),
                icon: Helpers.fetchIcons("plus-small", "solid",
                    color: "text.disabled", size: 20.0)),
          )
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selected.isNotEmpty && filteredWishlist.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.get("text.white"),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Palette.getColor(
                                context, "background", "paper"),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Widgets.buildText("Listings", context,
                                        weight: 400, size: 16.0),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Helpers.fetchIcons("heart", "solid",
                                            color: "error.main", size: 16.0),
                                        const SizedBox(width: 10.0),
                                        Widgets.buildText(
                                            "10 listings", context,
                                            lines: 3, color: "text.disabled"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Container(
                                width: 45.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(25.0)),
                                padding: EdgeInsets.all(10.0),
                                child: Helpers.fetchIcons(
                                    "land-layer-location", "regular",
                                    size: 16, color: "text.white"),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.0, left: 0.0, right: 0.0, top: 20.0),
                  child: bookings.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            final item = bookings[index];
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: SwipeActionCell(
                                key: ObjectKey(item),
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      title: "",
                                      backgroundRadius: 10.0,
                                      widthSpace: 100,
                                      performsFirstActionWithFullSwipe: true,
                                      forceAlignmentToBoundary: true,
                                      icon: Helpers.fetchIcons(
                                          "trash", "regular",
                                          size: 30.0),
                                      onTap: (CompletionHandler handler) async {
                                        await handler(true);
                                        filteredWishlist.removeAt(index);
                                        setState(() {});
                                      },
                                      color: Palette.get("warning.main")),
                                ],
                                child: HotelItem(
                                    item: item, direction: "horizontal"),
                              ),
                            );
                          },
                          itemCount: bookings.length,
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/events.gif",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 30.0),
                              Widgets.buildText("Start your list", context,
                                  size: 24.0, weight: 500),
                              const SizedBox(height: 5.0),
                              Widgets.buildText(
                                  "When you find a listing you like, tap the heart icon to save it here.",
                                  lines: 4,
                                  context,
                                  isCenter: true,
                                  color: "text.secondary",
                                  size: 13.0,
                                  weight: 400),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    style: Widgets.buildButton(context,
                                        background: Palette.get("main.primary"),
                                        vertical: 15.0,
                                        radius: 50.0),
                                    onPressed: () {},
                                    child: Widgets.buildText("Explore", context,
                                        color: "text.white", isMedium: true)),
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
  }
}
