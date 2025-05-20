import 'dart:convert';

import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/palette.dart';

class SignupAccountInfo extends StatefulWidget {
  const SignupAccountInfo({Key? key}) : super(key: key);

  @override
  _SignupAccountInfoState createState() => _SignupAccountInfoState();
}

class _SignupAccountInfoState extends State<SignupAccountInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String phone = "";

  var isChecked = false;
  var isPasswordVisible = false;

  void signup() async {
    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        if (name.split(" ").length > 1) {
          if (Helpers.isEmail(email)) {
            Alert.showLoading(context, "Creating your account...");
            await JWT.signup({
              "firstName": name.split(" ")[0],
              "lastName": name.split(" ")[1],
              "country": "NG",
              "password": password,
              "phone": phone,
              "email": email,
            });
            Alert.hideLoading(context);
            Helpers.toHome(context);
          } else {
            Alert.show(
                context, "", "Please provide a valid email address to proceed.",
                type: "warning");
          }
        } else {
          Alert.show(context, "",
              "Please provide your first and last names to proceed.",
              type: "warning");
        }
      } else {
        Alert.show(context, "",
            "Please fill all the required fields above to proceed.",
            type: "warning");
      }
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        final data = jsonDecode(arguments.toString());
        setState(() {
          phone = data["phone"] ?? "";
          emailController.text = data["email"] ?? "";
        });
      }
    });
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
                      Widgets.buildText("Finish your account creation", context,
                          isMedium: true, size: 24.0, weight: 500, lines: 2),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Fill your information below to finish your account creation.",
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
                          Widgets.buildText("Full Name", context,
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
                            keyboardType: TextInputType.name,
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
                            keyboardType: TextInputType.visiblePassword,
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
                              signup();
                            },
                            style: Widgets.buildButton(context,
                                vertical: 20.0,
                                horizontal: 10.0,
                                radius: 60.0,
                                background: Palette.get("main.primary")),
                            child: Widgets.buildText("Proceed", context,
                                color: "text.white", weight: 500, size: 16.0)),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          Widgets.buildText(
                              "Already have an account?   ", context,
                              color: "text.secondary"),
                          Widgets.buildText("Sign In", context,
                              isUnderlined: true, color: "main.primary"),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        )));
  }
}
