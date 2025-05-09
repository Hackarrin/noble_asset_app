import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/webview.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/palette.dart';

class SignupCompleteProfile extends StatefulWidget {
  const SignupCompleteProfile({Key? key}) : super(key: key);

  @override
  _SignupCompleteProfileState createState() => _SignupCompleteProfileState();
}

class _SignupCompleteProfileState extends State<SignupCompleteProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  var isChecked = false;
  var isPasswordVisible = false;

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
        backgroundColor: Palette.getColor(context, "background", "paper"),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Container(
                width: screenWidth,
                height: screenHeight,
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border:
                                        Border.all(color: Color(0xFFF1F1F1))),
                                child: UnconstrainedBox(
                                  child: Helpers.fetchIcons(
                                      "arrow-small-left", "solid",
                                      color: "text.secondary", size: 17.0),
                                ))),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          child: Widgets.buildText(
                              "Compete Your Profile", context,
                              isMedium: true,
                              size: 24.0,
                              weight: 500,
                              isCenter: true),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            "Don’t worry, only you can see your personal data. No on else will be able to see it.",
                            context,
                            lines: 10,
                            isCenter: true,
                            color: "text.secondary"),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF9F8F8),
                                    borderRadius: BorderRadius.circular(60.0)),
                                padding: const EdgeInsets.all(25.0),
                                child: UnconstrainedBox(
                                  child: Helpers.fetchIcons("user", "solid",
                                      size: 45.0, color: "main.primary"),
                                ),
                              ),
                              Positioned(
                                  bottom: 10.0,
                                  right: 0.0,
                                  child: Helpers.fetchIcons(
                                      "pen-circle", "solid",
                                      color: "main.primary", size: 24.0))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Name", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: nameController,
                              decoration: Widgets.inputDecoration(
                                "",
                                color: Color(0x99F4F4F4),
                                isFilled: true,
                                isOutline: true,
                              ),
                              style: GoogleFonts.nunito(
                                  color: Color(0xFF757575),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Phone Number", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: phoneController,
                              decoration: Widgets.inputDecoration("",
                                  color: Color(0x99F4F4F4),
                                  isFilled: true,
                                  isOutline: true,
                                  prefixIcon: Row(children: [
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Widgets.buildText("+1", context,
                                        color: "text.disabled"),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Helpers.fetchIcons("caret-down", "solid",
                                        color: "text.disabled", size: 20.0),
                                  ])),
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.nunito(
                                  color: Color(0xFF757575),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Gender", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: genderController,
                              decoration: Widgets.inputDecoration("",
                                  color: Color(0x99F4F4F4),
                                  isFilled: true,
                                  isOutline: true,
                                  suffixIcon: UnconstrainedBox(
                                      child: Helpers.fetchIcons(
                                          "caret-down", "solid",
                                          color: "text.disabled", size: 20.0))),
                              style: GoogleFonts.nunito(
                                  color: Color(0xFF757575),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                              readOnly: true,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/home");
                          },
                          style: Widgets.buildButton(context,
                              vertical: 20.0,
                              horizontal: 10.0,
                              radius: 60.0,
                              background: Palette.get("main.primary")),
                          child: Widgets.buildText("Complete Profile", context,
                              color: "text.white", weight: 500, size: 16.0)),
                    ),
                  ],
                ))));
  }
}
