import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/apis.dart';
import 'package:cribsfinder/utils/fetch.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  Map<String, dynamic> profile = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      get();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void get() async {
    final details = await Helpers.getProfile();
    setState(() {
      profile = details["user"] ?? {};
    });
  }

  void handleSubmit(image) async {
    try {
      Alert.showLoading(context, "Updating...");
      final photo = await Fetch(API.misc, {},
              method: "file", isFormData: true, file: image)
          .load();
      print("photo $photo $image");
      if (photo.isNotEmpty && photo["status"].toString() == "success") {
        await JWT.updateSettings({"photo": photo["data"].toString()}, "photo");
        get();
        Alert.hideLoading(context);
        Alert.show(context, "", "Profile updated successfully!",
            type: "success");
        return;
      }
      throw Exception("An error has occured! Please try again later.");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("My Profile", context, isMedium: true),
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
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.get("text.white"),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color(0x0D000000))),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Widgets.buildText(
                                    Helpers.formatNumMonths(
                                        profile["dateAdded"].toString()),
                                    context,
                                    weight: 400,
                                    size: 13.0,
                                    color: "text.disabled"),
                              ),
                              const SizedBox(height: 30.0),
                              GestureDetector(
                                onTap: () async {
                                  final image = await Sheets.chooseImage(
                                      "Select your profile picture");
                                  handleSubmit(image);
                                },
                                child: Stack(
                                  children: [
                                    Helpers.getProfilePhoto(context,
                                        height: 100.0, profile: profile),
                                    Positioned(
                                        bottom: 0.0,
                                        right: 0.0,
                                        child: Helpers.fetchIcons(
                                            "pen-circle", "solid",
                                            color: "main.primary", size: 24.0))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Widgets.buildText(profile["name"], context,
                                  isMedium: true),
                            ],
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 15.0, right: 15.0, top: 20.0),
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
                        var item = {};
                        switch (index) {
                          case 0:
                            item = {
                              "label": "Full name",
                              "value": profile["name"]
                            };
                            break;
                          case 1:
                            item = {
                              "label": "Mobile Number",
                              "value": profile["phone"]
                            };
                            break;
                          case 2:
                            item = {
                              "label": "Email",
                              "value": profile["email"],
                              "isVerified": profile["isVerified"].toString()
                            };
                            break;
                          case 3:
                            item = {
                              "label": "Address",
                              "value": profile["address"],
                            };
                            break;
                        }
                        return index == 4
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await Navigator.pushNamed(
                                            context, "/edit-profile");
                                        get();
                                      },
                                      style: Widgets.buildButton(context,
                                          background:
                                              Palette.get("main.primary")),
                                      child: Widgets.buildText("Edit", context,
                                          size: 13.0,
                                          weight: 500,
                                          color: "text.white")),
                                ],
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 20.0,
                                  children: [
                                    Widgets.buildText(
                                        item["label"].toString(), context,
                                        size: 14.0,
                                        weight: 400,
                                        color: "text.black"),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (item.containsKey("isVerified"))
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      item["isVerified"]
                                                                  .toString() ==
                                                              "0"
                                                          ? "error.main"
                                                          : "main.primary"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Widgets.buildText(
                                                  item["isVerified"]
                                                              .toString() ==
                                                          "0"
                                                      ? "Pending verification"
                                                      : "Verified",
                                                  context,
                                                  size: 12.0,
                                                  weight: 500,
                                                  color: "text.white"),
                                            ),
                                          Widgets.buildText(
                                              item["value"].toString(), context,
                                              size: 14.0,
                                              weight: 400,
                                              lines: 3,
                                              isRight: true,
                                              color: "text.primary"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                      itemCount: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
