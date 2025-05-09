import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/palette.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  var selected = false;
  var isDone = false;
  var currentPosition = 0;
  final SwiperController controller = SwiperController();

  final List<Map<String, dynamic>> slideshows = [
    {
      "image": "started-0.png",
      "title": ["All-in-One ", "Booking", " Platform"],
      "subtitle":
          "Book hotels, shortlets, cars, events, and more—all in one convenient app."
    },
    {
      "image": "started-1.png",
      "title": ["Seamless ", "Booking ", "and ", "Management"],
      "subtitle":
          "Easily book and manage everything in one place, from accommodations to unforgettable experiences"
    },
    {
      "image": "started-1.png",
      "title": ["Trust and security with ", "Cribsfinder"],
      "subtitle":
          "Your safety and satisfaction are our priority. Verified vendors, secure payments, and 24/7 support."
    },
    {
      "image": "started-1.png",
      "title": ["Cribsfinder Wallet ", "Your Smart Payment", " Solution"],
      "subtitle":
          "Send payments, create invoices, transfer funds, and receive money—all in one place."
    },
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: Palette.getColor(context, "background", "default"),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: Widgets.buildText("Skip", context,
                            color: "main.primary")),
                    Expanded(
                      child: Swiper(
                        controller: controller,
                        outer: true,
                        loop: false,
                        itemBuilder: (BuildContext context, int index) {
                          final item = slideshows[index];
                          return Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image.asset(
                                          "assets/images/${item["image"]}",
                                          height: screenHeight,
                                          width: screenWidth,
                                          fit: BoxFit.contain),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.paper"),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.elliptical(
                                                      100.0, 60.0),
                                                  topRight: Radius.elliptical(
                                                      100.0, 60.0))),
                                          padding: const EdgeInsets.only(
                                              top: 50.0,
                                              left: 15.0,
                                              right: 15.0,
                                              bottom: 30.0),
                                          child: Column(
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.center,
                                                runAlignment:
                                                    WrapAlignment.center,
                                                children: [
                                                  for (var i = 0;
                                                      i < item["title"].length;
                                                      i += 1)
                                                    Widgets.buildText(
                                                        item["title"][i]
                                                            .toString(),
                                                        context,
                                                        isMedium: true,
                                                        size: 24.0,
                                                        weight: 500,
                                                        color: i % 2 == 0
                                                            ? (index != 3
                                                                ? "text.primary"
                                                                : "main.primary")
                                                            : (index != 3
                                                                ? "main.primary"
                                                                : "text.primary")),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Widgets.buildText(
                                                  item["subtitle"].toString(),
                                                  context,
                                                  lines: 10,
                                                  size: 16.0,
                                                  isCenter: true,
                                                  color: "text.secondary"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        onIndexChanged: (index) {
                          setState(() {
                            currentPosition = index;
                          });
                        },
                        itemCount: slideshows.length,
                        pagination: SwiperPagination(
                            margin: const EdgeInsets.all(0),
                            builder: SwiperCustomPagination(builder:
                                (BuildContext context,
                                    SwiperPluginConfig config) {
                              return Container(
                                color: Palette.get("background.paper"),
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 40.0,
                                    bottom: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.previous();
                                      },
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border: Border.all(
                                              color:
                                                  Palette.get("main.primary")),
                                        ),
                                        child: UnconstrainedBox(
                                          child: Helpers.fetchIcons(
                                              "arrow-small-left", "solid",
                                              color: "main.primary",
                                              size: 24.0),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < config.itemCount;
                                            i += 1)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 0.0),
                                            child: Container(
                                                width: config.activeIndex == i
                                                    ? 25
                                                    : 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    color:
                                                        config.activeIndex == i
                                                            ? Palette.getColor(
                                                                context,
                                                                "main",
                                                                "primary")
                                                            : Color(0xffd9d9d9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0))),
                                          ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (currentPosition == 3) {
                                          Navigator.pushNamed(
                                              context, "/signup");
                                        } else {
                                          controller.next();
                                        }
                                      },
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Palette.get("main.primary"),
                                        ),
                                        child: UnconstrainedBox(
                                          child: Helpers.fetchIcons(
                                              "arrow-small-right", "solid",
                                              color: "text.white", size: 24.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                      ),
                    ),
                  ],
                ))));
  }
}
