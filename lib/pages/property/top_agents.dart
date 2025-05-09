import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class PropertyTopAgents extends StatefulWidget {
  const PropertyTopAgents({Key? key}) : super(key: key);

  @override
  _PropertyTopAgentsState createState() => _PropertyTopAgentsState();
}

class _PropertyTopAgentsState extends State<PropertyTopAgents> {
  var selected = 0;
  var location = "";
  var sortBy = "relevance";
  var total = 12484;
  final _items = [
    {
      "name": "Ola Alli",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "John Doe",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Cribsfinder",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Smith",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Dante",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Smith",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Dante",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Smith",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Dante",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Smith",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Dante",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Smith",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
    {
      "name": "Dante",
      "image": "assets/images/avatar.png",
      "location": "Jegede Taiwo Ibeju lekki lagos Nig..."
    },
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
        title: Widgets.buildText("Top Estate Agents", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              Container(
                color: Palette.get("background.paper"),
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.0,
                  children: [
                    Widgets.buildText(
                        "Here are the top agents in Nigeria", context,
                        isMedium: true),
                    Widgets.buildText(
                        "Enter your location to view the most popular agents in your selected state.",
                        context,
                        lines: 10,
                        color: "text.secondary"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      spacing: 10.0,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: Widgets.inputDecoration("",
                                isOutline: true,
                                color: Palette.getColor(
                                    context, "background", "paper"),
                                borderColor: Color(0x1A000000),
                                hint: "Enter a state",
                                prefixIcon: UnconstrainedBox(
                                  child: Helpers.fetchIcons(
                                    "search",
                                    "regular",
                                    color: "main.primary",
                                    size: 20.0,
                                  ),
                                ),
                                hintColor:
                                    Palette.getColor(context, "text", "other"),
                                radius: 40.0,
                                isFilled: true,
                                isFloating: true),
                            style: TextStyle(
                                color: Palette.getColor(
                                    context, "text", "secondary"),
                                decoration: TextDecoration.none,
                                decorationThickness: 0),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Sheets.showCountry();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0x1A000000)),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Palette.get("background.paper")),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Row(
                                spacing: 5.0,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      "assets/images/NGN.png",
                                      width: 24.0,
                                      height: 24.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Widgets.buildText("NGN", context,
                                      color: "main.primary"),
                                ],
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200.0,
                        ),
                        for (var i = 2; i >= 0; i -= 1)
                          Align(
                            alignment: Alignment(
                                i == 0
                                    ? 0.0
                                    : i == 1
                                        ? -0.7
                                        : 0.7,
                                i == 0 ? 0.0 : 0.5),
                            child: Stack(
                              children: [
                                Column(
                                  spacing: 20.0,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(70.0),
                                          border: Border.all(
                                              width: 4.0,
                                              color:
                                                  Palette.get("main.primary"))),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: Image.asset(
                                          _items[i]["image"].toString(),
                                          width: i == 0 ? 120 : 90,
                                          height: i == 0 ? 120 : 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Widgets.buildText(
                                        _items[i]["name"].toString(), context,
                                        isMedium: true, size: 13.0)
                                  ],
                                ),
                                Positioned(
                                  bottom: 25.0,
                                  left: i == 0 ? 50.0 : 40.0,
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF41B11A),
                                              Color(0xFF61FF61)
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Center(
                                        child: Widgets.buildText(
                                            (i + 1).toString(), context,
                                            color: "text.white")),
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index + 2];
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
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            spacing: 10.0,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 10.0,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      item["image"].toString(),
                                      width: 40.0,
                                      height: 40.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 2.0,
                                    children: [
                                      Widgets.buildText(
                                          item["name"].toString(), context,
                                          isMedium: true),
                                      Row(
                                        spacing: 2.0,
                                        children: [
                                          Helpers.fetchIcons("marker", "solid",
                                              color: "main.primary"),
                                          Widgets.buildText(
                                              item["location"].toString(),
                                              context,
                                              color: "text.secondary")
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF41B11A),
                                          Color(0xFF61FF61)
                                        ]),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Center(
                                    child: Widgets.buildText(
                                        (index + 4).toString(), context,
                                        color: "text.white")),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _items.length - 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
