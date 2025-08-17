import 'dart:convert';

import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

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
  var name = "";
  var profileEmail = "";

  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticate = false;
  List<BiometricType> availableBiometrics = [];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  void login() async {
    try {
      final email =
          isAlreadyLoggedIn ? profileEmail : emailController.text.trim();
      final phone = phoneController.text.replaceAll(" ", "").trim();
      final password = passwordController.text;
      print("response $email");

      if (email.isNotEmpty && (method == "biometric" || password.isNotEmpty)) {
        if (Helpers.isEmail(email) || phone.isNotEmpty) {
          Alert.showLoading(context, "Logging you in...");
          await JWT
              .login({"password": password, "email": email, "method": method});
          Alert.hideLoading(context);
          Helpers.toHome(context);
        } else {
          Alert.show(
              context, "", "Please provide a valid email address to proceed.",
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

  void checkFinger() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to login to account.',
          options: const AuthenticationOptions(biometricOnly: true));
      if (didAuthenticate) {
        setState(() {
          method = "biometric";
        });
        login();
      } else {
        Alert.show(context, "Login Error!",
            "Biometric authentication failed! Please try again or login with your password.");
      }
    } on PlatformException {
      Alert.show(context, "Login Error!",
          "Biometric authentication failed! Please try again or login with your password.");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final profile = await Helpers.getProfile(key: "profile");
      if (profile.isNotEmpty) {
        setState(() {
          name = profile["fname"].toString();
          profileEmail = profile["email"].toString();
          isAlreadyLoggedIn = true;
        });
        final bool canAuthenticateWithBiometrics =
            await auth.canCheckBiometrics;
        bool isBiometricEnabled =
            (num.tryParse(await Helpers.readPref(Defaults.isBiometricLogin))
                        ?.toInt() ??
                    0) ==
                1;
        availableBiometrics = await auth.getAvailableBiometrics();
        bool _canAuthenticate =
            (canAuthenticateWithBiometrics || await auth.isDeviceSupported()) &&
                isBiometricEnabled;
        setState(() => canAuthenticate = _canAuthenticate);
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
                  left: 20.0, right: 20.0, top: 0.0, bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, "/home",
                                  arguments: jsonEncode({"isDone": true}));
                            },
                            child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border:
                                        Border.all(color: Color(0xFFF1F1F1))),
                                child: UnconstrainedBox(
                                  child: Helpers.fetchIcons("cross", "solid",
                                      color: "text.secondary", size: 14.0),
                                ))),
                      ),
                      const SizedBox(height: 40.0),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 80.0,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40.0),
                      Widgets.buildText(
                        isAlreadyLoggedIn
                            ? "Welcome Back, $name"
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
                            Widgets.buildText("Phone Number", context,
                                color: 'text.primary', size: 13.0, weight: 500),
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextField(
                              controller: phoneController,
                              decoration: Widgets.inputDecoration(
                                "",
                                color: Color(0x99F4F4F4),
                                isFilled: true,
                                isOutline: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 10.0),
                                  child: Widgets.buildText("+234", context,
                                      color: Palette.get('text.disabled')),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.nunito(
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
                            autocorrect: false,
                            style: GoogleFonts.nunito(
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
                                  login();
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
                          if (isAlreadyLoggedIn && canAuthenticate)
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  checkFinger();
                                },
                                child: Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(56.0),
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
                            Navigator.pushNamed(context, "/signup");
                          }
                        },
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Widgets.buildText(
                                isAlreadyLoggedIn
                                    ? "No, I am not $name.    "
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
