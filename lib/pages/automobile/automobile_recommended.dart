import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AutomobileRecommended extends StatefulWidget {
  const AutomobileRecommended({Key? key}) : super(key: key);

  @override
  _AutomobileRecommendedState createState() => _AutomobileRecommendedState();
}

class _AutomobileRecommendedState extends State<AutomobileRecommended> {
  var selected = 0;
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
        title: Widgets.buildText("Popular car hire brands", context,
            isMedium: true),
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
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 15.0),
            itemBuilder: (BuildContext context, int index) {
              final item = _items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/automobile-filter",
                      arguments: jsonEncode({
                        "vendor": item["name"].toString(),
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Palette.get("background.paper"),
                      border: Border.all(color: Color(0x0D000000))),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    spacing: 5.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              item["image"],
                              height: 100.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5.0,
                            right: 10.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.get("background.paper"),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5.0),
                              child: Row(
                                spacing: 2.0,
                                children: [
                                  for (var i = 0; i < 5; i += 1)
                                    Helpers.fetchIcons("star", "solid",
                                        color: i <
                                                (num.tryParse(item["rating"]
                                                            .toString())
                                                        ?.toInt() ??
                                                    0)
                                            ? "warning.main"
                                            : "text.secondary",
                                        size: 11.0)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Widgets.buildText(item["name"], context, size: 14.0)
                    ],
                  ),
                ),
              );
            },
            itemCount: _items.length,
          ),
        ),
      ),
    );
  }
}
