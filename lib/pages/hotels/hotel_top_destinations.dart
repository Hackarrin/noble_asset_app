import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class HotelTopDestinations extends StatefulWidget {
  const HotelTopDestinations({Key? key}) : super(key: key);

  @override
  _HotelTopDestinationsState createState() => _HotelTopDestinationsState();
}

class _HotelTopDestinationsState extends State<HotelTopDestinations> {
  var selected = 0;
  var location = "";
  var sortBy = "relevance";
  var total = 12484;
  final _items = [
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
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final item = arguments.toString();
          setState(() {
            location = item;
          });
        } catch (err) {
          print("dante - $err");
        }
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
        title: TextField(
          decoration: Widgets.inputDecoration("",
              isOutline: true,
              color: Palette.getColor(context, "background", "textfield"),
              borderColor: Palette.getColor(context, "background", "paper"),
              hint: "Search state  / country",
              prefixIcon: UnconstrainedBox(
                child: Helpers.fetchIcons(
                  "search",
                  "regular",
                  color: "main.primary",
                  size: 20.0,
                ),
              ),
              hintColor: Palette.getColor(context, "text", "other"),
              radius: 40.0,
              isFilled: true,
              isFloating: true),
          style: TextStyle(
              color: Palette.getColor(context, "text", "secondary"),
              decoration: TextDecoration.none,
              decorationThickness: 0),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xfff1f1f1), width: 1),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 15.0),
            child: IconButton(
                onPressed: () async {
                  final res = await Sheets.showSortBy(sortBy);
                  setState(() {
                    sortBy = res;
                  });
                },
                icon: Helpers.fetchIcons(
                  "sort-amount-down-alt",
                  "solid",
                  size: 16,
                  color: "text.other",
                )),
          )
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: 100.0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding:
              EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Widgets.buildText(
                      location.isEmpty ? "All locations" : location, context,
                      isMedium: true),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText(
                      "(${Helpers.formatNumber(total.toString())} propert${total > 1 ? "ies" : "y"})",
                      context,
                      isMedium: true,
                      color: "main.primary"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/hotel-filter",
                              arguments: jsonEncode({
                                "categoryName": item["name"].toString(),
                                "categoryId": item["id"].toString()
                              }));
                        },
                        child: HotelItem(item: item, direction: "horizontal"),
                      ),
                    );
                  },
                  itemCount: _items.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
