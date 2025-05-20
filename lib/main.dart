import 'package:cribsfinder/pages/auth/splash.dart';
import 'package:cribsfinder/pages/auth/login.dart';
import 'package:cribsfinder/pages/auth/create_account/get_started.dart';
import 'package:cribsfinder/pages/auth/create_account/location.dart';
import 'package:cribsfinder/pages/auth/create_account/notification.dart';
import 'package:cribsfinder/pages/auth/forgot_password.dart';
import 'package:cribsfinder/pages/auth/reset_password.dart';
import 'package:cribsfinder/pages/auth/create_account/signup_verify.dart';
import 'package:cribsfinder/pages/auth/create_account/complete_profile.dart';
import 'package:cribsfinder/pages/auth/create_account/account_info.dart';
import 'package:cribsfinder/pages/auth/create_account/signup.dart';
import 'package:cribsfinder/pages/hotels/hotel_categories.dart';
import 'package:cribsfinder/pages/hotels/hotel_filter.dart';
import 'package:cribsfinder/pages/hotels/hotel_search.dart';
import 'package:cribsfinder/pages/hotels/hotel_nearby.dart';
import 'package:cribsfinder/pages/hotels/hotel_recommended.dart';
import 'package:cribsfinder/pages/hotels/hotel_top_destinations.dart';
import 'package:cribsfinder/pages/hotels/hotel.dart';

import 'package:cribsfinder/pages/shortlets/shortlet_search.dart';
import 'package:cribsfinder/pages/shortlets/shortlet_filter.dart';
import 'package:cribsfinder/pages/shortlets/shortlet_categories.dart';
import 'package:cribsfinder/pages/shortlets/shortlet_recommended.dart';
import 'package:cribsfinder/pages/shortlets/shortlet_nearby.dart';
import 'package:cribsfinder/pages/shortlets/shortlet_top_destinations.dart';
import 'package:cribsfinder/pages/shortlets/shortlet.dart';

import 'package:cribsfinder/pages/events/event_categories.dart';
import 'package:cribsfinder/pages/events/events_today.dart';
import 'package:cribsfinder/pages/events/event_search.dart';
import 'package:cribsfinder/pages/events/event_filter.dart';
import 'package:cribsfinder/pages/events/event.dart';

import 'package:cribsfinder/pages/attractions/attraction_categories.dart';
import 'package:cribsfinder/pages/attractions/attractions_explore.dart';
import 'package:cribsfinder/pages/attractions/attraction_filter.dart';
import 'package:cribsfinder/pages/attractions/attraction.dart';

import 'package:cribsfinder/pages/automobile/automobile_filter.dart';
import 'package:cribsfinder/pages/automobile/automobile_search.dart';
import 'package:cribsfinder/pages/automobile/automobile_categories.dart';
import 'package:cribsfinder/pages/automobile/automobile_recommended.dart';
import 'package:cribsfinder/pages/automobile/automobile.dart';

import 'package:cribsfinder/pages/cruise/cruise_filter.dart';
import 'package:cribsfinder/pages/cruise/cruise_search.dart';
import 'package:cribsfinder/pages/cruise/cruise_categories.dart';
import 'package:cribsfinder/pages/cruise/cruise_recommended.dart';
import 'package:cribsfinder/pages/cruise/cruise.dart';

import 'package:cribsfinder/pages/property/filter.dart';
import 'package:cribsfinder/pages/property/search.dart';
import 'package:cribsfinder/pages/property/categories.dart';
import 'package:cribsfinder/pages/property/recommended.dart';
import 'package:cribsfinder/pages/property/property.dart';
import 'package:cribsfinder/pages/property/top_agents.dart';
import 'package:cribsfinder/pages/property/nearby.dart';

