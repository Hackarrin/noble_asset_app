import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cribsfinder/main.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/apis.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/fetch.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/webview.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:pointycastle/export.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static Future<String> readPref(String key) async {
    try {
      EncryptedSharedPreferences prefs =
          EncryptedSharedPreferences.getInstance();
      return prefs.getString(key) ?? "";
    } catch (err) {
      print(err);
    }
    return "";
  }

  static writePref(String key, String value) async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getToken() async {
    return await readPref(Defaults.userid);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    Map<String, dynamic> profile = {};
    try {
      final profileString = await Helpers.readPref(Defaults.profile);
      if (profileString.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(profileString);
        if (data.isNotEmpty) {
          profile = data;
        }
      }
    } catch (err) {
      print(err);
    }
    return profile;
  }

  static String getInitial(String title) {
    if (title.isEmpty) {
      return "";
    }
    String initials = title
        .toString()
        .split(" ")
        .where((name) => name.isNotEmpty)
        .map((name) => name[0])
        .join("")
        .toUpperCase();

    if (initials.length > 2) {
      return initials = initials[0] + initials[1];
    }
    return initials;
  }

  static Widget getPhoto(String photo,
      {height = 0,
      width = 0,
      text = "",
      String type = "",
      bool isInitials = false,
      double radius = 10.0}) {
    final def = Container(
      width: width == 0 ? null : width,
      height: height == 0 ? null : height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Palette.get("background.neutral")),
      child: Center(
        child: Widgets.buildText(
          isInitials ? getInitial(text) : text,
          navigatorKey.currentContext!,
          isBold: true,
          isCenter: true,
          size: 24.0,
        ),
      ),
    );
    if (photo.isNotEmpty && type.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: "${Defaults.sectionsImagesUrl[type]}${photo.toString()}",
          placeholder: (context, url) => def,
          errorWidget: (context, url, error) => def,
          height: height == 0 ? double.infinity : height,
          width: width == 0 ? double.infinity : height,
          fit: BoxFit.cover,
        ),
      );
    }
    return def;
  }

  static Widget getProfilePhoto(BuildContext context,
      {height = 140.0, profile = const {}}) {
    final initial = getInitial(
      profile.containsKey("name") ? profile["name"] : "",
    );
    final def = SizedBox(
      width: height,
      height: height,
      child: ClipOval(
        child: CircleAvatar(
          radius: height / 2.0,
          backgroundColor: Palette.getColor(context, "background", "neutral"),
          child: Widgets.buildText(initial, context,
              isBold: true,
              isCenter: true,
              size: height / 2.5,
              color: "main.primary"),
        ),
      ),
    );
    if (profile.containsKey('photo') && profile['photo'] != "") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(height / 2.0),
        child: CachedNetworkImage(
          imageUrl: "${API.assetUsers}${profile["photo"].toString()}",
          placeholder: (context, url) => def,
          errorWidget: (context, url, error) => def,
          height: height,
          width: height,
          fit: BoxFit.cover,
        ),
      );
    }
    return def;
  }

  static bool isNumeric(String str) {
    if (str.isEmpty) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static bool isEmail(String str) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(str);
  }

  static void updateCart(cart) {
    try {
      writePref("cart", jsonEncode(cart));
      updateCartServer();
    } catch (err) {
      //console.log(err);
    }
  }

  static void toHome(BuildContext context) async {
    List cart = [];
    final String storage = await Helpers.readPref("cart");
    if (storage.isNotEmpty) {
      cart = jsonDecode(storage);
    }
    if (cart.isNotEmpty) {
      Navigator.pushReplacementNamed(context, "/checkout");
    } else {
      final isLocationGranted = await Permission.location.isGranted;
      final isNotificatedGranted = await Permission.notification.isGranted;
      if (isLocationGranted) {
        if (isNotificatedGranted) {
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          Navigator.pushNamed(context, "/signup-notification");
        }
      } else {
        Navigator.pushNamed(context, "/signup-location");
      }
    }
  }

  static void addToCart(
      Map<String, dynamic> item, int listingType, Map<String, dynamic> options,
      {isBuyNow = true}) async {
    try {
      List cart = [];
      final String storage = await readPref("cart");
      if (storage.isNotEmpty) {
        cart = jsonDecode(storage);
      }
      print(cart);
      cart = cart
          .where((prd) =>
              prd["listingId"].toString() != prd["listingId"].toString())
          .toList();
      if (isBuyNow) {
        cart = cart.map((prd) => ({...prd, "isCheckout": false})).toList();
      }
      item["listingType"] = listingType;
      item["options"] = options;
      item["isCheckout"] = true;
      cart.add(item);
      print(cart);
      writePref("cart", jsonEncode(cart));
      updateCartServer();
      if (isBuyNow && navigatorKey.currentContext != null) {
        final userId = await Helpers.readPref(Defaults.userid);
        if (userId.isNotEmpty) {
          Navigator.pushNamed(navigatorKey.currentContext!, "/checkout");
        } else {
          Navigator.pushNamed(navigatorKey.currentContext!, "/login");
        }
      }
    } catch (err) {
      print(err);
    }
  }

  static void updateCartServer() {
    final items = readPref("cart");
    Fetch(API.cart, {
      "update": "",
      "items": items,
      "userToken": getToken(),
    }).load();
  }

  static String formatCurrency(String str,
      {isCompact = false, currency = "NGN", isShow = true}) {
    str = str == "null" ? "0" : str;
    if (isNumeric(str)) {
      str = isShow
          ? (isCompact
              ? intl.NumberFormat.compactSimpleCurrency(
                      locale: Platform.localeName, name: currency)
                  .format(num.tryParse(str)?.toDouble())
              : intl.NumberFormat.simpleCurrency(
                      locale: Platform.localeName, name: currency)
                  .format(num.tryParse(str)?.toDouble()))
          : "*******";
    }
    return str;
  }

  static double parseNumber(String str) {
    double number = 0;
    if (isNumeric(str)) {
      return num.tryParse(str)?.toDouble() ?? 0;
    }
    return number;
  }

  static bool hasTextOverflow(String text,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style:
              GoogleFonts.nunito(fontSize: 14.0, fontWeight: FontWeight.w400)),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: minWidth,
        maxWidth: MediaQuery.of(navigatorKey.currentContext!).size.width);
    return textPainter.didExceedMaxLines;
  }

  static int dateDiff(String dateFrom, String dateTo) {
    try {
      final format = intl.DateFormat('yyyy-MM-dd');
      final fromDate = format.parse(dateFrom);
      final toDate = format.parse(dateTo);
      return (toDate.difference(fromDate).inHours / 24).round();
    } catch (err) {
      print("dante - dateDiff - ${err}");
    }
    return 0;
  }

  static int hourDiff(String dateFrom, String dateTo) {
    try {
      final format = intl.DateFormat('yyyy-MM-dd HH:mm:ss');
      final fromDate = format.parse(dateFrom);
      final toDate = format.parse(dateTo);
      return toDate.difference(fromDate).inHours;
    } catch (err) {
      print("dante - dateDiff - ${err}");
    }
    return 0;
  }

  static String addHours(String str,
      {String formatString = "hh:mma", hours = 0}) {
    try {
      var inputFormat = intl.DateFormat("yyyy-MM-dd $formatString");
      var object = inputFormat.parse("2020-01-01 $str");

      if (hours > 0) {
        object = object.add(Duration(hours: hours));
      }
      inputFormat = intl.DateFormat(formatString);
      return inputFormat.format(object);
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  static String formatDateObject(DateTime str,
      {String formatString = "yyyy-MM-dd"}) {
    try {
      var outputFormat = intl.DateFormat(formatString);
      return outputFormat.format(str);
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  static String formatDate(String str, {String formatString = "yyyy-MM-dd"}) {
    if (str.isNotEmpty) {
      try {
        if (str == "today") {
          final date = DateTime.now();
          str =
              "${date.year}-${date.month > 9 ? date.month : "0${date.month}"}-${date.day}";
        }
        if (str == "week") {
          final date = DateTime.now();
          final weekStart = date.subtract(Duration(days: date.weekday - 1));
          str =
              "${weekStart.year}-${weekStart.month > 9 ? weekStart.month : "0${weekStart.month}"}-${weekStart.day}";
        }
        if (str == "month") {
          final date = DateTime.now();
          str =
              "${date.year}-${date.month > 9 ? date.month : "0${date.month}"}-01";
        }
        var inputFormat = intl.DateFormat(
            str.contains(" ") ? "yyyy-MM-dd HH:mm:ss" : 'yyyy-MM-dd');
        var inputDate = inputFormat.parse(str);

        var outputFormat = intl.DateFormat(formatString);
        return outputFormat.format(inputDate);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return str;
  }

  static DateTime parseDate(String str, {String formatString = "yyyy-MM-dd"}) {
    if (str.isNotEmpty) {
      try {
        var inputFormat = intl.DateFormat(formatString);
        return inputFormat.parse(str);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return DateTime.now();
  }

  static bool isWithinInterval(String str, String start, String end) {
    if (str.isNotEmpty) {
      try {
        var inputFormat = intl.DateFormat('yyyy-MM-dd');

        return inputFormat.parse(start).isBefore(inputFormat.parse(str)) &&
            inputFormat.parse(end).isAfter(inputFormat.parse(str));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return false;
  }

  static String formatDistanceDate(String startDate, String endDate) {
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      try {
        final inputFormat = intl.DateFormat('yyyy-MM-dd');

        final firstDate = inputFormat.parse(startDate);
        final secondDate = inputFormat.parse(endDate);

        String output = "";

        if (firstDate.year == secondDate.year) {
          if (firstDate.month == secondDate.month) {
            final outputFormat = intl.DateFormat('MMM');
            output =
                "${firstDate.day} ${outputFormat.format(firstDate)} - ${secondDate.day} ${outputFormat.format(firstDate)}";
          } else {
            final outputFormat = intl.DateFormat('dd MMM');
            output =
                "${outputFormat.format(firstDate)} - ${outputFormat.format(secondDate)}, ${firstDate.year}";
          }
        } else {
          final outputFormat = intl.DateFormat('dd MMM, yyyy');
          output =
              "${outputFormat.format(firstDate)} - ${outputFormat.format(secondDate)}";
        }
        return output;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return "$startDate - $endDate";
  }

  static String formatNumMonths(String date) {
    if (date.isNotEmpty) {
      try {
        final inputFormat = intl.DateFormat('yyyy-MM-dd');

        final firstDate = inputFormat.parse(date);
        final secondDate = DateTime.now();

        String output = "";

        if (firstDate.year == secondDate.year) {
          if (firstDate.month == secondDate.month) {
            output = secondDate.day - firstDate.day == 0
                ? " Just joined Cribsfinder"
                : "${secondDate.day - firstDate.day} day${(secondDate.day - firstDate.day) > 1 ? "s" : ""} on Cribsfinder";
          } else {
            output =
                "${secondDate.month - firstDate.month} month${(secondDate.month - firstDate.month) > 1 ? "s" : ""} on Cribsfinder";
          }
        } else {
          output =
              "${secondDate.year - firstDate.year} year${(secondDate.year - firstDate.year) > 1 ? "s" : ""} on Cribsfinder";
        }
        return output;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return "";
  }

  static String formatNumber(String str) {
    if (isNumeric(str)) {
      return intl.NumberFormat.decimalPattern()
          .format(num.tryParse(str)?.toDouble());
    }
    return str;
  }

  static Widget fetchIcons(String icon, String type,
      {size = 14.0, String color = "", Color? overrideColor}) {
    try {
      final colorSplit = color.toString().split(".");
      var palette =
          Palette.getColor(navigatorKey.currentContext!, "text", "primary");
      if (colorSplit.length == 2) {
        palette = Palette.getColor(
            navigatorKey.currentContext!, colorSplit[0], colorSplit[1]);
      }
      return SvgPicture.asset(
        "assets/svg/$type/${type == "regular" ? "fi-rr" : "fi-sr"}-$icon.svg",
        colorFilter:
            ColorFilter.mode(overrideColor ?? palette, BlendMode.srcIn),
        semanticsLabel: icon,
        width: size + .0,
        height: size + .0,
      );
    } catch (err) {
      print("dante - fetchIcons $err - $icon");
    }
    return SizedBox(height: size, width: size);
  }

  static List<T> flatten<T>(List<dynamic> list) =>
      [for (var sublist in list) ...sublist];

  static handleCalendarEntry(
      date, List entries, double defaultPrice, String roomId,
      {checkIsOpen = false}) {
    double price = defaultPrice;
    List items = [];
    List customItems = [];
    bool isOpen = false;
    try {
      items = date is List && date.length > 1
          ? entries
              .where((item) =>
                  roomId == item["roomType"].toString() &&
                  (isWithinInterval(date[0], item["dateFrom"].toString(),
                          item["dateTo"].toString()) ||
                      isWithinInterval(date[1], item["dateFrom"].toString(),
                          item["dateTo"].toString())))
              .toList()
          : entries
              .where((item) =>
                  roomId.toString() == item["roomType"].toString() &&
                  isWithinInterval(date is List ? date[0] : date,
                      item["dateFrom"].toString(), item["dateTo"].toString()))
              .toList();

      customItems = entries
          .where((item) =>
              item["customType"].toString().isNotEmpty &&
              item["customType"].toString() == "0")
          .toList();
      if (items.isNotEmpty) {
        final priceItems = items
            .where((item) =>
                item["type"].toString() == "1" &&
                item["dateFrom"].toString().isNotEmpty &&
                item["dateTo"].toString().isNotEmpty)
            .toList();
        if (priceItems.isNotEmpty) {
          // price
          final item = priceItems[0];
          price = num.tryParse(item["price"].toString())?.toDouble() ?? 0.0;
        }
        final availabilityItems =
            items.where((item) => item["type"].toString() == "0").toList();
        if (availabilityItems.isNotEmpty) {
          // availability
          final item = availabilityItems[0];
          price = 0;
          isOpen =
              (num.tryParse(item["isOpened"].toString())?.toInt() ?? 0) == 1;
        }
      } else if (customItems.isNotEmpty) {
        // check for weekend and custom prices
        final item = customItems[0];
        final customType =
            num.tryParse(item["customType"].toString())?.toInt() ?? 0;
        final customAmount =
            num.tryParse(item["amount"].toString())?.toDouble() ?? 0;

        // check for weekend
        final day = date is List
            ? (date[0] is String ? Helpers.parseDate(date[0]) : date[0])
                .getDay()
            : (date[0] == "string" ? Helpers.parseDate(date) : date).getDay();
        if (customType == 0 && (day == 5 || day == 6)) {
          price = customAmount;
        }
      }
    } catch (err) {
      price = defaultPrice;
    }
    return defaultPrice;
    // checkIsOpen ? isOpen : price;
  }

  static void openLink(String url, String title) async {
    if (navigatorKey.currentContext == null) {
      return;
    }
    try {
      var uri = Uri.parse(url);
      if (await canLaunchUrl(uri) || url.startsWith("http")) {
        if (url.startsWith("http")) {
          if (url.contains("cribsfinder.com") &&
              !url.contains("assets.cribsfinder.com")) {
            Navigator.push(
                navigatorKey.currentContext!,
                MaterialPageRoute(
                    builder: (context) => WebAccess(url: url, title: title)));
          } else {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } else {
          await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static dynamic updateWishlistValue(dynamic data, Map updatedListing) {
    try {
      final listingId = updatedListing["listingId"] ?? "";
      if (listingId.toString().isNotEmpty) {
        final favourite =
            (updatedListing["favourite"] ?? "0").toString() == "0" ? "1" : "0";
        if (data.runtimeType == List) {
          final newData = data
              .map((item) => {
                    ...item,
                    "favourite": listingId == item["listingId"].toString()
                        ? favourite
                        : item["favourite"]
                  })
              .toList();
          return newData;
        }
        final newData = data.map((key, value) {
          if (value.runtimeType == List) {
            final newValue = value
                .map((item) => {
                      ...item,
                      "favourite": listingId == item["listingId"].toString()
                          ? favourite
                          : item["favourite"]
                    })
                .toList();
            return MapEntry(key, newValue);
          }
          final newValue = value.map((innerKey, innerValue) {
            final newInnerValue = innerValue
                .map((item) => {
                      ...item,
                      "favourite": listingId == item["listingId"].toString()
                          ? favourite
                          : item["favourite"]
                    })
                .toList();
            return MapEntry(innerKey, newInnerValue);
          });
          return MapEntry(key, newValue);
        });
        return newData;
      }
    } catch (err) {
      print(err);
    }
    return data;
  }

  static wishlist(item, type) async {
    try {
      if (item["favourite"].toString() == "1") {
        JWT.removeWishlist(item["listingId"], type);
        Alert.show(
            navigatorKey.currentContext!, "", "Listing removed from wishlist",
            type: "success");
      } else {
        JWT.addWishlist(item["listingId"], type);
        Alert.show(
            navigatorKey.currentContext!, "", "Listing added to wishlist",
            type: "success");
      }
    } catch (err) {
      print(err);
    }
  }

  static logout({person = false}) async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences.getInstance();
    if (navigatorKey.currentContext != null) {
      JWT.logDevice(0);
    }
    if (person) {
      prefs.remove(Defaults.profile);
    }
    prefs.remove(Defaults.userid);
    if (navigatorKey.currentState != null && !person) {
      navigatorKey.currentState!.pushReplacementNamed("/login");
    }
  }

  static Future<AsymmetricKeyPair<PublicKey, PrivateKey>>
      generateRSAKeyPair() async {
    final secureRandom = SecureRandom('SHA256');
    var rsapars = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);
    var params = ParametersWithRandom(rsapars, secureRandom);
    var keyGenerator = RSAKeyGenerator();
    keyGenerator.init(params);
    return keyGenerator.generateKeyPair();
  }

  static genKey() async {
    final keyPair = await generateRSAKeyPair();
    final publicKey = keyPair.publicKey;
    final privateKey = keyPair.privateKey;
    print("key $privateKey");
    print("public $publicKey");
    // privKey
  }

  static Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
