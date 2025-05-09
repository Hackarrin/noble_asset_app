import 'dart:convert';

import 'package:afritas/utils/apis.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/fetch.dart';
import 'package:afritas/utils/helpers.dart';

class JWT {
  static register(values) async {
    final response = await Fetch(API.signup, values).load();
    if (response["status"] == "success") {
      // dispatch({
      //   type: "LOGIN",
      //   payload: data,
      // });
      // setToken(token);
      return true;
    }
    if (response["status"] == "email_taken") {
      throw Exception(
          "The email address you provided is already in use. Please confirm and try again.");
    }
    throw Exception(
        "An error occured while we were signing you up! We apologize for this. Please try again later.");
  }

  static login(values) async {
    final response = await Fetch(API.login, values).load();
    if (response["status"] == "success") {
      // dispatch({
      //   type: "LOGIN",
      //   payload: data,
      // });
      // setToken(token);
      return response["cart"];
    }
    if (response["status"] == "invalid_login") {
      throw Exception(
          "Invalid email address or password! Please confirm and try again");
    }
    throw Exception(
        "An error occured while we were logging you in! We apologize for this. Please try again later.");
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

  static requestPasswordReset(values) async {
    final response = await Fetch(API.forgotPassword, values).load();
    if (response["status"] == "success") {
      return true;
    }
    if (response["status"] == "invalid_email_address") {
      throw Exception(
          "The email address you provided is not registered with us! Please confirm and try again or create an account to proceed.");
    }
    throw Exception(
        "An error occured while we were checking your account! We apologize for this. Please try again later.");
  }

  static resetPassword(values) async {
    final response = await Fetch(API.forgotPassword, values).load();
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

  static filterHotels(
      filters, selectedFilters, page, perPage, sortBy, priceSort) async {
    final response = await Fetch(API.filterHotels, {
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

  static getHotel(hotelId) async {
    final response = await Fetch(API.hotel, {
      "hotelId": hotelId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "hotel_not_found") {
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

  static getEvents() async {
    final response = await Fetch(API.events, {
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterEvents(category, search, page, perPage, sortBy) async {
    final response = await Fetch(API.filterEvents, {
      "category": category,
      "search": search,
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getEvent(eventId) async {
    final response = await Fetch(API.event, {
      "eventId": eventId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "event_not_found") {
      throw Exception(
          "The event you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getAttractions() async {
    final response = await Fetch(API.attractions, {
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterAttractions(
      filters, selectedFilters, page, perPage, sortBy, priceSort) async {
    final response = await Fetch(API.filterAttractions, {
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

  static getAttraction(attractionId) async {
    final response = await Fetch(API.attraction, {
      "attractionId": attractionId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "attraction_not_found") {
      throw Exception(
          "The attraction you are looking for does not exists! Please check back later.");
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

  static getBoats() async {
    final response = await Fetch(API.boats, {
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterBoats(
      filters, selectedFilters, page, perPage, sortBy, priceSort) async {
    final response = await Fetch(API.filterBoats, {
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

  static getBoat(boatId) async {
    final response = await Fetch(API.boat, {
      "boatId": boatId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "boat_not_found") {
      throw Exception(
          "The boat you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getProperties(type) async {
    final response = await Fetch(API.properties, {
      "userToken": await Helpers.getToken(),
      "type": type,
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static filterProperties(filters, page, perPage, sortBy) async {
    final response = await Fetch(API.filterProperties, {
      ...filters,
      "page": page,
      "perPage": perPage,
      "sortBy": sortBy,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return [];
  }

  static getProperty(propertyId) async {
    final response = await Fetch(API.property, {
      "propertyId": propertyId,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "property_not_found") {
      throw Exception(
          "The property you are looking for does not exists! Please check back later.");
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

  static getWishlist() async {
    final response = await Fetch(API.wishlist, {
      "get": "",
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    if (response["status"] == "product_not_found") {
      throw Exception(
          "The product you are looking for does not exists! Please check back later.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static logout() async {
    // dispatch({
    //   type: "LOGOUT",
    // });
    Fetch(API.login, {logout: "", "userToken": await Helpers.getToken()})
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

  static submitPropertyEnquiry(values, property) async {
    final response = await Fetch(API.property, {
      ...values,
      "enquiry": "",
      "property": property,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] != "success") {
      throw Exception(
          "An error ocurred while attempting to send your enquiry! Please try again later.");
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
    throw Exception("An error has occurred! Please check back later.");
  }

  static submitOrder(
      cart, selectedMethod, processingFee, paymentRef, customer) async {
    final response = await Fetch(API.checkout, {
      "order": "",
      "cart": cart,
      "selectedMethod": selectedMethod,
      "processingFee": processingFee,
      "paymentRef": paymentRef,
      "customer": jsonEncode(customer),
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      return response["data"];
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

  static updateProfile(values) async {
    final response = await Fetch(API.account, {
      "update": "",
      "fname": values.fname,
      "lname": values.lname,
      "phone": values.phone,
      "address": values.address,
      "userToken": await Helpers.getToken(),
    }).load();
    if (response["status"] == "success") {
      // dispatch({
      //   type: "LOGIN",
      //   payload: data,
      // });
      return true;
    }
    if (response["status"] == "invalid_fields") {
      throw Exception("invalid data uploaded! Please check and try again.");
    }
    throw Exception("An error has occurred! Please check back later.");
  }

  static getBlogs(sort, page, perpage) async {
    final response = await Fetch(API.blog, {
      "userToken": await Helpers.getToken(),
      "sort": sort,
      "page": page,
      "perpage": perpage,
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
  }

  static getBlogCategory(category) async {
    final response = await Fetch(API.blog, {
      "userToken": await Helpers.getToken(),
      "category": category,
    }).load();
    if (response["status"] == "success") {
      return response["data"];
    }
    return {};
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
