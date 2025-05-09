import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class HotelNearby extends StatefulWidget {
  const HotelNearby({Key? key}) : super(key: key);

  @override
  _HotelNearbyState createState() => _HotelNearbyState();
}

class _HotelNearbyState extends State<HotelNearby> {
  var selected = 0;
  var _items = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final items = jsonDecode(arguments.toString());
          setState(() {
            _items = items;
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
        title: Widgets.buildText("Nearby Hotels", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: 60.0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding:
              EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
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
                  child: HotelItem(item: item),
                ),
              );
            },
            itemCount: _items.length,
          ),
        ),
      ),
    );
  }
}
