import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Social extends StatefulWidget {
  const Social({Key? key}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> with SingleTickerProviderStateMixin {
  List socials = [
    {
      "name": "@nobleassets",
      "subtitle": "Follow us on Instagram",
      "icon": "instagram",
      "socialColor": "#E02D69",
      "path": "https://www.instagram.com/nobleassets",
    },
    {
      "name": "@nobleassets",
      "subtitle": "Follow us on Tiktok",
      "icon": "tik-tok",
      "socialColor": "#007EBB",
      "path": "https://www.tiktok.com/@nobleassets",
    },
    {
      "name": "@nobleassetsng",
      "subtitle": "Follow us on Twitter (X)",
      "icon": "twitter-alt",
      "socialColor": "#00AAEC",
      "path": "https://x.com/nobleassetsng",
    },
  ];
  var enableBiometric = false;

  bool loading = true;
  String error = "";

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
        title: Widgets.buildText("Follow Us Today", context, isMedium: true),
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
                          final item = socials[index];
                          Color color = Color(int.parse(
                                  item["socialColor"].substring(1),
                                  radix: 16) +
                              0xFF000000);
                          return GestureDetector(
                            onTap: () {
                              Helpers.openLink(item["path"].toString(),
                                  item["subtitle"].toString());
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 35.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                    color: color.withAlpha(50),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: UnconstrainedBox(
                                                  child: Helpers.fetchIcons(
                                                      item["icon"].toString(),
                                                      "regular",
                                                      size: 16.0,
                                                      overrideColor: color),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Widgets.buildText(
                                                        item["name"].toString(),
                                                        context,
                                                        size: 14.0,
                                                        weight: 400,
                                                        isMedium: true,
                                                        lines: 2,
                                                        color: "text.primary"),
                                                    Widgets.buildText(
                                                        item["subtitle"]
                                                            .toString(),
                                                        context,
                                                        size: 13.0,
                                                        weight: 400,
                                                        lines: 2,
                                                        color: "text.disabled"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Helpers.fetchIcons(
                                            "angle-right", "solid")
                                      ]),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: socials.length,
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
