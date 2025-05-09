import 'dart:convert';

import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AttractionCategories extends StatefulWidget {
  const AttractionCategories({Key? key}) : super(key: key);

  @override
  _AttractionCategoriesState createState() => _AttractionCategoriesState();
}

class _AttractionCategoriesState extends State<AttractionCategories> {
  var selected = 0;
  var _categories = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final categories = jsonDecode(arguments.toString());
          setState(() {
            _categories = (categories ?? []);
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
        title: Widgets.buildText("Preferences", context, isMedium: true),
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
              EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 95.0,
                      mainAxisSpacing: 30.0,
                      crossAxisSpacing: 30.0),
                  padding: EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = Defaults.attractionCategories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/attraction-filter",
                            arguments: jsonEncode({
                              "category": item.toString(),
                            }));
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Palette.getColor(
                                  context, "background", "paper"),
                              border: Border.all(
                                color: Color(0x0d000000),
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: FittedBox(
                              child: Helpers.fetchIcons(
                                  item["icon"].toString(), "solid",
                                  size: 24.0, color: "main.primary"),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          FittedBox(
                            child: Widgets.buildText(
                                item["name"].toString().split(" ")[0].trim(),
                                context),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: Defaults.attractionCategories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
