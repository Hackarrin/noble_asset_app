import 'dart:convert';

import 'package:cribsfinder/globals/automobile_item.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/globals/shortlet_item.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist>
    with SingleTickerProviderStateMixin {
  var selected = "";
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
  String sortBy = "desc";
  bool loading = true;
  bool isLoggedIn = true;
  List<dynamic> filteredWishlist = [];
  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getWishlist(
          search, status, filters, page, perPage, order, sortBy);
      setState(() {
        filteredWishlist = res["data"];
        loading = false;
      });
      if (filteredWishlist.isEmpty) {
        setState(() {
          error =
              "You have not added any items yet, but don't worry! Search and explore top listings on Cribsfinder.";
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
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
          child: isLoggedIn
              ? (loading
                  ? Shimmer.fromColors(
                      baseColor: Palette.get("background.neutral"),
                      highlightColor: Palette.get("background.default"),
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
              : Alert.showErrorMessage(context, "Login to view your wishlist",
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
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final item = loading ? bookings[index] : filteredWishlist[index];
          print("item $item");
          return Container(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
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
                    icon: Helpers.fetchIcons("trash", "regular", size: 30.0),
                    onTap: (CompletionHandler handler) async {
                      await handler(true);
                      filteredWishlist.removeAt(index);
                      Helpers.wishlist(item, item["type"].toString());
                      setState(() {});
                    },
                    color: Palette.get("warning.main")),
              ],
              child: item["type"].toString() == "0"
                  ? HotelItem(item: item, direction: "horizontal")
                  : (item["type"].toString() != "1"
                      ? AutomobileItem(item: item, direction: "horizontal")
                      : ShortletItem(item: item, direction: "horizontal")),
            ),
          );
        },
        itemCount: loading ? bookings.length : filteredWishlist.length,
      ),
    );
  }
}
