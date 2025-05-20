import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with SingleTickerProviderStateMixin {
  var isVisible = false;
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleSubmit() async {
    try {
      if (passwordController.text.isEmpty ||
          newPasswordController.text.isEmpty) {
        Alert.show(context, "", "Please fill all required fields to proceed");
        return;
      }
      if (confirmPasswordController.text != newPasswordController.text) {
        Alert.show(context, "", "Please confirm your new password to proceed");
        return;
      }
      Alert.showLoading(context, "Updating...");
      await JWT.updateSettings({
        "cpassword": passwordController.text,
        "password": newPasswordController.text
      }, "password");
      Alert.hideLoading(context);
      Alert.show(context, "", "Password updated successfully!",
          type: "success");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("Reset Password", context, isMedium: true),
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xfff1f1f1), width: 1),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(left: 15.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Helpers.fetchIcons(
                "arrow-small-left",
                "solid",
                size: 24,
                color: "text.other",
              )),
        ),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Palette.get("background.paper"),
          ),
          padding: const EdgeInsets.only(
              bottom: 15.0, left: 15.0, right: 15.0, top: 20.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = {};
                  switch (index) {
                    case 0:
                      item = {
                        "label": "Current Password",
                        "controller": passwordController
                      };
                      break;
                    case 1:
                      item = {
                        "label": "New Password",
                        "controller": newPasswordController
                      };
                      break;
                    case 2:
                      item = {
                        "label": "Confirm Password",
                        "controller": confirmPasswordController
                      };
                      break;
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(item["label"].toString(), context,
                            color: 'text.primary', size: 13.0),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: item["controller"],
                          obscureText: !isVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: Widgets.inputDecoration("",
                              color: Color(0xFFF4F4F4),
                              isFilled: true,
                              isOutline: true,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Helpers.fetchIcons(
                                      isVisible ? "eye-crossed" : "eye",
                                      "regular",
                                      size: 18.0))),
                          style: GoogleFonts.nunito(
                              color: Color(0xCC757575),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                        ),
                        if (index == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/forgot-password");
                                },
                                child: Widgets.buildText(
                                    "Forgot Password?", context,
                                    isRight: true, color: "main.primary"),
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
                itemCount: 3,
              ),
              const SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      handleSubmit();
                    },
                    style: Widgets.buildButton(context,
                        background: Palette.get("main.primary"),
                        radius: 50.0,
                        vertical: 15.0),
                    child: Widgets.buildText("Reset Password", context,
                        isMedium: true, color: "text.white")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
