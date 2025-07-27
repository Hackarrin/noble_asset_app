import 'dart:convert';
import 'dart:io';

import 'package:cribsfinder/utils/apis.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/fetch.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:device_info_plus/device_info_plus.dart';

class JWT {
  static checkEmailPhone(phone, country, bool isEmail) async {
    final response = await Fetch(API.userLogin, {
      (isEmail ? "checkEmail" : "checkPhone"): phone,
      "country": country,
    }).load();
    return response["status"].toString();
  }

  static verifyAccount(code, method, recipient, country) async {
    final response = await Fetch(API.userLogin, {
      "code": code,
      "method": method,
      "recipient": recipient,
      "country": country,
      "verify": "",
    }).load();
    final status = response["status"].toString();
    final data = response["data"] ?? {};
    if (status != "success") {
      if (status == "expired_code") {
        throw Exception(
            "Your verification code has expired! Please request and try again.");
      } else if (status == "invalid_code") {
        throw Exception(
            "Your verification code is invalid! Please confirm and try again.");
      } else if (status == "used_code") {
        throw Exception(
            "Your verification code has already been used! Please confirm and try again.");
      } else {
        throw Exception(
            "Something went wrong while verifying your account! Please confirm and try again.");
      }
    } else if (method == "email") {
      Helpers.writePref(Defaults.profile, jsonEncode(data));
    } else {
      return data;
    }
  }

  static sendVerifyCode(recipient, country, method) async {
    final response = await Fetch(API.userLogin, {
      "send": "",
      "recipient": recipient,
      "country": country,
      "method": method,
    }).load();

    if (response["status"].toString() != "success") {
      throw Exception("Something went wrong! Please try again later.");
    }
  }

