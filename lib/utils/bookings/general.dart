import 'dart:convert';

import 'package:nobleassets/globals/attraction_item.dart';
import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilsModals {
  static Widget lockedActionButton(
      BuildContext context, String text, Function function,
      {double radius = 90.0}) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        width: screenWidth,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(radius)),
        height: 80.0,
        child: Row(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Palette.get("main.primary"),
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(15.0),
                child: Helpers.fetchIcons("lock", "regular",
                    size: 30.0, color: "text.white"),
              ),
              Row(
                spacing: 15.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Widgets.buildText(text, context,
                      color: "main.primary", isMedium: true),
                  Row(
                    spacing: 2.0,
                    children: [
                      Helpers.fetchIcons("angle-small-right", "solid",
                          color: "main.primary",
                          size: 20.0,
                          overrideColor: Color(0x4041B11A)),
                      Helpers.fetchIcons("angle-small-right", "solid",
                          color: "main.primary",
                          size: 20.0,
                          overrideColor: Color(0x8041B11A)),
                      Helpers.fetchIcons("angle-small-right", "solid",
                          color: "main.primary", size: 20.0),
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0x3341B11A),
                    borderRadius: BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(10.0),
                child: Helpers.fetchIcons("lock", "regular",
                    size: 30.0, color: "main.primary"),
              )
            ]),
      ),
    );
  }
}
