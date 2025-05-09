import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with SingleTickerProviderStateMixin {
  final profile = {
    "fname": "Olamide",
    "lname": "Owoeye",
    "email": "info@useafritas.com",
    "phone": "091833383",
    "dateAdded": "2025-01-01",
    "isVerified": "1",
    "status": "1",
    "photo": "",
    "gender": "M",
    "dob": "1995-01-02",
    "address": "ibeju Lekki Lagos Nigeria"
  };

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
                              Stack(
                                children: [
                                  Helpers.getProfilePhoto(context,
                                      height: 100.0),
                                  Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: Helpers.fetchIcons(
                                          "pen-circle", "solid",
                                          color: "main.primary", size: 24.0))
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Widgets.buildText(
                                  "${profile["fname"]} ${profile["lname"]}",
                                  context,
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
                              "value": "${profile["fname"]} ${profile["lname"]}"
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
                              "label": "Gender",
                              "value": profile["gender"].toString() == "M"
                                  ? "Male"
                                  : "Female"
                            };
                            break;
                          case 3:
                            item = {
                              "label": "Email",
                              "value": profile["email"],
                              "isVerified": profile["isVerified"].toString()
                            };
                            break;
                          case 4:
                            item = {
                              "label": "Address",
                              "value": profile["address"],
                            };
                            break;
                          case 5:
                            item = {
                              "label": "Date of Birth",
                              "value": profile["dob"].toString().isNotEmpty
                                  ? Helpers.formatDate(
                                      profile["dob"].toString(),
                                      formatString: "MMM dd, yyyy")
                                  : "",
                            };
                            break;
                        }
                        return index == 6
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/edit-profile");
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
                                  children: [
                                    Widgets.buildText(
                                        item["label"].toString(), context,
                                        size: 14.0,
                                        weight: 400,
                                        color: "text.black"),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Column(
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
                                                    BorderRadius.circular(5.0)),
                                            padding: const EdgeInsets.all(5.0),
                                            child: Widgets.buildText(
                                                item["isVerified"].toString() ==
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
                                            color: "text.primary"),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      },
                      itemCount: 7,
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
