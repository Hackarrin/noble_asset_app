import 'dart:convert';

import 'package:afritas/globals/hotel_item.dart';
import 'package:afritas/pages/account/bookings.dart';
import 'package:afritas/pages/account/profile.dart';
import 'package:afritas/pages/account/wishlist.dart';
import 'package:afritas/pages/attractions/home.dart';
import 'package:afritas/pages/automobile/home.dart';
import 'package:afritas/pages/cruise/home.dart';
import 'package:afritas/pages/events/home.dart';
import 'package:afritas/pages/hotels/home.dart';
import 'package:afritas/pages/property/home.dart';
import 'package:afritas/pages/shortlets/home.dart';
import 'package:afritas/utils/bookings/attraction.dart';
import 'package:afritas/utils/bookings/event.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
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
      "icon": "book-alt",
    },
    {
      "name": "Wishlist",
      "icon": "wishlist-heart",
    },
    {
      "name": "Profile",
      "icon": "user",
    },
  ];
  Widget _getPage() {
    if (selected == 0) {
      if (selectedInterface == "hotel") {
        return HotelHome();
      } else if (selectedInterface == "shortlet") {
        return ShortletHome();
      } else if (selectedInterface == "event") {
        return EventHome();
      } else if (selectedInterface == "attraction") {
        return AttractionHome();
      } else if (selectedInterface == "automobile") {
        return AutomobileHome();
      } else if (selectedInterface == "boat") {
        return CruiseHome();
      } else if (selectedInterface == "property") {
        return PropertyHome();
      }
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
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      body: _getPage(),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(iconSize: 24.0, padding: EdgeInsets.all(10)),
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
                child: Widgets.buildText(menus[i]["name"].toString(), context,
                    color: selected == i ? "main.primary" : "text.other",
                    weight: 500),
              ),
              selectedIcon: Helpers.fetchIcons(
                menus[i]["icon"].toString(),
                "solid",
                size: 20.0,
                color: "main.primary",
              ),
            ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Sheets.showFabMenu(selected: selectedInterface);
          if (res.startsWith("/")) {
            Navigator.pushNamed(context, res);
          } else if (Defaults.businesses.contains(res)) {
            if (res == "event") {
              await EventModals.selectCategories();
            }
            if (res == "attraction") {
              await AttractionModals.selectCategories();
            }
            setState(() {
              selectedInterface = res;
            });
          }
        },
        backgroundColor:
            Palette.get(isFabOpened ? "text.white" : "main.primary"),
        shape: const CircleBorder(),
        child: Helpers.fetchIcons(
          isFabOpened ? "cross" : "apps-add",
          "regular",
          color: isFabOpened ? "text.primary" : "text.white",
          size: 24.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
