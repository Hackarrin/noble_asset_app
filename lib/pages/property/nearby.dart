import 'dart:convert';

import 'package:nobleassets/globals/hotel_item.dart';
import 'package:nobleassets/globals/property_item.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class PropertyNearby extends StatefulWidget {
  const PropertyNearby({Key? key}) : super(key: key);

  @override
  _PropertyNearbyState createState() => _PropertyNearbyState();
}

class _PropertyNearbyState extends State<PropertyNearby> {
  var selected = "";
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
        title: Widgets.buildText("Nearby Properties", context, isMedium: true),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Defaults.propertyCategories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final category = Defaults.propertyCategories[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = category["value"].toString();
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              color: Palette.get(
                                  selected == category["value"].toString()
                                      ? "main.primary"
                                      : "background.paper"),
                              border: Border.all(
                                color: Color(0x0D000000),
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Row(
                              spacing: 10.0,
                              children: [
                                if (category["icon"].toString().contains("/"))
                                  FittedBox(
                                    child: Image.asset(
                                      category["icon"].toString(),
                                      width: 30.0,
                                      height: 30.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (!category["icon"].toString().contains("/"))
                                  FittedBox(
                                    child: Helpers.fetchIcons(
                                        category["icon"].toString(), "solid",
                                        size: 30.0,
                                        color: selected ==
                                                category["value"].toString()
                                            ? "text.white"
                                            : "text.primary"),
                                  ),
                                FittedBox(
                                  child: Widgets.buildText(
                                      category["name"].toString(), context,
                                      isMedium: true,
                                      color: selected ==
                                              category["value"].toString()
                                          ? "text.white"
                                          : "text.primary",
                                      size: 13.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                GridView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 290.0),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    return PropertyItem(
                      item: item,
                      direction: "horizontal",
                    );
                  },
                  itemCount: _items.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
