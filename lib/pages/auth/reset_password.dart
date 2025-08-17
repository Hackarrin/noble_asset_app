import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../utils/palette.dart';

class ResetForgotPassword extends StatefulWidget {
  const ResetForgotPassword({Key? key}) : super(key: key);

  @override
  _ResetForgotPasswordState createState() => _ResetForgotPasswordState();
}

class _ResetForgotPasswordState extends State<ResetForgotPassword> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  var isPasswordVisible = false;

  List<Map<String, String>> rules = [
    {"title": "Password must contain uppercase letters.", "value": "0"},
    {"title": "Password must contain lowercase letters.", "value": "0"},
    {"title": "Password must contain numbers.", "value": "0"},
    {"title": "Password must be at least 8 characters long.", "value": "0"},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void process() async {
    try {
      if (controller.text.isEmpty) {
        Alert.show(
            context, "", "Please enter your password reset code to proceed.",
            type: "error");
        return;
      }
      final unruly = rules.every((element) => element["value"] == "1");
      if (unruly) {
        if (passwordController.text == cPasswordController.text) {
          Alert.showLoading(context, "Please wait...");
          await JWT.resetPassword(
              {"code": controller.text, "password": passwordController.text});
          Alert.hideLoading(context);
          Navigator.pushReplacementNamed(context, "/login");
          Alert.show(context, "", "Your password has been reset!");
        } else {
          Alert.show(context, "", "Please confirm your password to proceed.",
              type: "error");
        }
      } else {
        Alert.show(context, "", "Some password rules have not been met!",
            type: "error");
      }
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
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
                        "Reset Password",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Please enter the password reset code sent to you and your new password to proceed",
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
                          Widgets.buildText("Enter Code", context,
                              color: 'text.primary', size: 13.0, weight: 500),
                          const SizedBox(
                            height: 5.0,
                          ),
                          PinCodeTextField(
                              autofocus: true,
                              highlight: true,
                              pinBoxColor: Palette.getColor(
                                  context, "background", "default"),
                              pinBoxRadius: 10.0,
                              controller: controller,
                              defaultBorderColor:
                                  Palette.get("background.neutral"),
                              hasTextBorderColor:
                                  Palette.getColor(context, "main", "primary"),
                              highlightColor:
                                  Palette.getColor(context, "main", "primary"),
                              pinBoxBorderWidth: 2.0,
                              maxLength: 4,
                              pinBoxWidth: 60,
                              pinBoxHeight: 60,
                              wrapAlignment: WrapAlignment.center,
                              pinTextStyle: GoogleFonts.nunito(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Palette.getColor(
                                      context, "text", "secondary"))),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Widgets.buildText(
                              "Didn't received the code? ", context,
                              color: "text.secondary"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/forgot-password");
                            },
                            child: Widgets.buildText("Resend", context,
                                isUnderlined: true, color: "main.primary"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText("New Password", context,
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
                          Widgets.buildText("Confirm Password", context,
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
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              process();
                            },
                            style: Widgets.buildButton(context,
                                vertical: 20.0,
                                horizontal: 10.0,
                                radius: 60.0,
                                background: Palette.get("main.primary")),
                            child: Widgets.buildText("Reset Password", context,
                                color: "text.white", weight: 500, size: 16.0)),
                      ),
                    ],
                  ),
                ],
              )),
        )));
  }
}
