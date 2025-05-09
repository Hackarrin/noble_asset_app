import 'package:afritas/utils/apis.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class AddWalletAccount extends StatefulWidget {
  const AddWalletAccount({Key? key}) : super(key: key);

  @override
  _AddWalletAccountState createState() => _AddWalletAccountState();
}

class _AddWalletAccountState extends State<AddWalletAccount> {
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
          elevation: 0,
          backgroundColor: Palette.getColor(context, "background", "paper"),
          foregroundColor: Palette.getColor(context, "text", "disabled"),
          toolbarHeight: 80.0,
          title: Widgets.buildText("Add New Account", context, isMedium: true),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Widgets.buildText(
                      "Open a multi-currency wallet with Afritas! Hold, send, and receive funds seamlessly in your preferred currency.",
                      lines: 10,
                      isCenter: true,
                      weight: 500,
                      context),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("WITH ACCOUNT NUMBER", context,
                          color: "text.secondary", weight: 500),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleAddAccount("NGN");
                        },
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/images/NGN.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Widgets.buildText("Nigerian Naira", context,
                                weight: 500)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("OTHERS", context,
                          color: "text.secondary", weight: 500),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleAddAccount("USD");
                        },
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/images/USD.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Widgets.buildText("US Dollar", context, weight: 500)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleAddAccount("GBP");
                        },
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/images/GBP.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Widgets.buildText("British Pound", context,
                                weight: 500)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("COMING SOON", context,
                          color: "text.disabled", weight: 500),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleAddAccount("GHC");
                        },
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/images/GHC.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Widgets.buildText("Ghanaian Cedis", context,
                                weight: 500, color: "text.disabled")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleAddAccount("ZAR");
                        },
                        child: Row(
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/images/ZAR.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            )),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Widgets.buildText("South-African Rand", context,
                                weight: 500, color: "text.disabled")
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
