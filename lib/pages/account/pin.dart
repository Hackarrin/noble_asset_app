import 'dart:convert';

import 'package:afritas/globals/hotel_booking.dart';
import 'package:afritas/globals/hotel_item.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class TransactionPin extends StatefulWidget {
  const TransactionPin({Key? key}) : super(key: key);

  @override
  _TransactionPinState createState() => _TransactionPinState();
}

class _TransactionPinState extends State<TransactionPin>
    with SingleTickerProviderStateMixin {
  final menus = [
    {"name": "Change Transaction PIN", "page": "/change-pin"},
    {"name": "Forgot Transaction PIN", "page": "forgot-pin"},
    {"name": "Enable / Disable Transaction PIN", "page": "pin-enable"},
  ];
  var enablePin = true;

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
        title: Widgets.buildText("Manage PIN", context, isMedium: true),
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
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Color(0x1A000000))),
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
                              } else {
                                Sheets.forgotPin();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: index == 0
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Color(0x1A000000)))),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Widgets.buildText(
                                            item["name"].toString(), context,
                                            size: 14.0,
                                            weight: 400,
                                            color: "text.primary"),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                      ]),
                                  index == 2
                                      ? SizedBox(
                                          height: 30.0,
                                          child: FittedBox(
                                            child: Switch(
                                                inactiveTrackColor:
                                                    Color(0x80000000),
                                                inactiveThumbColor:
                                                    Palette.get("text.white"),
                                                value: enablePin,
                                                onChanged: (value) {
                                                  setState(() {
                                                    enablePin = value;
                                                  });
                                                }),
                                          ),
                                        )
                                      : Helpers.fetchIcons(
                                          "caret-right", "regular",
                                          size: 16.0),
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
