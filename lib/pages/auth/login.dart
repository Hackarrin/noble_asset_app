import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/webview.dart';
import 'package:afritas/utils/widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/palette.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isChecked = false;
  var method = "email";
  var isPasswordVisible = false;
  var isAlreadyLoggedIn = false;

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
                  left: 20.0, right: 20.0, top: 0.0, bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/login-bg.png",
                        height: 400,
                        fit: BoxFit.contain,
                      ),
                      Widgets.buildText(
                        isAlreadyLoggedIn
                            ? "Welcome Back, Roland"
                            : "Access your Account",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          isAlreadyLoggedIn
                              ? "We're glad to see you again. Please log in to continue."
                              : "Login with your email address / phone number and password to access your account.",
                          context,
                          lines: 10,
                          isCenter: true,
                          color: "text.secondary"),
                      const SizedBox(
                        height: 30.0,
                      ),
                      if (method == "phone" && !isAlreadyLoggedIn)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Country Code", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: countryController,
                              readOnly: true,
                              decoration: Widgets.inputDecoration("",
                                  color: Color(0x99F4F4F4),
                                  isFilled: true,
                                  isOutline: true,
                                  suffixIcon: UnconstrainedBox(
                                      child: Helpers.fetchIcons(
                                          "caret-down", "solid",
                                          color: "text.disabled", size: 20.0))),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF757575),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                              onTap: () async {
                                final selected = await Sheets.showOptions(
                                    "Country", "", Defaults.hotelCategories);
                              },
                            ),
                          ],
                        ),
                      if (method == "phone" && !isAlreadyLoggedIn)
                        const SizedBox(
                          height: 15.0,
                        ),
                      if (method == "phone" && !isAlreadyLoggedIn)
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
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF757575),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      if (method == "email" && !isAlreadyLoggedIn)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Email Address", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: emailController,
                              decoration: Widgets.inputDecoration("",
                                  color: Color(0x99F4F4F4),
                                  isFilled: true,
                                  isOutline: true),
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
                                color: Color(0xFF757575),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/forgot-password");
                            },
                            child: Widgets.buildText(
                                "Forgot Password?", context,
                                isRight: true,
                                color: "main.primary",
                                isUnderlined: true)),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/home");
                                },
                                style: Widgets.buildButton(context,
                                    vertical: 20.0,
                                    horizontal: 10.0,
                                    radius: 60.0,
                                    background: Palette.get("main.primary")),
                                child: Widgets.buildText("Log In", context,
                                    color: "text.white",
                                    weight: 500,
                                    size: 16.0)),
                          ),
                          if (isAlreadyLoggedIn)
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                  width: 56.0,
                                  height: 56.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(56.0),
                                      color: Palette.get("background.paper"),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(-1, 1),
                                            blurRadius: 12,
                                            spreadRadius: 0,
                                            color: Color(0x0D000000))
                                      ]),
                                  child: UnconstrainedBox(
                                    child: Helpers.fetchIcons(
                                        "fingerprint", "regular",
                                        size: 30.0, color: "main.primary"),
                                  )),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAlreadyLoggedIn = !isAlreadyLoggedIn;
                          });
                        },
                        child: Widgets.buildText(
                            isAlreadyLoggedIn
                                ? "View Standard Interface"
                                : "View Already logged-in interface",
                            context,
                            isUnderlined: true),
                      ),
                      if (!isAlreadyLoggedIn)
                        const SizedBox(
                          height: 20.0,
                        ),
                      if (!isAlreadyLoggedIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Divider(color: Color(0x1A535353))),
                            Widgets.buildText(" Or sign in with ", context,
                                color: "text.disabled"),
                            Expanded(child: Divider(color: Color(0x1A535353))),
                          ],
                        ),
                      if (!isAlreadyLoggedIn)
                        const SizedBox(
                          height: 20.0,
                        ),
                      if (!isAlreadyLoggedIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border:
                                        Border.all(color: Color(0x1A000000))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/login-google.jpeg",
                                        height: 30.0,
                                        fit: BoxFit.contain),
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
                              onTap: () {
                                setState(() {
                                  method =
                                      method == "phone" ? "email" : "phone";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border:
                                        Border.all(color: Color(0x1A000000))),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                child: Row(
                                  children: [
                                    if (method == "phone")
                                      Image.asset(
                                          "assets/images/login-email.jpeg",
                                          height: 30.0,
                                          fit: BoxFit.contain),
                                    if (method == "email")
                                      Helpers.fetchIcons(
                                          "circle-phone", "solid",
                                          color: "main.primary", size: 24.0),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Widgets.buildText(
                                        method == "email" ? "Phone" : "Email",
                                        context)
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
                          if (isAlreadyLoggedIn) {
                            setState(() {
                              isAlreadyLoggedIn = false;
                            });
                          } else {
                            Navigator.pushNamed(context, "/get-started");
                          }
                        },
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Widgets.buildText(
                                isAlreadyLoggedIn
                                    ? "No, I am not Roland    "
                                    : "Don't have an account?   ",
                                context,
                                color: "text.secondary"),
                            Widgets.buildText(
                                isAlreadyLoggedIn ? "Logout" : "Sign Up",
                                context,
                                isUnderlined: true,
                                color: "main.primary"),
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
