import 'package:nobleassets/globals/hotel_booking.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Investments extends StatefulWidget {
  const Investments({Key? key}) : super(key: key);

  @override
  _InvestmentsState createState() => _InvestmentsState();
}

class _InvestmentsState extends State<Investments>
    with SingleTickerProviderStateMixin {
  var selected = "";
  int _selectedTab = 0;
  String error = "";
  String search = "";
  String status = "0";
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
  late TabController tabController;
  final savings = [
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
      "type": "",
      "status": 4
    },
  ];
  bool isLoggedIn = true;
  List<dynamic> filteredInvestments = [];
  void filter() {
    if (_selectedTab == 0) {
      // upcoming
      setState(() {
        status = "0";
      });
    } else if (_selectedTab == 1) {
      // completed
      setState(() {
        status = "4";
      });
    } else {
      // cancelled
      setState(() {
        status = "2";
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
      final res = await JWT.getBookings(
          search, status, filters, page, perPage, order, sortBy);
      setState(() {
        filteredInvestments = res["data"];
        loading = false;
      });
      if (filteredInvestments.isEmpty) {
        final stat = Defaults.bookingStatus
            .firstWhere((stat) => stat["value"].toString() == status);
        setState(() {
          error =
              "You don't have any ${stat["label"]?.toLowerCase()} savings yet, but don't worry! Search and explore top listings on Noble Assets.";
        });
      }
    } catch (err) {
      setState(() {
        error =
            "You don't have any investment yet, but don't worry! They'll show up here when you add them.";
        loading = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
        title: Widgets.buildText("My Investments", context, isMedium: true),
        actions: [],
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
                            Tab(text: "Active"),
                            Tab(text: "Matured"),
                            Tab(text: "Cancelled"),
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
              : Alert.showErrorMessage(context, "Login to view your savings",
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
      child: loading || filteredInvestments.isNotEmpty
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final item =
                    loading ? savings[index] : filteredInvestments[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: HotelBooking(
                    item: item,
                    action: () {
                      fetch();
                    },
                  ),
                );
              },
              itemCount: loading ? savings.length : filteredInvestments.length,
            )
          : Alert.showErrorMessage(context, "No Investments!",
              message: error, buttonText: "Explore"),
    );
  }
}
