import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
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
                        "Verify Code",
                        context,
                        isMedium: true,
                        size: 24.0,
                        weight: 500,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          "Enter the code we sent over SMS to +234 09039525697",
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
                              defaultBorderColor: Colors.transparent,
                              hasTextBorderColor:
                                  Palette.getColor(context, "main", "primary"),
                              highlightColor:
                                  Palette.getColor(context, "main", "primary"),
                              maxLength: 6,
                              pinBoxWidth: 50,
                              pinBoxHeight: 50,
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
                            onTap: () {},
                            child: Widgets.buildText("Resend", context,
                                isUnderlined: true, color: "main.primary"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Widgets.buildText("More option", context,
                            isUnderlined: true, weight: 500),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/signup-account-info");
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
