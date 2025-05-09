import 'dart:convert';

import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AutomobileSearch extends StatefulWidget {
  const AutomobileSearch({Key? key}) : super(key: key);

  @override
  _AutomobileSearchState createState() => _AutomobileSearchState();
}

class _AutomobileSearchState extends State<AutomobileSearch> {
  var selected = 0;
  final data = [
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
    {"location": "Lagos", "date": "14 - 15 Jan", "duration": "7"},
  ];

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
              hint: "Where are you going to?",
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
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: 100.0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 20.0, left: 0.0, right: 0.0, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Widgets.buildText("Recent Searches", context,
                    isMedium: true),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final item = data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/automobile-filter",
                            arguments: jsonEncode(
                                {"location": item["location"].toString()}));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 15.0, right: 15.0),
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Palette.getColor(
                                  context, "background", "paper"),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: Palette.getColor(
                                          context, "background", "neutral"),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Helpers.fetchIcons(
                                    "location-arrow",
                                    "regular",
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Widgets.buildText(
                                        item["location"].toString(), context,
                                        weight: 400, size: 16.0),
                                    Widgets.buildText(
                                        "${Helpers.formatNumber(item["date"].toString())}, ${item["duration"]} days",
                                        context,
                                        color: "text.secondary")
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
