import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
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
                        "Continue with email",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Fill your information below or continue with google or Phone Number.",
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
                            readOnly: true,
                            decoration: Widgets.inputDecoration(
                              "",
                              color: Color(0x99F4F4F4),
                              isFilled: true,
                              isOutline: true,
                            ),
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
                            keyboardType: TextInputType.phone,
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
                              Helpers.openLink("https://useafritas.com/terms",
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
                              Navigator.pushNamed(context, "/signup-location");
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
