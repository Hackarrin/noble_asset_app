import 'dart:convert';

import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
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
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController referrerController = TextEditingController();

  List<Map<String, String>> rules = [
    {"title": "Password must contain uppercase letters.", "value": "0"},
    {"title": "Password must contain lowercase letters.", "value": "0"},
    {"title": "Password must contain numbers.", "value": "0"},
    {"title": "Password must be at least 8 characters long.", "value": "0"},
  ];

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

  void signup() async {
    final phone = phoneController.text;
    final email = emailController.text;
    final firstName = fNameController.text;
    final lastName = lNameController.text;
    final middleName = mNameController.text;
    final password = passwordController.text;
    final ref = referrerController.text;
    try {
      if (email.isNotEmpty &&
          phone.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          password.isNotEmpty) {
        if (isChecked) {
          final unruly = rules.every((element) => element["value"] == "1");
          if (unruly) {
            if (password == cPasswordController.text) {
              Alert.showLoading(context, "Signing you up...");
              
              await JWT.signup({
                "firstName": firstName,
                "lastName": lastName,
                "middleName": middleName,
                "email": email,
                "phone": phone,
                "password": password,
                "referrer": ref
              });
              Alert.hideLoading(context);
              Helpers.toHome(context);
            } else {
              throw Exception(
                  "Confirm your password and make sure they match to proceed.");
            }
          } else {
            throw Exception("Some password rules have not been met!");
          }
        } else {
          throw Exception(
              "Please agree to our terms and conditions to proceed.");
        }
      } else {
        throw Exception("Please fill all required fields to proceed.");
      }
    } catch (err) {
      Alert.hideLoading(context);
      Alert.show(context, "", err.toString());
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
                  const SizedBox(height: 20.0),
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
                          "Sign up today and begin the journey of safety and value addition of your investment.",
                          context,
                          lines: 10,
                          isCenter: true,
                          color: "text.secondary"),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText("First name", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: fNameController,
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
                          Widgets.buildText(
                              "Please ensure you use your actual first name as stated in your BVN for verification purposes.",
                              context,
                              lines: 3,
                              size: 12.0,
                              color: "text.disabled")
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText("Middle name (optional)", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: mNameController,
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
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText("Last name", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: lNameController,
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
                          Widgets.buildText(
                              "Please ensure you use your actual last name as stated in your BVN for verification purposes.",
                              context,
                              lines: 3,
                              size: 12.0,
                              color: "text.disabled")
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
                      const SizedBox(
                        height: 15.0,
                      ),
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
                            onChanged: (value) {
                              setState(() {
                                rules[0]["value"] =
                                    value.containsUppercase ? "1" : "0";
                                rules[1]["value"] =
                                    value.containsLowercase ? "1" : "0";
                                rules[2]["value"] =
                                    value.containsNumbers ? "1" : "0";
                                rules[3]["value"] =
                                    value.length >= 8 ? "1" : "0";
                              });
                            },
                            style: GoogleFonts.nunito(
                                color: Color(0xFF757575),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            height: 70,
                            child: Column(
                              children: <Widget>[
                                for (var rule in rules)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Widgets.buildText(
                                          rule["title"] ?? "", context,
                                          size: 12.0,
                                          color: rule["value"] == "1"
                                              ? 'success.main'
                                              : 'text.disabled',
                                          isBold: true),
                                      (rule["value"] == "1"
                                          ? Icon(
                                              Icons.done_all_rounded,
                                              color: Palette.getColor(
                                                  context, "success", "main"),
                                              size: 16.0,
                                            )
                                          : const SizedBox(width: 1.0)),
                                    ],
                                  )
                              ],
                            ),
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
                          Widgets.buildText("Confirm your password", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: cPasswordController,
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
                          Widgets.buildText("Referrer (optional)", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: referrerController,
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
                          Widgets.buildText(
                              "Please provide your referrer's email address or code if applicable.",
                              context,
                              lines: 3,
                              size: 12.0,
                              color: "text.disabled")
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      FittedBox(
                        child: Row(
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
                                Helpers.openLink(
                                    "https://nobleassets.com/terms",
                                    "Terms & Conditions");
                              },
                              child: Widgets.buildText(
                                  "Terms & Condition", context,
                                  isUnderlined: true, color: "main.primary"),
                            ),
                            Widgets.buildText(" and ", context),
                            GestureDetector(
                              onTap: () {
                                Helpers.openLink(
                                    "https://nobleassets.com/privacy",
                                    "Privacy Policy");
                              },
                              child: Widgets.buildText(
                                  "Privacy Policy", context,
                                  isUnderlined: true, color: "main.primary"),
                            ),
                          ],
                        ),
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
