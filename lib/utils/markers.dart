import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

class HotelMarker extends StatelessWidget {
  const HotelMarker({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(250.0, 140.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: double.infinity,
            height: 120.0,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            margin: const EdgeInsets.only(
                bottom: 6.0), //Same as `blurRadius` i guess
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Palette.getColor(context, "background", "paper"),
                borderRadius: BorderRadius.circular(100.0),
                border: Border(
                    bottom: BorderSide(
                        color: Palette.getColor(context, "main", "primary")))),
            child: Center(
              child: FittedBox(
                child: Widgets.buildText(text, context,
                    isMedium: true, color: "text.secondary", size: 55.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HotelSingleMarker extends StatelessWidget {
  const HotelSingleMarker({
    super.key,
    required this.icon,
  });
  final String icon;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(300.0, 300.0)),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0x66000000),
            borderRadius: BorderRadius.circular(300.0)),
        child: Center(
          child: Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0)),
            child: Center(
              child: Helpers.fetchIcons(icon, "solid",
                  color: "text.primary", size: 60.0),
            ),
          ),
        ),
      ),
    );
  }
}

class EventMarker extends StatelessWidget {
  const EventMarker({
    super.key,
    required this.text,
    required this.photo,
  });
  final String text;
  final String photo;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(250.0, 280.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120.0),
                    border: Border.all(color: Palette.get("main.primary"))),
                child: ClipOval(
                  child: Image.asset(photo,
                      width: 120.0, height: 120.0, fit: BoxFit.cover),
                )),
            const SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: double.infinity,
                height: 70.0,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                margin: const EdgeInsets.only(
                    bottom: 6.0), //Same as `blurRadius` i guess
                decoration: BoxDecoration(
                    color: Palette.getColor(context, "background", "paper"),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border(
                        bottom: BorderSide(
                            color:
                                Palette.getColor(context, "main", "primary")))),
                child: Center(
                  child: FittedBox(
                    child: Widgets.buildText(text, context,
                        isMedium: true, color: "text.secondary", size: 35.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
