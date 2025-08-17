import 'dart:convert';

import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../utils/palette.dart';

class SignupVerify extends StatefulWidget {
  const SignupVerify({Key? key}) : super(key: key);

  @override
  _SignupVerifyState createState() => _SignupVerifyState();
}

class _SignupVerifyState extends State<SignupVerify> {
  final TextEditingController controller = TextEditingController();

  String phone = "";
  String name = "";

  void resendPhoneCode() async {
    try {
      Alert.showLoading(context, "Sending...");
      await JWT.sendVerifyCode();
      Alert.show(context, "", "Verification code has been sent!",
          type: "success");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  void verify() async {
    try {
      final code = controller.text;
      if (code.isNotEmpty) {
        Alert.showLoading(context, "Verifying...");
        await JWT.verifyAccount(code);
        Alert.hideLoading(context);
        Navigator.pushNamed(
          context,
          "/signup-welcome",
        );
      } else {
        Alert.show(context, "", "Please provide a valid code to proceed",
            type: "warning");
      }
    } catch (err) {
      Alert.hideLoading(context);
      Alert.show(context, "", err.toString(), type: "error");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final profile = await Helpers.getProfile(key: "profile");
      setState(() {
        name = profile["fname"].toString();
      });
      resendPhoneCode();
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
                      Widgets.buildText(
                        "Verify Your Account, $name",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Enter the code we sent to your email address and phone number.",
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
                                  Palette.get("background.textfield"),
                              hasTextBorderColor:
                                  Palette.getColor(context, "main", "primary"),
                              highlightColor:
                                  Palette.getColor(context, "main", "primary"),
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
                              resendPhoneCode();
                            },
                            child: Widgets.buildText("Resend", context,
                                isUnderlined: true, color: "main.primary"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              verify();
                            },
                            style: Widgets.buildButton(context,
                                vertical: 20.0,
                                horizontal: 10.0,
                                radius: 60.0,
                                background: Palette.get("main.primary")),
                            child: Widgets.buildText("Verify", context,
                                color: "text.white", weight: 500, size: 16.0)),
                      ),
                    ],
                  ),
                ],
              )),
        )));
  }
}
