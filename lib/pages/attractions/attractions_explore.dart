import 'dart:convert';

import 'package:cribsfinder/globals/attraction_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AttractionExplore extends StatefulWidget {
  const AttractionExplore({Key? key}) : super(key: key);

  @override
  _AttractionExploreState createState() => _AttractionExploreState();
}

class _AttractionExploreState extends State<AttractionExplore> {
  var selected = 0;
  var _items = [];
  var title = "";
  var sortBy = "relevance";
  var selectedCountry = "";
  final data = [
    {
      "title": "Lekki Conservation Center",
      "category": "arts-culture",
      "location": "Lagos",
      "image": "assets/images/attraction-1.jpeg",
      "listingId": "473307",
      "price": "12000",
      "rating": "2.5",
      "reviews": "200",
      "favourite": "0",
      "duration": "9:00 AM - 6:00PM",
      "genre": [
        {
          "name": "Davido 001",
          "categories": ["R & B", "Afro Beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        }
      ],
      "host": "Ola Alli"
    },
    {
      "title": "Lekki Conservation Center",
      "category": "arts-culture",
      "location": "Lagos",
      "image": "assets/images/attraction-2.jpeg",
      "listingId": "473307",
      "price": "12000",
      "rating": "2.5",
      "genre": [
        {
          "name": "Davido 001",
          "categories": ["R & B", "Afro Beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        }
      ],
      "reviews": "200",
      "favourite": "0",
      "host": "Ola Alli",
      "duration": "9:00 AM - 6:00PM",
    },
    {
      "title": "Lekki Conservation Center",
      "category": "arts-culture",
      "location": "Lagos",
      "image": "assets/images/attraction-1.jpeg",
      "listingId": "473307",
      "price": "12000",
      "rating": "2.5",
      "reviews": "200",
      "favourite": "0",
      "duration": "9:00 AM - 6:00PM",
      "genre": [
        {
          "name": "Davido 001",
          "categories": ["R & B", "Afro Beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        }
      ],
      "host": "Ola Alli"
    },
    {
      "title": "Lekki Conservation Center",
      "category": "arts-culture",
      "location": "Lagos",
      "image": "assets/images/attraction-2.jpeg",
      "listingId": "473307",
      "price": "12000",
      "rating": "2.5",
      "genre": [
        {
          "name": "Davido 001",
          "categories": ["R & B", "Afro Beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        },
        {
          "name": "Davido 001",
          "categories": ["Afro-beat"],
          "photo": "assets/images/avatar.png",
          "facebook": "facebook.com",
          "instagram": "instagram.com",
          "youtube": "youtube.com"
        }
      ],
      "reviews": "200",
      "favourite": "0",
      "host": "Ola Alli",
      "duration": "9:00 AM - 6:00PM",
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final args = jsonDecode(arguments.toString());
          final items = args["data"] ?? [];
          setState(() {
            _items = items;
            title = args["title"] ?? "Events";
            selectedCountry = title == "Featured Countries"
                ? items[0]["country"].toString()
                : "";
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
    final screenHeight = MediaQuery.sizeOf(context).height;
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
        title: Widgets.buildText(title, context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: kToolbarHeight,
        actions: [
          if (title == "Featured Countries")
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    final country = Sheets.showConfirmation();
                  },
                  style: Widgets.buildButton(context,
                      sideColor: Color(0xFFF1F1F1), radius: 30.0),
                  icon: ClipOval(
                      child: Image.asset(
                    "assets/images/NGN.png",
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ))),
            )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              bottom: 20.0,
              left: title == "Featured Countries" ? 0.0 : 15.0,
              right: 15.0,
              top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: title == "Featured Countries" ? 15.0 : 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: Widgets.inputDecoration("",
                              isOutline: true,
                              color: Palette.getColor(
                                  context, "background", "paper"),
                              borderColor: Palette.getColor(
                                  context, "background", "paper"),
                              hint: "Search for attractions",
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
                      const SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.get("main.primary"),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              final res = await Sheets.showSortBy(sortBy);
                              setState(() {
                                sortBy = res;
                              });
                            },
                            icon: Helpers.fetchIcons(
                              "bars-filter",
                              "solid",
                              size: 16,
                              color: "text.white",
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  spacing: 5.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title == "Featured Countries")
                      Container(
                        width: 150.0,
                        height: screenHeight - 200.0,
                        decoration: BoxDecoration(
                            color: Palette.get("background.paper"),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCountry =
                                        item["country"].toString();
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: selectedCountry ==
                                              item["country"].toString()
                                          ? BorderRadius.circular(10)
                                          : null,
                                      color: Palette.get(selectedCountry ==
                                              item["country"].toString()
                                          ? "background.default"
                                          : "background.paper")),
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5.0,
                                    children: [
                                      Widgets.buildText(
                                          item["country"].toString(), context,
                                          isMedium: true),
                                      Widgets.buildText(
                                          "${Helpers.formatNumber(item["total"].toString())} attractions",
                                          context,
                                          color: "text.secondary"),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: _items.length),
                      ),
                    Expanded(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                title == "Featured Countries" ? 1 : 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent:
                                title == "Must Visit Places" ? 220.0 : 370.0),
                        itemBuilder: (BuildContext context, int index) {
                          final item = title == "Featured Countries"
                              ? data[index]
                              : _items[index];
                          if (title == "Must Visit Places") {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/attraction",
                                    arguments: jsonEncode(item));
                              },
                              child: SizedBox(
                                height: 220.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        item["image"].toString(),
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color:
                                              Palette.get("background.overlay"),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        spacing: 10.0,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Palette.getColor(
                                                        context,
                                                        "background",
                                                        "default"),
                                                radius: 20.0,
                                                child: Helpers.fetchIcons(
                                                  "heart",
                                                  "regular",
                                                  size: 20.0,
                                                  color: "main.primary",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  item["title"].toString(),
                                                  context,
                                                  color: "text.white",
                                                  isMedium: true,
                                                  size: 15.0),
                                              Widgets.buildText(
                                                  Helpers.formatCurrency(
                                                      item["price"].toString()),
                                                  context,
                                                  color: "text.white",
                                                  weight: 500),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: AttractionItem(
                              item: item,
                              direction: "vertical",
                            ),
                          );
                        },
                        itemCount: title == "Featured Countries"
                            ? data.length
                            : _items.length,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
