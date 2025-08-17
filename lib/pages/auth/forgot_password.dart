import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/palette.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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

  void send() async {
    try {
      if (emailController.text.isEmpty ||
          !Helpers.isEmail(emailController.text)) {
        Alert.show(
            context, "", "Please enter a valid email address to proceed.",
            type: "success");
        return;
      }
      Alert.showLoading(context, "Requesting...");
      await JWT.requestPasswordReset(emailController.text);
      Alert.hideLoading(context);
      Navigator.pushNamed(context, "/forgot-reset-password");
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
                        "Forgot Password?",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Please enter the email address associated with your account and We will email you a link to reset your password.",
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
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  send();
                                },
                                style: Widgets.buildButton(context,
                                    vertical: 20.0,
                                    horizontal: 10.0,
                                    radius: 60.0,
                                    background: Palette.get("main.primary")),
                                child: Widgets.buildText("Proceed", context,
                                    color: "text.white",
                                    weight: 500,
                                    size: 16.0)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Widgets.buildText("Back to Login", context,
                            isUnderlined: true, color: "main.primary"),
                      )
                    ],
                  ),
                ],
              )),
        )));
  }
}
