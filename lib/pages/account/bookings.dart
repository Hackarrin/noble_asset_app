import 'dart:convert';

import 'package:cribsfinder/globals/hotel_booking.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>
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
  List<Map<String, dynamic>> filteredBookings = [];
  void filter() {
    if (_selectedTab == 0) {
      // upcoming
      setState(() {
        filteredBookings = bookings
            .where((item) =>
                item["status"].toString() == "0" ||
                item["status"].toString() == "1")
            .toList();
      });
    } else if (_selectedTab == 1) {
      // completed
      setState(() {
        filteredBookings =
            bookings.where((item) => item["status"].toString() == "4").toList();
      });
    } else {
      // cancelled
      setState(() {
        filteredBookings =
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
        title: Widgets.buildText("My Bookings", context, isMedium: true),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
                style: Widgets.buildButton(context,
                    radius: 50.0, sideColor: Color(0xFFF1F1F1)),
                icon: Helpers.fetchIcons("comment-alt", "solid",
                    color: "text.black", size: 16.0)),
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
          child: DefaultTabController(
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
                      Tab(text: "Upcoming"),
                      Tab(text: "Completed"),
                      Tab(text: "Cancelled"),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 0.0, right: 0.0, top: 20.0),
                    child: filteredBookings.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              final item = filteredBookings[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: Column(
                                  children: [
                                    if (index > 0)
                                      SizedBox(
                                        width: 25.0,
                                        height: 40.0,
                                        child: VerticalDivider(
                                            thickness: 1.0,
                                            color: Color(0x14000000)),
                                      ),
                                    HotelBooking(item: item),
                                  ],
                                ),
                              );
                            },
                            itemCount: filteredBookings.length,
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/event.gif",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 30.0),
                                Widgets.buildText("No Bookings Yet", context,
                                    size: 24.0, weight: 500),
                                const SizedBox(height: 5.0),
                                Widgets.buildText(
                                    "You haven't made any bookings yet, but don't worry! Search and explore top listings on Cribsfinder to find the perfect stay.",
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
                                          background:
                                              Palette.get("main.primary"),
                                          vertical: 15.0,
                                          radius: 50.0),
                                      onPressed: () {},
                                      child: Widgets.buildText(
                                          "Explore", context,
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
      ),
    );
  }
}