  static logDevice(status) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    String type = "";
    String name = "";
    String os = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      type = "3";
      name = "${androidInfo.brand} ${androidInfo.model}";
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      os = "Android $release (SDK $sdkInt)";
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "";
      type = "4";
      name = iosInfo.name ?? "";
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      os = "$systemName $version";
    }
    Fetch(API.userLogin, {
      "name": name,
      "os": os,
      "deviceId": deviceId,
      "status": status,
      "type": type,
    }).load();
  }

  static signup(values) async {
    final response = await Fetch(API.userSignup, values).load();
    final status = response["status"] ?? "";
    final data = response["data"] ?? {};
    final token = response["token"] ?? "";

    if (status == "success") {
      Helpers.writePref(Defaults.userid, token);
      Helpers.writePref(Defaults.profile, jsonEncode(data));
      logDevice(1);
      return true;
    }
    if (status == "email_taken") {
      throw Exception(
          "The email address you provided is already in use. Please confirm and try again.");
    }
    throw Exception(
        "An error occured while we were signing you up! We apologize for this. Please try again later.");
  }

  static login(values) async {
    final response = await Fetch(API.userLogin, values).load();
    final status = response["status"] ?? "";
    final data = response["data"] ?? {};
    final token = response["token"] ?? "";
    if (status == "success") {
      Helpers.writePref(Defaults.userid, token);
      Helpers.writePref(Defaults.profile, jsonEncode(data));
      logDevice(1);
      return;
    }
    if (response["status"] == "invalid_login") {
      throw Exception(
          "Invalid email address or password! Please confirm and try again");
    }
    if (response["status"] == "suspended") {
      throw Exception(
          "Your account has been placed on hold! Please contact support.");
    }
    throw Exception(
        "An error occured while we were logging you in! We apologize for this. Please try again later.");
  }

  static Future<Map<String, dynamic>> getHome(String category) async {
    final response = await Fetch(API.home,
        {"userToken": await Helpers.getToken(), "category": category}).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    throw Exception(
        "An error has occured! We apologize for this. Please try again later.");
  }

  static fetchWallet(values) async {
    final response = await Fetch(API.wallet, values).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "invalid_login") {
      throw Exception(
          "Invalid email address or password! Please confirm and try again");
    }
    if (response["status"] == "suspended") {
      throw Exception(
          "Your account has been suspended! Please contact support to proceed");
    }
    throw Exception(
        "An error occured while we were verifying your account! We apologize for this. Please try again later.");
  }

  static requestPasswordReset(email) async {
    final response = await Fetch(API.forgot, {"email": email}).load();
    if (response["status"] == "success") {
      return true;
    }
    throw Exception(
        "Your email address is incorrect! Please confirm and try again.");
  }

  static resetPassword(values) async {
    final response = await Fetch(API.forgot, values).load();
    if (response["status"] == "success") {
      return true;
    }
    if (response["status"] == "expired_code") {
      throw Exception(
          "The reset code provided has expired! Please request another to proceed.");
    }
    if (response["status"] == "used_code") {
      throw Exception(
          "The reset code provided has already been used! Please request another to proceed.");
    }
    if (response["status"] == "invalid_code") {
      throw Exception(
          "The reset code provided is invalid or does not exist! Please request another to proceed.");
    }
    throw Exception(
        "An error occured while we were resetting your password! We apologize for this. Please try again later.");
  }

  static filterHotels(filters, selectedFilters, page, perPage, sortBy,
      priceSort, isRental) async {
    print("got here. - ${API.filterHotels} ${{
      ...filters,
      ...selectedFilters,
      "location": (filters.isNotEmpty && filters.containsKey("location"))
          ? filters["location"].toString()
          : "",
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "priceSort": priceSort,
      "isRental": isRental,
      "userToken": await Helpers.getToken(),
    }}");
    final response = await Fetch(API.filterHotels, {
      ...filters,
      ...selectedFilters,
      "location": (filters.isNotEmpty && filters.containsKey("location"))
          ? filters["location"].toString()
          : "",
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "priceSort": priceSort,
      "isRental": isRental,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getHotel(listingId) async {
    final response = await Fetch(API.listing, {
      "userToken": await Helpers.getToken(),
      "propertyId": listingId
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "not_found") {
      throw Exception(
          "The hotel you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getShortlets() async {
    final response = await Fetch(API.shortlets, {
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterShortlets(
      filters, selectedFilters, page, perPage, sortBy, priceSort) async {
    final response = await Fetch(API.filterShortlets, {
      ...filters,
      ...selectedFilters,
      "location":
          (filters && filters["location"] && filters["location"]["value"])
              ? filters["location"]["value"]
              : "",
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "priceSort": priceSort,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getShortlet(shortletId) async {
    final response = await Fetch(API.shortlet, {
      "shortletId": shortletId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "shortlet_not_found") {
      throw Exception(
          "The shortlet you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getAutomobiles() async {
    final response = await Fetch(API.automobiles, {
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterAutomobiles(
      filters, selectedFilters, page, perPage, sortBy, priceSort) async {
    final response = await Fetch(API.filterAutomobiles, {
      ...filters,
      ...selectedFilters,
      "location":
          (filters && filters["location"] && filters["location"]["value"])
              ? filters["location"]["value"]
              : "",
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "priceSort": priceSort,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getAutomobile(automobileId) async {
    final response = await Fetch(API.automobile, {
      "automobileId": automobileId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "automobile_not_found") {
      throw Exception(
          "The automobile you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static Future<Map<dynamic, dynamic>> getWishlist(
      search, status, filters, page, perPage, order, sortBy) async {
    final response = await Fetch(API.userWishlist, {
      ...filters,
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "search": search,
      "status": status,
    }).load();
    if (response["status"] == "success") {
      return response;
    }
    throw Exception(
        "We cannot fetch your wishlist at the moment! Please check back later.");
  }

  static Future<Map<dynamic, dynamic>> getBookings(
      search, status, filters, page, perPage, order, sortBy) async {
    final response = await Fetch(API.bookings, {
      ...filters,
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "search": search,
      "status": status,
    }).load();
    if (response["status"] == "success") {
      return response;
    }
    throw Exception(
        "We cannot fetch your bookings at the moment! Please check back later.");
  }

  static Future<Map<String, dynamic>> getBooking(bookingId) async {
    final response = await Fetch(API.bookings, {
      "bookingId": bookingId,
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "not_found") {
      throw Exception(
          "The booking you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static addWishlist(itemId, itemType) async {
    final response = await Fetch(API.wishlist, {
      "add": itemId,
      "itemType": itemType,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "item_not_found") {
      throw Exception(
          "The item you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static removeWishlist(itemId, itemType) async {
    final response = await Fetch(API.wishlist, {
      "remove": itemId,
      "itemType": itemType,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "item_not_found") {
      throw Exception(
          "The item you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static logout() async {
    // dispatch({
    //   type: "LOGOUT",
    // });
    Fetch(API.userSignup, {logout: "", "userToken": await Helpers.getToken()})
        .load();
  }

  static contact(values) async {
    final response = await Fetch(API.contact, {
      ...values,
      "contact": "",
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] != "success") {
      throw Exception(
          "An error ocurred while attempting to send your message! Please try again later.");
    }
  }

  static getCheckoutSettings() async {
    final response = await Fetch(API.checkout, {
      "getSettings": 1,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static Future<String> getAccessCode(double total) async {
    final response = await Fetch(API.checkout, {
      "getAccessCode": 1,
      "amount": total,
      "userToken": await Helpers.getToken(),
    }).load();
    print(response);
    if (response["status"] == "success") {
      return response["data"];
    }
    return "";
  }

  static Future<String> submitOrder(
      cart, selectedMethod, processingFee, paymentRef, customer, total) async {
    final response = await Fetch(API.checkout, {
      "order": "",
      "cart": cart,
      "selectedMethod": selectedMethod,
      "processingFee": processingFee,
      "paymentRef": paymentRef,
      "customer": jsonEncode(customer),
      "userToken": await Helpers.getToken(),
      "total": total
    }).load();
    if (response["status"] == "success") {
      return response["data"].toString();
    }
    if (response["status"] == "invalid_customer_details") {
      throw Exception(
          "The personal information provided is incomplete! Please check and try again.");
    }
    if (response["status"] == "invalid_listing") {
      throw Exception(
          "The checkout item provided is invalid! Please check and try again.");
    }
    if (response["status"] == "insufficient_balance") {
      throw Exception(
          "You do not have enough balance in your wallet to checkout! Please check and try again.");
    }
    if (response["status"] == "invalid_payment") {
      throw Exception(
          "Your payment cannot be verified at the moment! If you were debited, please reach out to support or try again.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static updateSettings(values, type) async {
    final response = await Fetch(API.settings, {
      "update_profile": "",
      ...values,
      "type": type,
    }).load();
    if (response["status"] == "success") {
      Helpers.writePref(Defaults.profile, jsonEncode(response["data"]));
      if (type == "delete_account" || type == "deactivate") {
        Helpers.logout(person: true);
      }
      return true;
    }
    if (response["status"] == "error") {
      throw Exception(
          "Something went wrong while updating your profile. Please try again later.");
    }
    if (response["status"] == "suspended") {
      throw Exception(
          "Your account has been placed on hold! Please contact support.");
    }
    if (response["status"] == "invalid_fields") {
      throw Exception(
          "An error has occured! Please fill all the required fields correctly and try again.");
    }
    if (response["status"] == "invalid_password") {
      throw Exception(
          "The current password provided is incorrect. Please confirm and try again.");
    }
    if (response["status"] == "invalid_account") {
      throw Exception(
          "Please provide your payout account information to proceed.");
    }
    if (response["status"] == "invalid_user") {
      Helpers.logout();
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getDevices() async {
    final response = await Fetch(API.misc, {
      "devices": "",
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static logoutDevice(values) async {
    final response = await Fetch(API.userLogin, {
      "name": values["name"],
      "os": values["os"],
      "deviceId": values["deviceId"],
      "status": 0,
      "type": values["type"],
    }).load();
    if (response["status"] == "success") {
      return true;
    }
    return false;
  }

  static getPricing(category) async {
    final response = await Fetch(API.pricing, {
      "userToken": await Helpers.getToken(),
      "category": category,
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static addPayoutAccount(values) async {
    final response = await Fetch(API.settings, {
      ...values,
      "bank": values["bank"]["code"].toString(),
      "bankName": values["bank"]["name"].toString(),
      "add_account": "",
    }).load();
    if (response["status"] == "success") {
      Helpers.writePref(Defaults.profile, jsonEncode(response["data"]));
      return response["result"];
    }
    if (response["status"] == "account_already_exists") {
      throw Exception(
          "The recipient you are trying to add already exists! Please select the account or enter another to proceed.");
    }
    if (response["status"] != "success") {
      return {
        "accountName": "John Doe",
        "code": "4378454",
        "bankName": values["bank"]["name"] ?? "Stripe Test Bank"
      };
      // throw Exception("An error occurred while saving account! Please try again later.");
    }
  }

  static transferWallet(values, method, pin) async {
    final response = await Fetch(API.userWallet, {
      "transfer": "",
      ...values,
      "method": method,
      "pin": pin,
    }).load();
    if (response["status"] == "insufficient_balance") {
      throw Exception(
          "You do not have sufficient balance to process this transfer! Please check your wallet balance and try again.");
    }
    if (response["status"] == "incorrect_pin") {
      throw Exception(
          "Your password or pin is incorrect! Please try again later.");
    }
    if (response["status"] != "success") {
      throw Exception(
          "We cannot process your wallet withdrawal at the moment! Please try again later or contact us if you were debited.");
    }
  }

  static exchangeWallet(values, method, pin) async {
    final response = await Fetch(API.userWallet, {
      "exchange": "",
      ...values,
      "method": method,
      "pin": pin,
    }).load();
    if (response["status"] == "insufficient_balance") {
      throw Exception(
          "You do not have sufficient balance to process this exchange! Please check your wallet balance and try again.");
    }
    if (response["status"] == "incorrect_pin") {
      throw Exception(
          "Your password or pin is incorrect! Please try again later.");
    }
    if (response["status"] == "invalid_recipient") {
      throw Exception(
          "The recipient specified does not exists or is invalid! Please try again later.");
    }
    if (response["status"] != "success") {
      throw Exception(
          "We cannot process your wallet exchange at the moment! Please try again later or contact us if you were debited.");
    }
  }

  static getBanks() async {
    final response = await Fetch(API.misc, {"banks": ""}).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getWithdrawFee() async {
    final response = await Fetch(API.misc, {"withdrawFee": ""}).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return 0;
  }

  static getExchangeRateFees() async {
    final response = await Fetch(API.misc, {"exchangeRates": ""}).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }
}
