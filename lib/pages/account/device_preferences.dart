import 'dart:convert';

import 'package:cribsfinder/globals/hotel_booking.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class DevicePreferences extends StatefulWidget {
  const DevicePreferences({Key? key}) : super(key: key);

  @override
  _DevicePreferencesState createState() => _DevicePreferencesState();
}

class _DevicePreferencesState extends State<DevicePreferences>
    with SingleTickerProviderStateMixin {
  final menus = [
    {"name": "Language", "value": "English"},
    {"name": "Currency", "value": "Nigeria Naria(₦)"},
    {"name": "Rate Us", "value": ""},
  ];
  var enableBiometric = false;

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
        title: Widgets.buildText("Device Preferences", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = menus[index];
                          return GestureDetector(
                            onTap: () {
                              if (item["page"].toString().startsWith("/")) {
                                Navigator.pushNamed(
                                    context, item["page"].toString());
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.get("background.paper"),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Color(0x1A000000))),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Widgets.buildText(
                                      item["name"].toString(), context,
                                      size: 14.0,
                                      weight: 400,
                                      color: "text.primary"),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  index == 2
                                      ? Row(
                                          children: [
                                            for (var star = 0;
                                                star < 5;
                                                star += 1)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3.0),
                                                child: Helpers.fetchIcons(
                                                    "star", "solid",
                                                    size: 14,
                                                    color: "warning.main"),
                                              ),
                                          ],
                                        )
                                      : Widgets.buildText(
                                          item["value"].toString(), context,
                                          size: 14.0,
                                          weight: 400,
                                          color: "main.primary",
                                          isUnderlined: true),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: menus.length,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
