import 'package:flutter/scheduler.dart';
import 'package:nobleassets/pages/account/message.dart';
import 'package:nobleassets/pages/account/messages.dart';
import 'package:nobleassets/pages/account/next_of_kin.dart';
import 'package:nobleassets/pages/account/social.dart';
import 'package:nobleassets/pages/auth/splash.dart';
import 'package:nobleassets/pages/auth/login.dart';
import 'package:nobleassets/pages/auth/create_account/get_started.dart';
import 'package:nobleassets/pages/auth/create_account/location.dart';
import 'package:nobleassets/pages/auth/create_account/notification.dart';
import 'package:nobleassets/pages/auth/forgot_password.dart';
import 'package:nobleassets/pages/auth/reset_password.dart';
import 'package:nobleassets/pages/auth/create_account/signup_verify.dart';
import 'package:nobleassets/pages/auth/create_account/complete_profile.dart';
import 'package:nobleassets/pages/auth/create_account/account_info.dart';
import 'package:nobleassets/pages/auth/create_account/signup.dart';

import 'package:nobleassets/pages/checkout.dart';
import 'package:nobleassets/pages/account/booking.dart';
import 'package:nobleassets/pages/account/account.dart';
import 'package:nobleassets/pages/account/identification.dart';
import 'package:nobleassets/pages/account/security.dart';
import 'package:nobleassets/pages/account/reset_password.dart';
import 'package:nobleassets/pages/account/bvn.dart';
import 'package:nobleassets/pages/account/compliance.dart';
import 'package:nobleassets/pages/account/2fa.dart';
import 'package:nobleassets/pages/account/devices.dart';
import 'package:nobleassets/pages/account/device_preferences.dart';
import 'package:nobleassets/pages/account/settings.dart';
import 'package:nobleassets/pages/account/reviews.dart';
import 'package:nobleassets/pages/account/statements.dart';
import 'package:nobleassets/pages/account/wallet.dart';
import 'package:nobleassets/pages/account/wallet-add-account.dart';
import 'package:nobleassets/pages/account/referral.dart';
import 'package:nobleassets/pages/account/referral_overview.dart';
import 'package:nobleassets/pages/account/transactions.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'pages/home.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await PusherBeams.instance.start(Defaults.pusherBeamKey);

  await EncryptedSharedPreferences.initialize(Defaults.prefKey);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;
  void check() async {
    String pref = await Helpers.readPref("enable_dark");
    if (pref == "") {
      //new device set type
      pref = SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light
          ? "0"
          : "1";
      Helpers.writePref("enable_dark", pref);
    }
    setState(() => _isDark = pref == "1");
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      title: 'Noble Assets',
      routes: {
        "/checkout": (context) => const Checkout(),
        "/booking": (context) => const Booking(),
        "/account": (context) => const Account(),
        "/identification": (context) => const Identification(),
        "/security": (context) => const Security(),
        "/reset-password": (context) => const ResetPassword(),
        "/nok": (context) => const NextOfKin(),
        "/compliance": (context) => const Compliance(),
        "/bvn": (context) => const BVN(),
        "/2fa": (context) => const TwoFa(),
        "/devices": (context) => const Devices(),
        "/device-preferences": (context) => const DevicePreferences(),
        "/settings": (context) => const Settings(),
        "/messages": (context) => const Messages(),
        "/message": (context) => const Message(),
        "/reviews": (context) => const Reviews(),
        "/statements": (context) => const Statements(),
        "/wallet": (context) => const Wallet(),
        "/referrals": (context) => const Referrals(),
        "/add-wallet-account": (context) => const AddWalletAccount(),
        "/referral-overview": (context) => const ReferralOverview(),
        "/transactions": (context) => const Transactions(),
        "/home": (context) => const Home(),
        "/splash": (context) => const Splash(),
        "/login": (context) => const Login(),
        "/signup": (context) => const Signup(),
        "/signup-verify": (context) => const SignupVerify(),
        "/signup-welcome": (context) => const Welcome(),
        "/signup-location": (context) => const SignupLocation(),
        "/signup-notification": (context) => const SignupNotification(),
        "/signup-complete-profile": (context) => const SignupCompleteProfile(),
        "/forgot-password": (context) => const ForgotPassword(),
        "/forgot-reset-password": (context) => const ResetForgotPassword(),
        "/get-started": (context) => const GetStarted(),
        "/social": (context) => const Social(),
      },
      theme: _buildTheme(Brightness.light, context),
      darkTheme: _buildTheme(Brightness.dark, context),
      home: const Splash(),
    );
  }

  void changeTheme(isDark) {
    setState(() {
      _isDark = isDark;
    });
  }
}

ThemeData _buildTheme(brightness, context) {
  var baseTheme = ThemeData(brightness: brightness);
  return baseTheme.copyWith(
    textTheme: GoogleFonts.nunitoSansTextTheme(baseTheme.textTheme),
    primaryColor:
        Palette.getColor(context, "main", "primary", mode: brightness),
    canvasColor:
        Palette.getColor(context, "background", "paper", mode: brightness),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
            secondary: Palette.getColor(context, "main", "secondary",
                mode: brightness),
            brightness: brightness)
        .copyWith(
          primary:
              Palette.getColor(context, "main", "primary", mode: brightness),
          surface: Palette.getColor(context, "background", "paper",
              mode: brightness),
        ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));

  bool get containsLowercase => contains(RegExp(r'[a-z]'));

  bool get containsNumbers => contains(RegExp(r'[0-9]'));
}
