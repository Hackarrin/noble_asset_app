import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/palette.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  Map<String, dynamic> profile = {};
  Map<String, dynamic> _company = {};
  Map<String, dynamic> _compliance = {};
  List menus = [
    {
      "title": "Manage Account",
      "options": [
        {
          "name": "Personal details",
          "icon": "user",
          "page": "/account",
        },
        {
          "name": "Next of Kin",
          "icon": "people-roof",
          "page": "/nok",
        },
        {
          "name": "Compliance",
          "icon": "compliance-document",
          "page": "/compliance",
        },
        {
          "name": "Security",
          "icon": "shield-check",
          "page": "/security",
        },
        {
          "name": "Statements & Reports",
          "icon": "document",
          "page": "/statements",
        },
        {
          "name": "Settings",
          "icon": "settings",
          "page": "/settings",
        },
      ],
      "isLogInRequired": true
    },
    {
      "title": "Wallets & Referral",
      "options": [
        {"name": "Wallet", "icon": "wallet", "page": "/wallet"},
        {"name": "Refer & Earn", "icon": "refer-arrow", "page": "/referrals"},
      ]
    },
    {
      "title": "Get in touch",
      "options": [
        {
          "name": "Contact Us",
          "icon": "user-headset",
          "page": "https://nobleassets.com/contact?is_mobile=1"
        },
        {
          "name": "Call Center",
          "icon": "phone-call",
          "page": "tel:+2349162784000"
        },
        {
          "name": "Visit the Help Center",
          "icon": "group-call",
          "page": "https://nobleassets.com/faq?is_mobile=1"
        },
        {
          "name": "Follow Us on Social Media",
          "icon": "following",
          "page": "/social"
        },
        {"name": "Share App", "icon": "tap", "page": "share"},
      ]
    },
    {
      "title": "Learn more",
      "options": [
        {
          "name": "About Noble Assets",
          "icon": "user-headset",
          "page": "https://nobleassets.com/about?is_mobile=1"
        },
        {
          "name": "FAQ",
          "icon": "interrogation",
          "page": "https://nobleassets.com/faq?is_mobile=1"
        },
        {
          "name": "Terms of Services",
          "icon": "info",
          "page": "https://nobleassets.com/terms?is_mobile=1"
        },
        {
          "name": "Privacy Policy",
          "icon": "user-lock",
          "page": "https://nobleassets.com/privacy?is_mobile=1"
        },
      ]
    }
  ];
  bool isLoggedIn = false;
  String _version = "";

  void get() async {
    final userId = await Helpers.readPref(Defaults.userid);
    final data = await Helpers.getProfile(key: "profile");
    final company = await Helpers.getCompany();
    String version = await Helpers.getCurrentVersion();
    final compliance = await Helpers.checkCompliance();
    setState(() {
      profile = data;
      _company = company;
      _compliance = compliance;
      if (_company.isNotEmpty) {
        menus[0]["options"].insert(
          1,
          {
            "name": "Company details",
            "icon": "building",
            "page": "/company",
          },
        );
      }
      _version = version;
      isLoggedIn = userId.isNotEmpty;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      get();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("response $_compliance");
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("My Profile", context, isMedium: true),
        actions: [],
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
                if (isLoggedIn)
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.get("background.paper"),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, "/account");
                        get();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              color: Palette.getColor(
                                  context, "background", "paper"),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Helpers.getProfilePhoto(context,
                                    height: 70.0, profile: profile),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Widgets.buildText(
                                          "${profile["fname"]} ${profile["lname"]}",
                                          context,
                                          isMedium: true),
                                      Widgets.buildText(
                                          _company.isEmpty
                                              ? (profile["email"]
                                                      .toString()
                                                      .isNotEmpty
                                                  ? profile["email"].toString()
                                                  : Defaults.accountTypes[
                                                      num.tryParse(profile[
                                                                      "type"]
                                                                  .toString())
                                                              ?.toInt() ??
                                                          0])
                                              : _company["name"].toString(),
                                          context,
                                          color: "text.secondary"),
                                      const SizedBox(height: 5.0),
                                      Column(
                                        spacing: 5.0,
                                        children: [
                                          if (_compliance["percent"]
                                                  .toString() ==
                                              "100")
                                            Row(
                                              children: [
                                                Helpers.fetchIcons(
                                                    "shield-trust", "solid",
                                                    color: "success.main",
                                                    size: 16.0),
                                                const SizedBox(width: 5.0),
                                                Widgets.buildText(
                                                    "Verified ID", context,
                                                    weight: 400,
                                                    size: 13.0,
                                                    color: "text.disabled"),
                                              ],
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                if (!isLoggedIn)
                  Alert.showErrorMessage(context, "Login to view your account",
                      isSlim: true, buttonText: "Login", action: () {
                    Navigator.pushNamed(context, "/login");
                  }),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Map item = menus[index];
                        if (!isLoggedIn) {
                          item = menus
                              .where((item) =>
                                  !item.containsKey("isLogInRequired") ||
                                  item["isLogInRequired"].toString() == "0")
                              .toList()[index];
                        }
                        final List options = (item["options"] ?? []) as List;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText(
                                    item["title"].toString(), context,
                                    size: 13.0,
                                    weight: 500,
                                    color: "text.primary"),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border:
                                          Border.all(color: Color(0x1A000000))),
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10.0,
                                      bottom: 5.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = options[index];
                                      return GestureDetector(
                                        onTap: () async {
                                          if (item["page"]
                                              .toString()
                                              .startsWith("/")) {
                                            await Navigator.pushNamed(context,
                                                item["page"].toString());
                                            get();
                                          } else if (double.tryParse(
                                                  item["page"].toString()) !=
                                              null) {
                                            Navigator.pushReplacementNamed(
                                                context, "/home",
                                                arguments:
                                                    item["page"].toString());
                                          } else if (item["page"]
                                                  .toString()
                                                  .startsWith("http") ||
                                              item["page"]
                                                  .toString()
                                                  .startsWith("tel:")) {
                                            Helpers.openLink(
                                                item["page"].toString(),
                                                item["name"].toString());
                                          } else if (item["page"].toString() ==
                                              "share") {
                                            // share app
                                            SharePlus.instance
                                                .share(ShareParams(
                                              title:
                                                  "Find top stays and rentals at Noble Assets",
                                              subject:
                                                  "Find top stays and rentals at Noble Assets",
                                              text:
                                                  "Check out the best stays and rental at Noble Assets. \n nobleassets.com",
                                            ));
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: index == 0
                                                      ? BorderSide.none
                                                      : BorderSide(
                                                          color: Color(
                                                              0x1A000000)))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Helpers.fetchIcons(
                                                        item["icon"].toString(),
                                                        "regular",
                                                        size: 16.0),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Widgets.buildText(
                                                        item["name"].toString(),
                                                        context,
                                                        size: 14.0,
                                                        weight: 400,
                                                        color: "text.primary"),
                                                    const SizedBox(
                                                      height: 15.0,
                                                    ),
                                                  ]),
                                              Helpers.fetchIcons(
                                                  "caret-right", "regular",
                                                  size: 16.0),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: options.length,
                                  ),
                                )
                              ]),
                        );
                      },
                      itemCount: isLoggedIn
                          ? menus.length
                          : menus
                              .where((item) =>
                                  !item.containsKey("isLogInRequired") ||
                                  item["isLogInRequired"].toString() == "0")
                              .length,
                    )),
                if (isLoggedIn)
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Helpers.logout();
                          },
                          style: Widgets.buildButton(context,
                              background: Palette.get("main.primary"),
                              vertical: 15.0,
                              radius: 50.0),
                          child: Widgets.buildText("Logout", context,
                              isMedium: true, color: "text.white")),
                    ),
                  ),
                const SizedBox(height: 10.0),
                Widgets.buildText("Version $_version", context, isCenter: true),
                const SizedBox(height: 10.0),
                Widgets.buildText(
                    "© ${DateTime.now().year} Noble Assets Management LTD. All rights reserved.",
                    context,
                    isCenter: true),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