import 'package:cribsfinder/pages/checkout.dart';
import 'package:cribsfinder/pages/account/booking.dart';
import 'package:cribsfinder/pages/account/account.dart';
import 'package:cribsfinder/pages/account/edit_profile.dart';
import 'package:cribsfinder/pages/account/security.dart';
import 'package:cribsfinder/pages/account/reset_password.dart';
import 'package:cribsfinder/pages/account/change_pin.dart';
import 'package:cribsfinder/pages/account/pin.dart';
import 'package:cribsfinder/pages/account/2fa.dart';
import 'package:cribsfinder/pages/account/devices.dart';
import 'package:cribsfinder/pages/account/device_preferences.dart';
import 'package:cribsfinder/pages/account/notifications.dart';
import 'package:cribsfinder/pages/account/reviews.dart';
import 'package:cribsfinder/pages/account/payment_method.dart';
import 'package:cribsfinder/pages/account/wallet.dart';
import 'package:cribsfinder/pages/account/wallet-add-account.dart';
import 'package:cribsfinder/pages/account/referral.dart';
import 'package:cribsfinder/pages/account/referral_overview.dart';
import 'package:cribsfinder/pages/account/transactions.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/palette.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Cribsfinder',
      routes: {
        '/hotel-search': (context) => const HotelSearch(),
        '/hotel-filter': (context) => const HotelFilter(),
        "/hotel-categories": (context) => const HotelCategories(),
        "/hotel-nearby": (context) => const HotelNearby(),
        "/hotel-recommended": (context) => const HotelRecommended(),
        "/hotel-destinations": (context) => const HotelTopDestinations(),
        "/hotel": (context) => const Hotel(),
        '/shortlet-search': (context) => const ShortletSearch(),
        '/shortlet-filter': (context) => const ShortletFilter(),
        '/shortlet-categories': (context) => const ShortletCategories(),
        "/shortlet-recommended": (context) => const ShortletRecommended(),
        "/shortlet-nearby": (context) => const ShortletNearby(),
        "/shortlet-destinations": (context) => const ShortletTopDestinations(),
        '/event-categories': (context) => const EventCategories(),
        '/events-today': (context) => const EventsToday(),
        '/events-search': (context) => const EventSearch(),
        '/event-filter': (context) => const EventFilter(),
        '/attraction-categories': (context) => const AttractionCategories(),
        '/attraction-explore': (context) => const AttractionExplore(),
        '/attraction-filter': (context) => const AttractionFilter(),
        '/attraction': (context) => const Attraction(),
        '/automobile-search': (context) => const AutomobileSearch(),
        '/automobile-filter': (context) => const AutomobileFilter(),
        '/automobile-brands': (context) => const AutomobileCategories(),
        '/automobile-recommended': (context) => const AutomobileRecommended(),
        '/cruise-search': (context) => const CruiseSearch(),
        '/cruise-filter': (context) => const CruiseFilter(),
        '/cruise-categories': (context) => const CruiseCategories(),
        '/cruise-recommended': (context) => const CruiseRecommended(),
        '/property-search': (context) => const PropertySearch(),
        '/property-filter': (context) => const PropertyFilter(),
        '/property-categories': (context) => const PropertyCategories(),
        '/property-recommended': (context) => const PropertyRecommended(),
        '/property-top-agents': (context) => const PropertyTopAgents(),
        '/property-nearby': (context) => const PropertyNearby(),
        '/property': (context) => const Property(),
        '/cruise': (context) => const Cruise(),
        '/automobile': (context) => const Automobile(),
        '/event': (context) => const Event(),
        "/shortlet": (context) => const Shortlet(),
        "/checkout": (context) => const Checkout(),
        "/booking": (context) => const Booking(),
        "/account": (context) => const Account(),
        "/edit-profile": (context) => const EditProfile(),
        "/security": (context) => const Security(),
        "/reset-password": (context) => const ResetPassword(),
        "/pin": (context) => const TransactionPin(),
        "/change-pin": (context) => const ChangeTransactionPin(),
        "/2fa": (context) => const TwoFa(),
        "/devices": (context) => const Devices(),
        "/device-preferences": (context) => const DevicePreferences(),
        "/notifications": (context) => const Notifications(),
        "/reviews": (context) => const Reviews(),
        "/payment-method": (context) => const PaymentMethod(),
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
        "/signup-account-info": (context) => const SignupAccountInfo(),
        "/signup-location": (context) => const SignupLocation(),
        "/signup-notification": (context) => const SignupNotification(),
        "/signup-complete-profile": (context) => const SignupCompleteProfile(),
        "/forgot-password": (context) => const ForgotPassword(),
        "/forgot-reset-password": (context) => const ResetForgotPassword(),
        "/get-started": (context) => const GetStarted(),
      },
      theme: _buildTheme(Brightness.light, context),
      darkTheme: _buildTheme(Brightness.dark, context),
      home: const Splash(),
    );
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
