import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/palette.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final menus = [
    {
      "title": "Manage Account",
      "options": [
        {
          "name": "Personal details",
          "icon": "user",
          "page": "/account",
        },
        {
          "name": "Login & Security",
          "icon": "insert-alt",
          "page": "/security",
        },
      ],
      "isLogInRequired": true
    },
    {
      "title": "Preferences",
      "options": [
        {
          "name": "Two-Factor Authentication",
          "icon": "shield-keyhole",
          "page": "/2fa"
        },
        // {
        //   "name": "Device Preferences",
        //   "icon": "tablet-android",
        //   "page": "/device-preferences"
        // },
        {
          "name": "Notification",
          "icon": "bell-notification-social-media",
          "page": "/notifications"
        },
      ],
      "isLogInRequired": true
    },
    {
      "title": "Travel Activity",
      "options": [
        {"name": "Wishlist", "icon": "wishlist-heart", "page": "2"},
        {"name": "My Reviews", "icon": "feedback-review", "page": "/reviews"},
        {"name": "My Bookings", "icon": "book-alt", "page": "1"},
      ],
      "isLogInRequired": true
    },
    // {
    //   "title": "Referral & Payment",
    //   "options": [
    //     {
    //       "name": "Refer a Host or Guest",
    //       "icon": "refer-arrow",
    //       "page": "/referrals"
    //     },
    //     {
    //       "name": "Payment Method",
    //       "icon": "money-bill-wave",
    //       "page": "/payment-method"
    //     },
    //     {"name": "Wallet", "icon": "wallet", "page": "/wallet"},
    //   ]
    // },
    {
      "title": "Help & Support",
      "options": [
        {"name": "Contact Support", "icon": "user-headset", "page": "/support"},
        {"name": "Call Center", "icon": "phone-call", "page": "/call"},
        {
          "name": "Visit the Help Center",
          "icon": "group-call",
          "page": "/help"
        },
        // {"name": "How Cribsfinder Works", "icon": "info", "page": "/work"},
        {
          "name": "Follow Us on Social Media",
          "icon": "following",
          "page": "/social"
        },
        {"name": "Share App", "icon": "tap", "page": "share"},
      ]
    },
    {
      "title": "Legal & Privacy",
      "options": [
        {
          "name": "About Cribsfinder",
          "icon": "user-headset",
          "page": "https://cribsfinder.com/about"
        },
        {
          "name": "FAQ",
          "icon": "interrogation",
          "page": "https://cribsfinder.com/faq"
        },
        {
          "name": "Terms of Services",
          "icon": "info",
          "page": "https://cribsfinder.com/terms"
        },
        {
          "name": "Privacy Policy",
          "icon": "user-lock",
          "page": "https://cribsfinder.com/privacy"
        },
      ]
    }
  ];
  bool isLoggedIn = false;
  String _version = "";
  Map<String, dynamic> profile = {};

  void get() async {
    final userId = await Helpers.readPref(Defaults.userid);
    final details = await Helpers.getProfile();
    String version = await Helpers.getCurrentVersion();
    setState(() {
      profile = details["user"] ?? {};
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
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("My Profile", context, isMedium: true),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                  onTap: () {},
                  child: Helpers.fetchIcons("user-headset", "regular",
                      color: "text.black", size: 24.0))),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, "/account");
                  get();
                },
                child: Helpers.fetchIcons("settings", "regular",
                    color: "text.black", size: 24.0)),
          )
        ],
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
                        color: Palette.get("text.white"),
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
                                horizontal: 5.0, vertical: 20.0),
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
                                          profile["name"] ?? "", context,
                                          isMedium: true),
                                      const SizedBox(height: 5.0),
                                      Column(
                                        spacing: 5.0,
                                        children: [
                                          Row(
                                            children: [
                                              Helpers.fetchIcons(
                                                  "driver-man", "solid",
                                                  color: "text.primary",
                                                  size: 16.0),
                                              const SizedBox(width: 5.0),
                                              Widgets.buildText(
                                                  Helpers.formatNumMonths(
                                                      profile["dateAdded"]
                                                          .toString()),
                                                  context,
                                                  weight: 400,
                                                  size: 13.0,
                                                  color: "text.disabled"),
                                            ],
                                          ),
                                          if (profile["isVerified"]
                                                  .toString() ==
                                              "1")
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
                                    color: "text.black"),
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
                                              .startsWith("http")) {
                                            Helpers.openLink(
                                                item["page"].toString(),
                                                item["name"].toString());
                                          } else if (item["page"].toString() ==
                                              "share") {
                                            // share app
                                            SharePlus.instance
                                                .share(ShareParams(
                                              title:
                                                  "Find top stays and rentals at Cribsfinder",
                                              subject:
                                                  "Find top stays and rentals at Cribsfinder",
                                              text:
                                                  "Check out the best stays and rental at Cribsfinder. \n cribsfinder.com",
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
                    "© ${DateTime.now().year} Cribsfinder LTD. All rights reserved.",
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
