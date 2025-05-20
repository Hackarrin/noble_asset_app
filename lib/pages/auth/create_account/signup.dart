import 'dart:convert';

import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/palette.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  var isChecked = false;
  var isEmail = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void googleSignin() async {
    try {
      final result = await _googleSignIn.signIn();
      print("google: $result");
    } catch (err) {
      print("google: $err");
      Alert.show(context, "",
          "Google authentication failed! Please retry or sign up with phone number or email address.");
    }
  }

  void signup() async {
    final phone = phoneController.text;
    final email = emailController.text;
    try {
      if ((isEmail && email.isNotEmpty) || phone.isNotEmpty) {
        if (isChecked) {
          Alert.showLoading(
              context,
              isEmail
                  ? "Checking your email address"
                  : "Checking your phone number...");
          final result =
              await JWT.checkEmailPhone(isEmail ? email : phone, "NG", isEmail);
          Alert.hideLoading(context);
          if (result == "no_account") {
            if (isEmail) {
              Navigator.pushNamed(context, "/signup-account-info",
                  arguments: jsonEncode({"email": email}));
            } else {
              Navigator.pushNamed(context, "/signup-verify",
                  arguments: jsonEncode({"phone": phone}));
            }
          } else {
            Alert.show(context, "",
                "The ${isEmail ? "email address" : "phone number"} you provided is already in use! Please use another or login to proceed.");
          }
        } else {
          Alert.show(context, "",
              "Please agree with our terms and conditions to proceed.");
        }
      } else {
        Alert.show(
            context,
            "",
            isEmail
                ? "Please enter a valid email address to proceed."
                : "Please enter a valid phone number to proceed.");
      }
    } catch (err) {
      Alert.hideLoading(context);
      debugPrint(err.toString());
    }
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
                        Navigator.pushReplacementNamed(context, "/splash",
                            arguments: jsonEncode({"isDone": true}));
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
                      if (!isEmail)
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
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10.0),
                                    child: Widgets.buildText("+234", context,
                                        color: Palette.get('text.disabled')),
                                  ),
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
                      if (isEmail)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Email address", context,
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
                              signup();
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
                            onTap: () {
                              googleSignin();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Color(0x1A000000))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/login-google.jpeg",
                                      height: 24.0, fit: BoxFit.contain),
                                  const SizedBox(
                                    width: 5.0,
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
                                isEmail = !isEmail;
                              });
                              if (isEmail) {
                                phoneController.text = "";
                              } else {
                                emailController.text = "";
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Color(0x1A000000))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  if (!isEmail)
                                    Image.asset(
                                        "assets/images/login-email.jpeg",
                                        height: 30.0,
                                        fit: BoxFit.contain),
                                  if (isEmail)
                                    Helpers.fetchIcons("circle-phone", "solid",
                                        color: "main.primary", size: 24.0),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Widgets.buildText(
                                      isEmail ? "Phone" : "Email", context)
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
