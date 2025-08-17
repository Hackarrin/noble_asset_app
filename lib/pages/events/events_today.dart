import 'dart:convert';

import 'package:nobleassets/globals/event_item.dart';
import 'package:nobleassets/globals/hotel_item.dart';
import 'package:nobleassets/globals/shortlet_item.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class EventsToday extends StatefulWidget {
  const EventsToday({Key? key}) : super(key: key);

  @override
  _EventsTodayState createState() => _EventsTodayState();
}

class _EventsTodayState extends State<EventsToday> {
  var selected = 0;
  var _items = [];
  var title = "";
  var sortBy = "relevance";

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
        title: Widgets.buildText(title, context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding:
              EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: Widgets.inputDecoration("",
                            isOutline: true,
                            color: Palette.getColor(
                                context, "background", "paper"),
                            borderColor: Palette.getColor(
                                context, "background", "paper"),
                            hint: "Search for events",
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
                            color:
                                Palette.getColor(context, "text", "secondary"),
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
                const SizedBox(
                  height: 20.0,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: EventItem(
                        item: item,
                        direction: title.toLowerCase().contains("week")
                            ? "horizontal"
                            : "vertical",
                        offset: title.toLowerCase().contains("month") ? 0.1 : 0,
                      ),
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
