import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/pages/account/bookings.dart';
import 'package:cribsfinder/pages/account/profile.dart';
import 'package:cribsfinder/pages/account/wishlist.dart';
import 'package:cribsfinder/pages/attractions/home.dart';
import 'package:cribsfinder/pages/automobile/home.dart';
import 'package:cribsfinder/pages/cruise/home.dart';
import 'package:cribsfinder/pages/events/home.dart';
import 'package:cribsfinder/pages/hotels/home.dart';
import 'package:cribsfinder/pages/property/home.dart';
import 'package:cribsfinder/pages/shortlets/home.dart';
import 'package:cribsfinder/utils/bookings/attraction.dart';
import 'package:cribsfinder/utils/bookings/event.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../utils/palette.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selected = 0;
  var selectedInterface = "hotel";
  var isFabOpened = false;
  final menus = [
    {"name": "Home", "icon": "home"},
    {
      "name": "Bookings",
      "icon": "calendar-day",
    },
    {
      "name": "Wishlist",
      "icon": "wishlist-star",
    },
    {
      "name": "My account",
      "icon": "user",
    },
  ];
  Widget _getPage() {
    if (selected == 0) {
      // if (selectedInterface == "hotel") {
      //   return HotelHome();
      // } else if (selectedInterface == "shortlet") {
      //   return ShortletHome();
      // } else if (selectedInterface == "event") {
      //   return EventHome();
      // } else if (selectedInterface == "attraction") {
      //   return AttractionHome();
      // } else if (selectedInterface == "automobile") {
      //   return AutomobileHome();
      // } else if (selectedInterface == "boat") {
      //   return CruiseHome();
      // } else if (selectedInterface == "property") {
      //   return PropertyHome();
      // }
      return HotelHome();
    } else if (selected == 1) {
      return Bookings();
    } else if (selected == 2) {
      return Wishlist();
    } else if (selected == 3) {
      return Profile();
    }
    return HotelHome();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        final page = arguments.toString();
        setState(() {
          selected = num.tryParse(page)?.toInt() ?? 0;
        });
        _getPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (selected != 0) {
          setState(() {
            selected = 0;
          });
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Palette.getColor(context, "background", "default"),
        body: _getPage(),
        bottomNavigationBar: StylishBottomBar(
          option:
              AnimatedBarOptions(iconSize: 24.0, padding: EdgeInsets.all(10)),
          notchStyle: NotchStyle.circle,
          items: [
            for (var i = 0; i < menus.length; i += 1)
              BottomBarItem(
                icon: Helpers.fetchIcons(
                  menus[i]["icon"].toString(),
                  "regular",
                  color: "text.other",
                  size: 20.0,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Widgets.buildText(
                    menus[i]["name"].toString(),
                    context,
                    color: selected == i ? "main.primary" : "text.other",
                    isMedium: true,
                    size: 14.0,
                  ),
                ),
                selectedIcon: Helpers.fetchIcons(
                  menus[i]["icon"].toString(),
                  "solid",
                  size: 20.0,
                  color: "main.primary",
                ),
              ),
          ],
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
        ),
      ),
    );
  }
}
