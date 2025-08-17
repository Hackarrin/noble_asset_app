import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> menus = [
    {
      "title": "Biometric Login",
      "subtext": "Login with your fingerprint or Face ID.",
      "name": "biometric_login",
      "value": "0",
      "icon": ""
    },
    {
      "title": "Show Account Balances",
      "subtext": "Display your account balances",
      "name": "showBalance",
      "value": "1",
      "icon": ""
    },
    {
      "title": "Dark Mode",
      "subtext": "Enable dark mode",
      "name": "enable_dark",
      "value": "0",
      "icon": ""
    },
  ];
  var enableBiometric = false;
  Future<void> check() async {
    List<Map<String, dynamic>> temp = [];
    for (var item in menus) {
      item["value"] = await Helpers.readPref(item["name"]);
      temp.add(item);
    }
    setState(() {
      menus = temp;
    });
  }

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
    check();
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
        title: Widgets.buildText("Settings", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item = menus[index];
                        return GestureDetector(
                          onTap: () {
                            if (item["page"].toString().startsWith("/")) {
                              Navigator.pushNamed(
                                  context, item["page"].toString());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.paper"),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Color(0x1A000000))),
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 20.0,
                                bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Widgets.buildText(
                                            item["title"].toString(), context,
                                            size: 14.0,
                                            weight: 400,
                                            isMedium: true,
                                            color: "text.primary"),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Widgets.buildText(
                                            item["subtext"].toString(), context,
                                            size: 12.0,
                                            weight: 400,
                                            lines: 3,
                                            color: "text.secondary"),
                                      ]),
                                ),
                                SizedBox(
                                  height: 30.0,
                                  child: FittedBox(
                                    child: Switch(
                                        inactiveTrackColor: Color(0x80000000),
                                        inactiveThumbColor:
                                            Palette.get("text.white"),
                                        value: item["value"].toString() == "1",
                                        onChanged: (value) {
                                          Helpers.writePref(
                                              item["name"], value ? "1" : "0");
                                          setState(() {
                                            item["value"] = value ? "1" : "0";
                                          });
                                          if (item["name"] == "enable_dark") {
                                            //change theme brightness
                                            MyApp.of(context)
                                                .changeTheme(value);
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: menus.length,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
