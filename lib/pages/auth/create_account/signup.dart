import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/webview.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/palette.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    return Scaffold(
        backgroundColor: Palette.getColor(context, "background", "paper"),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
              child: Column(
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
                              border: Border.all(color: Color(0xFFF1F1F1))),
                          child: UnconstrainedBox(
                            child: Helpers.fetchIcons("cross", "solid",
                                color: "text.secondary", size: 14.0),
                          ))),
                  const SizedBox(height: 40.0),
                  Column(
                    children: [
                      Widgets.buildText(
                        "Create Account",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Fill your information below or continue with google or email.",
                          context,
                          lines: 10,
                          isCenter: true,
                          color: "text.secondary"),
                      const SizedBox(
                        height: 30.0,
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
                                isOutline: true),
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
                          Widgets.buildText("Password", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: Widgets.inputDecoration("",
                                color: Color(0x99F4F4F4),
                                isFilled: true,
                                isOutline: true,
                                suffixIcon: UnconstrainedBox(
                                    child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  child: Helpers.fetchIcons(
                                      isPasswordVisible ? "eye-crossed" : "eye",
                                      "solid",
                                      color: "text.disabled",
                                      size: 20.0),
                                ))),
                            obscureText: !isPasswordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
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
                      Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              side: BorderSide(
                                  color: Palette.get("main.primary"),
                                  width: 2.0),
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked ?? false;
                                });
                              }),
                          Widgets.buildText("I agree with the ", context),
                          GestureDetector(
                            onTap: () {
                              Helpers.openLink("https://cribsfinder.com/terms",
                                  "Terms & Conditions");
                            },
                            child: Widgets.buildText(
                                "Terms & Condition", context,
                                isUnderlined: true, color: "main.primary"),
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
                              Navigator.pushNamed(context, "/signup-verify");
                            },
                            style: Widgets.buildButton(context,
                                vertical: 20.0,
                                horizontal: 10.0,
                                radius: 60.0,
                                background: Palette.get("main.primary")),
                            child: Widgets.buildText("Sign Up", context,
                                color: "text.white", weight: 500, size: 16.0)),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Divider(color: Color(0x1A535353))),
                          Widgets.buildText(" Or sign up with ", context,
                              color: "text.disabled"),
                          Expanded(child: Divider(color: Color(0x1A535353))),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Color(0x1A000000))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.abc,
                                    color: Palette.get("text.primary"),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Widgets.buildText("Google", context)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Color(0x1A000000))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline_rounded,
                                    color: Palette.get("text.primary"),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Widgets.buildText("Email", context)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Widgets.buildText(
                                "Already have an account?   ", context,
                                color: "text.secondary"),
                            Widgets.buildText("Sign In", context,
                                isUnderlined: true, color: "main.primary"),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        )));
  }
}
