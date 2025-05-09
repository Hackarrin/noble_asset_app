import 'package:cribsfinder/utils/apis.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Referrals extends StatefulWidget {
  const Referrals({Key? key}) : super(key: key);

  @override
  _ReferralsState createState() => _ReferralsState();
}

class _ReferralsState extends State<Referrals> {
  final profile = {
    "fname": "Tayo",
    "lname": "Oladele",
    "email": "info@cribsfinder.com",
    "phone": "091833383",
    "dateAdded": "2025-01-01",
    "isVerified": "1",
    "status": "1",
    "photo": "",
    "gender": "M",
    "dob": "1995-01-02",
    "address": "ibeju Lekki Lagos Nigeria"
  };
  Map<String, dynamic> _wallet = {"NGN": 100.0, "USD": 100.0, "GBP": 100.0};
  bool _isLoading = false;

  void handleAddAccount(String currency) async {
    try {
      if (currency.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        // await API.addWalletAccount(currency);
        // enqueueSnackbar("Your wallet account has been added!", {
        //   variant: "success",
        // });
        Navigator.pop(context);
      } else {
        // enqueueSnackbar("Please select a valid account to proceed.", {
        //   variant: "error",
        // });
        return;
      }
    } catch (err) {
      // enqueueSnackbar(err.message || err, {
      //   variant: "error",
      // });
    }
    setState(() {
      _isLoading = false;
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
        backgroundColor: Color(0xFF7777D4),
        body: Padding(
          padding: const EdgeInsets.only(
              top: kToolbarHeight, left: 0.0, right: 0.0, bottom: 0.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/refer-bg.png",
                  width: screenWidth,
                  height: screenHeight / 2,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 70.0,
                    width: screenWidth,
                    height: 30.0,
                    child: Container(
                      width: double.infinity,
                      height: 30.0,
                      color: Palette.get("text.white"),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 30.0,
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/refer-content-bg.png"),
                                  fit: BoxFit.cover)),
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0, bottom: 0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Helpers.fetchIcons(
                                        "share-square", "regular",
                                        size: 24.0, color: "main.purple")),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 100.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText("Earn up to", context,
                                        weight: 400, size: 30.0),
                                    Row(
                                      children: [
                                        Widgets.buildText("50%", context,
                                            weight: 600,
                                            size: 50.0,
                                            color: "main.purple"),
                                        Widgets.buildText(
                                            "per\nReferral", context,
                                            weight: 500,
                                            size: 19.0,
                                            color: "main.purple"),
                                      ],
                                    ),
                                    Widgets.buildText(
                                        "Earn Up to 50% by Inviting Vendors & Friends to Cribsfinder!",
                                        context,
                                        isMedium: true,
                                        lines: 5)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0x1A7575EC),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(15.0),
                                child: Widgets.buildText(
                                    "Turn Your Connections into Cash Invite vendors and friends to join Cribsfinder and unlock an incredible earning opportunity.",
                                    lines: 10,
                                    context),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Widgets.buildText(
                                  "By inviting friends & vendors, you agree to our terms and conditions.",
                                  context,
                                  size: 11.0,
                                  lines: 4,
                                  isUnderlined: true),
                              const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Palette.get("text.white"),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {},
                                      style: Widgets.buildButton(context,
                                          background: Color(0xFF7575EC),
                                          radius: 50.0,
                                          vertical: 15.0),
                                      child: Widgets.buildText(
                                          "Copy Link", context,
                                          color: "text.white",
                                          isMedium: true))),
                              const SizedBox(
                                width: 10.0,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/referral-overview");
                                  },
                                  style: Widgets.buildButton(context,
                                      sideColor: Palette.get("main.purple"),
                                      radius: 40.0),
                                  icon: Helpers.fetchIcons(
                                      "arrow-small-right", "solid",
                                      color: "main.purple", size: 20.0))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Widgets.buildText("Close", context,
                          isCenter: true, color: "text.white")),
                ),
                Positioned(
                    bottom: 400.0,
                    child: SizedBox(
                      width: screenWidth,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF263238),
                              borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.only(left: 50.0),
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/images/logo-white.png",
                            height: 64.0,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
