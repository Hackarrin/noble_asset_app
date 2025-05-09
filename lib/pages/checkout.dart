import 'dart:convert';

import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/globals/shortlet_item.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/palette.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController adultsController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  final LatLng _center = const LatLng(6.5244, 3.3792);
  int _selectedImageIndex = 0;
  int _selectedTab = 0;
  bool _isReviewAll = false;
  List<String> reviewFilter = ["verified", "latest"];
  bool isDescriptionExpanded = false;

  Map<String, dynamic> filter = {
    "checkin": "",
    "checkout": "",
    "adults": 1,
    "children": 0,
    "rooms": 0
  };
  List<Map<String, dynamic>> _selectedRooms = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Map<String, dynamic> _customer = {
    "fname": "",
    "lname": "",
    "address": "",
    "phone": "",
    "info": "",
    "email": "",
    "uid": "",
    "isGuest": 1,
    "arrivalTime": "",
    "country": ""
  };
  String _selectedMethod = "paystack";
  Map<String, String> _values = {
    "startDate": "",
    "endDate": "",
    "startTime": "",
    "endTime": "",
    "numRooms": "",
    "selected": "",
    "selectedRooms": ""
  };
  double _total = 0;
  double _processingFee = 0;
  Map _order = {};
  String _paymentRef = "";
  Map _settings = {};
  bool _verifyWallet = false;
  bool _isSubmittingOrder = false;
  String _orderId = "";
  List _cart = [];
  int _activeStep = 0;
  double _walletBalance = 0;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final arrivalController = TextEditingController();

  void processPaystack() async {
    try {
      setState(() {
        _isSubmittingOrder = true;
      });
      confirmOrder("ffhjdf");
    } catch (err) {
      // enqueueSnackbar(
      //   err.message || "An error has occured! Please try again later.",
      //   {
      //     variant: "error",
      //   }
      // );
    }
    setState(() {
      _isSubmittingOrder = false;
    });
  }

  void confirmOrder(String transactionRef) async {
    try {
      if (_paymentRef != transactionRef) {
        setState(() {
          _paymentRef = transactionRef;
        });
      }
      if (transactionRef.isEmpty &&
          _paymentRef.isNotEmpty &&
          _selectedMethod == "paystack") {
        transactionRef = _paymentRef;
      }
      if (_total == 0 || (_selectedMethod.isNotEmpty && _total > 0)) {
        setState(() {
          _isSubmittingOrder = true;
        });
        final cartJSON = jsonEncode(_cart.map((item) {
          if (item["listingType"].toString() == "6") {
            return {
              "listingId": item["listingId"],
              "options": {
                ...item["options"],
                "selectedRoom": item["tickets"][num.tryParse(
                                (item["options"]["selectedRoom"] ?? 0)
                                    .toString())
                            ?.toInt() ??
                        0]["id"] ??
                    "",
              },
              "type": item["listingType"],
            };
          }
          if (item["listingType"] == "2" ||
              item["listingType"] == "4" ||
              item["listingType"] == "1" ||
              item["listingType"] == "3") {
            return {
              "listingId": item["listingId"],
              "options": item["options"],
              "type": item["listingType"],
            };
          }
          return {
            "listingId": item["listingId"],
            "options": {
              ...item["options"],
              "selectedRoom": (item["options"]["selectedRoom"] != "" &&
                      item["rooms"] &&
                      item["rooms"].length > 0 &&
                      item["rooms"]
                          .where((room, index) =>
                              index.toString() ==
                              item["options"]["selectedRoom"].toString())
                          .toList()[0]["id"]) ??
                  "",
            },
            "type": item["listingType"],
          };
        }));
        final res = await JWT.submitOrder(
            "[]", _selectedMethod, _processingFee, transactionRef, _customer);
        // update cart.
        final storage = await Helpers.readPref("cart");
        final cartDetails = storage.isNotEmpty ? jsonDecode(storage) : [];
        final newCarts =
            cartDetails.where((item) => !item["isCheckout"]).toList();
        Helpers.updateCart(newCarts);
        setState(() {
          _orderId = res;
        });
      } else {
        // enqueueSnackbar("Please provide all required information to proceed.", {
        //   variant: "warning",
        // });
      }
    } catch (err) {
      // enqueueSnackbar(
      //   err.message || "An error has occured! Please try again later.",
      //   {
      //     variant: "error",
      //   }
      // );
    }
    setState(() {
      _isSubmittingOrder = false;
    });
  }

  void handlePay() {
    if (_total == 0) {
      confirmOrder("");
    } else if (_selectedMethod == "paystack") {
      processPaystack();
    } else if (_selectedMethod == "wallet") {
      if (_paymentRef.isNotEmpty) {
        confirmOrder(_paymentRef);
      } else {
        setState(() {
          _verifyWallet = true;
        });
      }
    } else {
      // enqueueSnackbar("Please select a payment method to proceed.", {
      //   variant: "warning",
      // });
    }
  }

  void getSettings() async {
    try {
      final storage = await Helpers.readPref("cart");
      List cartDetails = storage.isNotEmpty ? jsonDecode(storage) : [];
      final cart = cartDetails.where((item) => item["isCheckout"]).toList();
      if (cart[0]["listingType"].toString() == "1") {
        cart[0]["generalRules"] = {
          "checkin": cart[0].containsKey("time")
              ? Helpers.formatDate("2024-01-01 ${cart[0]["time"]}",
                  formatString: "hh:mma")
              : "",
          "checkout": cart[0].containsKey("endTime")
              ? Helpers.formatDate("2024-01-01 ${cart[0]["endTime"]}",
                  formatString: "hh:mma")
              : "",
        };
      }
      if (cart[0]["listingType"].toString() == "6" ||
          cart[0]["listingType"].toString() == "2" ||
          cart[0]["listingType"].toString() == "4") {
        cart[0]["generalRules"] = {
          "checkin": cart[0]["options"].containsKey("time")
              ? cart[0]["options"]["time"]
              : "",
          "checkout": cart[0]["options"].containsKey("time")
              ? Helpers.formatDateObject(
                  Helpers.parseDate("2024-01-01 ${cart[0]["options"]["time"]}",
                          formatString: "yyyy-MM-dd HH:mm:ss")
                      .add(Duration(hours: 5)),
                  formatString: "hh:mma")
              : "",
        };
      }
      setState(() => _cart = cart);
      final settings = await JWT.getCheckoutSettings();
      setState(() => _settings = settings);

      String startDate = cart[0].containsKey("options") &&
              cart[0]["options"].containsKey("dateFrom")
          ? Helpers.formatDate(cart[0]["options"]["dateFrom"],
              formatString: "EEE dd MMM yyyy")
          : "";
      String startTime = "";
      if (cart[0]["listingType"].toString() == "1" &&
          cart[0].containsKey("time")) {
        startTime = Helpers.formatDate("2024-01-01 ${cart[0]["time"]}",
            formatString: "hh:mma");
      } else if (cart[0]["listingType"].toString() == "2" &&
          cart[0]["options"].containsKey("time")) {
        startTime = Helpers.formatDate(
            "2024-01-01 ${cart[0]["options"]["time"]}",
            formatString: "hh:mma");
      } else if (cart[0]["listingType"].toString() == "6" &&
          cart[0]["options"].containsKey("time")) {
        startTime = cart[0]["options"]["time"];
      } else if (cart[0]["listingType"].toString() == "4" &&
          cart[0]["options"].containsKey("time")) {
        startTime = Helpers.formatDate(
            "2024-01-01 ${cart[0]["options"]["time"]}",
            formatString: "hh:mma");
      } else if (cart[0].containsKey("generalRules")) {
        startTime = cart[0]["generalRules"]["checkin"];
      }
      String endDate = "";
      String endTime = "";
      if (cart[0]["listingType"].toString() != "6") {
        endDate = cart[0].containsKey("options") &&
                cart[0]["options"].containsKey("dateTo")
            ? Helpers.formatDate(cart[0]["options"]["dateTo"],
                formatString: "EEE dd MMM yyyy")
            : "";

        if (cart[0]["listingType"].toString() == "1" &&
            cart[0].containsKey("endTime")) {
          endTime =
              "${Helpers.formatDate("2024-01-01 ${cart[0]["endTime"]}", formatString: "hh:mma")}${cart[0].containsKey("frequency") ? "(${cart[0]["frequency"]})" : ""}";
        } else if ((cart[0]["listingType"].toString() == "2" ||
                cart[0]["listingType"].toString() == "4") &&
            cart[0]["options"].containsKey("endTime")) {
          endTime = Helpers.formatDate(
              "2024-01-01 ${cart[0]["options"]["endTime"]}",
              formatString: "hh:mm a");
        } else if (cart[0].containsKey("generalRules")) {
          endTime = cart[0]["generalRules"]["checkout"].toString();
        }
      }

      String numRooms = "";
      if (cart[0]["listingType"].toString() == "1") {
        numRooms = cart[0]["options"].containsKey("selectedRoom")
            ? cart[0]["options"]["selectedRoom"]
                .keys
                .map((ticket) =>
                    "${Helpers.formatNumber(cart[0]["options"]["selectedRoom"][ticket].toString())} $ticket")
                .toList()
                .join(", ")
            : "";
      } else if (cart[0]["listingType"].toString() == "6") {
        final totalTickets =
            (num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ??
                    0) +
                (num.tryParse(cart[0]["options"]["children"].toString())
                        ?.toInt() ??
                    0) +
                (num.tryParse(cart[0]["options"]["infants"].toString())
                        ?.toInt() ??
                    0);
        numRooms =
            "$totalTickets ${cart[0]["tickets"][(num.tryParse(cart[0]["options"]["selectedRoom"].toString())?.toInt() ?? 0)]["name"] ?? ""}";
      } else if (cart[0]["listingType"].toString() == "2") {
        numRooms =
            "${cart[0]["options"]["numNights"]} day${(num.tryParse(cart[0]["options"]["numNights"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}";
      } else if (cart[0]["listingType"].toString() == "4") {
        numRooms =
            "${cart[0]["options"]["numNights"]} hour${(num.tryParse(cart[0]["options"]["numNights"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}";
      } else {
        numRooms = (cart[0]["listingType"].toString() == "0" ||
                    cart[0]["listingType"].toString() == "3") &&
                cart[0].containsKey("options") &&
                cart[0]['options'].containsKey("numNights")
            ? Helpers.formatNumber(cart[0]['options']["numNights"].toString())
            : "";
        numRooms =
            "$numRooms ${cart[0]["listingType"].toString() == "3" ? "day" : "night"}${((cart[0]["listingType"].toString() == "0" || cart[0]["listingType"].toString() == "3") && ((num.tryParse(cart[0]["options"]["numNights"].toString())?.toInt() ?? 0) > 1)) ? "s" : ""}";
      }
      String selectedRoom = "";
      if (cart[0]["listingType"].toString() == "0") {
        selectedRoom = cart[0].containsKey("rooms") &&
                cart[0]["rooms"].length > 0
            ? cart[0]["rooms"][
                    (num.tryParse(cart[0]["options"]["selectedRoom"].toString())
                            ?.toInt() ??
                        0)]["name"]
                .toString()
            : "";
      }
      String selected = "";
      if (cart[0]["listingType"].toString() == "1") {
        final tickets = cart[0].containsKey("options")
            ? cart[0]["options"]["selectedRoom"] ?? {}
            : {};
        final totalTickets = tickets.values
            .map((item) => num.tryParse(item.toString())?.toInt() ?? 0)
            .toList()
            .reduce((prev, total) => prev + total);
        selectedRoom =
            "${Helpers.formatNumber(totalTickets.toString())} Ticket${totalTickets > 1 ? "s" : ""} for ${Helpers.formatNumber(totalTickets.toString())} Adult${totalTickets > 1 ? "s" : ""}";
      } else if (cart[0]["listingType"].toString() == "4") {
        selectedRoom =
            "${Helpers.formatNumber((num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ?? 0).toString())} Occupant${(num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}";
      } else if (cart[0]["listingType"].toString() == "6") {
        final totalTickets =
            (num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ??
                    0) +
                (num.tryParse(cart[0]["options"]["children"].toString())
                        ?.toInt() ??
                    0) +
                (num.tryParse(cart[0]["options"]["infants"].toString())
                        ?.toInt() ??
                    0);
        selected = "$totalTickets Ticket${totalTickets > 1 ? "s" : ""}";
        selected =
            "$selected for ${cart[0].containsKey("options") && cart[0]["options"].containsKey("adults") ? Helpers.formatNumber(cart[0]["options"]["adults"].toString()) : ""} Adult${(num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ?? 0) > 1 ? "s" : ""} ${cart[0].containsKey("options") && cart[0]["options"].containsKey("children") ? Helpers.formatNumber(cart[0]["options"]["children"].toString()) : ""} Child${(num.tryParse(cart[0]["options"]["children"].toString())?.toInt() ?? 0) > 1 ? "ren" : ""} ${cart[0].containsKey("options") && cart[0]["options"].containsKey("infants") ? Helpers.formatNumber(cart[0]["options"]["infants"].toString()) : ""} Infant${(num.tryParse(cart[0]["options"]["infants"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}";
      } else if (cart[0]["listingType"].toString() != "2" &&
          cart[0]["listingType"].toString() != "4") {
        selected = cart[0].containsKey("options") &&
                cart[0]["options"].containsKey("numRooms")
            ? Helpers.formatNumber(cart[0]["options"]["numRooms"].toString())
            : "";
        selected =
            "$selected room${(num.tryParse(cart[0]["options"]["numRooms"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}";
        selected =
            "$selected for ${cart[0].containsKey("options") && cart[0]["options"].containsKey("adults") ? Helpers.formatNumber(cart[0]["options"]["adults"].toString()) : ""} Adult${(num.tryParse(cart[0]["options"]["adults"].toString())?.toInt() ?? 0) > 1 ? "s" : ""} ${cart[0].containsKey("options") && cart[0]["options"].containsKey("children") ? Helpers.formatNumber(cart[0]["options"]["children"].toString()) : ""} Child${(num.tryParse(cart[0]["options"]["children"].toString())?.toInt() ?? 0) > 1 ? "ren" : ""}";
      }
      setState(() => _values = {
            "startDate": startDate,
            "endDate": endDate,
            "startTime": startTime,
            "endTime": endTime,
            "numRooms": numRooms,
            "selected": selected,
            "selectedRoom": selectedRoom
          });
      double subtotal = 0;
      if (cart[0]["listingType"].toString() == "1") {
        final tickets = cart[0].containsKey("options")
            ? cart[0]["options"]["selectedRoom"] ?? {}
            : {};
        subtotal = tickets.keys
            .map((ticket) =>
                (num.tryParse(tickets[ticket].toString())?.toInt() ?? 0) *
                (num.tryParse(cart[0]["tickets"]
                            .firstWhere((item) =>
                                item["name"].toString() == ticket)["price"]
                            .toString())
                        ?.toDouble() ??
                    0))
            .toList()
            .reduce((prev, total) => prev + total);
      } else if (cart[0]["listingType"].toString() == "6") {
        final ticket = cart[0]["tickets"][
            (num.tryParse(cart[0]["options"]["selectedRoom"].toString())
                    ?.toInt() ??
                0)];
        subtotal = ((num.tryParse(cart[0]["options"]["adults"].toString())
                        ?.toInt() ??
                    0) *
                (num.tryParse(ticket["adultPrice"].toString())?.toDouble() ??
                    0)) +
            ((num.tryParse(cart[0]["options"]["children"].toString())
                        ?.toInt() ??
                    0) *
                (num.tryParse(ticket["childrenPrice"].toString())?.toDouble() ??
                    0)) +
            ((num.tryParse(cart[0]["options"]["infants"].toString())?.toInt() ??
                    0) *
                (num.tryParse(ticket["infantPrice"].toString())?.toDouble() ??
                    0));
      } else if (cart[0]["listingType"].toString() == "2" ||
          cart[0]["listingType"].toString() == "4") {
        final price = Helpers.handleCalendarEntry([
          cart[0]["options"]["dateFrom"].toString(),
          cart[0]["options"]["dateTo"].toString()
        ],
            cart[0]["calendar"] ?? [],
            (num.tryParse(cart[0]["price"].toString())?.toDouble() ?? 0),
            cart[0]["listingId"].toString());
        final duration =
            (num.tryParse(cart[0]["options"]["numNights"].toString())
                    ?.toInt() ??
                0);
        final quantity =
            (num.tryParse(cart[0]["options"]["numRooms"].toString())?.toInt() ??
                0);
        subtotal = price * duration * quantity;
      } else {
        final price = Helpers.handleCalendarEntry(
            [
              cart[0]["options"]["dateFrom"].toString(),
              cart[0]["options"]["dateTo"].toString()
            ],
            cart[0]["calendar"] ?? [],
            (num.tryParse(cart[0]["rooms"][
                            (num.tryParse(cart[0]["options"]["selectedRoom"].toString())
                                    ?.toInt() ??
                                0)]["price"]
                        .toString())
                    ?.toDouble() ??
                0),
            cart[0]["rooms"][
                    (num.tryParse(cart[0]["options"]["selectedRoom"].toString())
                            ?.toInt() ??
                        0)]["id"]
                .toString());
        subtotal = price *
            (num.tryParse(cart[0]["options"]["numRooms"].toString())?.toInt() ??
                0) *
            (num.tryParse(cart[0]["options"]["numNights"].toString())
                    ?.toInt() ??
                0);
      }
      double processingFee =
          ((num.tryParse(settings["processing_fee"].toString())?.toDouble() ??
                      0) /
                  100) *
              subtotal;
      final processingCap =
          (num.tryParse(settings["processing_cap"].toString())?.toDouble() ??
              0);
      if (processingFee > processingCap) {
        processingFee = processingCap;
      }
      setState(() {
        _processingFee = processingFee;
        _total = subtotal + processingFee;
      });
    } catch (err) {
      print(err);
      // console.log(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getSettings);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xfff1f1f1), width: 1),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(left: 15.0),
          child: IconButton(
              onPressed: () {
                if (_activeStep > 0) {
                  setState(() {
                    _activeStep -= 1;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Helpers.fetchIcons(
                "arrow-small-left",
                "solid",
                size: 24,
                color: "text.other",
              )),
        ),
        title: Widgets.buildText(
            "Reserve ${_cart.isNotEmpty ? Defaults.sections[num.tryParse(_cart[0]["listingType"].toString())?.toInt() ?? 0] : ""}",
            context,
            isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 15.0, bottom: 80.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Color(0x0D000000))),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: EasyStepper(
                              activeStep: _activeStep,
                              internalPadding: 0,
                              showLoadingAnimation: false,
                              stepRadius: 15.0,
                              disableScroll: true,
                              enableStepTapping: false,
                              showStepBorder: false,
                              fitWidth: true,
                              finishedStepBackgroundColor: Colors.transparent,
                              lineStyle: LineStyle(
                                  lineType: LineType.normal,
                                  defaultLineColor: Color(0x1A000000),
                                  lineThickness: 5.0,
                                  lineLength: 80.0,
                                  finishedLineColor:
                                      Palette.get("main.primary")),
                              steps: [
                                EasyStep(
                                  customStep: Opacity(
                                    opacity: _activeStep >= 0 ? 1 : 0.3,
                                    child: SvgPicture.asset(
                                        _activeStep >= 0
                                            ? "assets/images/stepper-selected.svg"
                                            : 'assets/images/stepper-1.svg',
                                        width: 30.0,
                                        height: 30.0,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                EasyStep(
                                  customStep: Opacity(
                                    opacity: _activeStep >= 1 ? 1 : 0.3,
                                    child: SvgPicture.asset(
                                        _activeStep >= 1
                                            ? "assets/images/stepper-selected.svg"
                                            : 'assets/images/stepper-2.svg',
                                        width: 60.0,
                                        height: 60.0,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                EasyStep(
                                  customStep: Opacity(
                                    opacity: _activeStep >= 2 ? 1 : 0.3,
                                    child: SvgPicture.asset(
                                        _activeStep >= 2
                                            ? "assets/images/stepper-selected.svg"
                                            : 'assets/images/stepper-3.svg',
                                        width: 60.0,
                                        height: 60.0,
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ],
                              onStepReached: (index) =>
                                  setState(() => _activeStep = index),
                            ),
                          ),
                          if (_activeStep == 0)
                            SizedBox(
                              width: double.infinity,
                              child: CustomerInformation(
                                  customer: _customer,
                                  rules: _cart.isNotEmpty
                                      ? _cart[0]["generalRules"] ?? {}
                                      : {},
                                  fnameController: fnameController,
                                  lnameController: lnameController,
                                  phoneController: phoneController,
                                  emailController: emailController,
                                  addressController: addressController,
                                  arrivalController: arrivalController,
                                  handleUpdate: (name, value) {
                                    setState(() {
                                      _customer[name] = value;
                                    });
                                  }),
                            ),
                          if (_activeStep == 1 &&
                              _cart[0]["listingType"].toString() == "0")
                            SizedBox(
                                width: double.infinity,
                                child: HotelItem(
                                  item: _cart.isNotEmpty ? _cart[0] : {},
                                  direction: "horizontal",
                                  isBordered: false,
                                )),
                          if (_activeStep == 1 &&
                              _cart[0]["listingType"].toString() == "3")
                            SizedBox(
                                width: double.infinity,
                                child: ShortletItem(
                                  item: _cart.isNotEmpty ? _cart[0] : {},
                                  direction: "horizontal",
                                  isBordered: false,
                                )),
                        ],
                      ),
                    ),
                    if (_activeStep == 1)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: HotelInformation(
                          item: _cart.isNotEmpty ? _cart[0] : {},
                          values: _values,
                          total: _total,
                          processingFee: _processingFee,
                        ),
                      ),
                    if (_activeStep == 2)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: PaymentInformation(
                          method: _selectedMethod,
                          setMethod: (method) {
                            setState(() {
                              _selectedMethod = method;
                            });
                          },
                          walletBalance: _walletBalance,
                          setPaymentReference: () => {},
                          total: _total,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 76.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x08000000),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(1, -5), // changes position of shadow
                        ),
                      ]),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if (_activeStep == 0) {
                          setState(() {
                            _activeStep = 1;
                          });
                          // if (_customer["fname"].isNotEmpty &&
                          //     _customer["lname"].isNotEmpty &&
                          //     _customer["email"].isNotEmpty &&
                          //     _customer["phone"].isNotEmpty) {
                          //   setState(() {
                          //     _activeStep = 1;
                          //   });
                          // } else {
                          //   enqueueSnackbar(
                          //       "Please fill all the required details before proceeding.",
                          //       {
                          //         variant: "error",
                          //       });
                          // }
                        } else if (_activeStep == 1) {
                          setState(() {
                            _activeStep = 2;
                          });
                        }
                      },
                      style: Widgets.buildButton(context,
                          background: Palette.get("main.primary"),
                          radius: 40.0),
                      child: Widgets.buildText(
                          _activeStep == 1
                              ? "Confirm and Pay"
                              : (_activeStep == 2 ? "Pay" : "Continue"),
                          context,
                          isMedium: true,
                          color: "text.white"),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class CustomerInformation extends StatelessWidget {
  const CustomerInformation({
    super.key,
    required this.customer,
    required this.rules,
    required this.fnameController,
    required this.lnameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.arrivalController,
    required this.handleUpdate,
  });

  final Function handleUpdate;
  final Map<String, dynamic> customer;
  final dynamic rules;

  final TextEditingController fnameController;
  final TextEditingController lnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController arrivalController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Widgets.buildText("Your information Details", context,
            color: "text.secondary", isMedium: true),
        const SizedBox(height: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("First name", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: fnameController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4), isFilled: true, isOutline: true),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              onChanged: (text) {
                handleUpdate("fname", text);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Last name", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: lnameController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4), isFilled: true, isOutline: true),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              onChanged: (text) {
                handleUpdate("lname", text);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Email address", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: emailController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4), isFilled: true, isOutline: true),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              onChanged: (text) {
                handleUpdate("email", text);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Phone number", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: phoneController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4), isFilled: true, isOutline: true),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              onChanged: (text) {
                handleUpdate("phone", text);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Address", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: addressController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4),
                  isFilled: true,
                  isOutline: true,
                  suffixIcon: UnconstrainedBox(
                    child: Helpers.fetchIcons("caret-down", "regular",
                        size: 25.0, color: "text.disabled"),
                  )),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              onChanged: (text) {
                handleUpdate("country", text);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(color: Color(0x14000000)),
        const SizedBox(height: 10.0),
        Widgets.buildText("Who are you booking for?", context,
            size: 15.0, color: "text.primary"),
        const SizedBox(height: 10.0),
        Column(
          children: [
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: customer["isGuest"],
                    onChanged: (value) {
                      handleUpdate("isGuest", 1);
                    }),
                Widgets.buildText("I am the main guest", context,
                    size: 13.0, color: "text.secondary")
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Radio(
                    value: 0,
                    groupValue: customer["isGuest"],
                    onChanged: (value) {
                      handleUpdate("isGuest", 0);
                    }),
                Widgets.buildText("Booking is for someone else", context,
                    size: 13.0, color: "text.secondary")
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(color: Color(0x14000000)),
        const SizedBox(height: 10.0),
        Widgets.buildText("Your arrival time", context,
            size: 15.0, color: "text.primary"),
        const SizedBox(height: 10.0),
        Widgets.buildText(
            "You can check in between ${rules["checkin"] ?? "09:00am"} and ${rules["checkout"] ?? "12:00pm"} 24-hour front desk - Help whenever you need it!",
            context,
            size: 13.0,
            lines: 3,
            color: "text.secondary"),
        const SizedBox(height: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText(
                "Add your estimated arrival time (optional)", context,
                color: 'text.primary', size: 13.0),
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: arrivalController,
              decoration: Widgets.inputDecoration("",
                  color: Color(0xFFF4F4F4), isFilled: true, isOutline: true),
              style: GoogleFonts.nunito(
                  color: Color(0xCC757575),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400),
              readOnly: true,
              onTap: () async {
                List<String> options = [];
                var start = rules["checkin"] ?? "09:00AM";
                final end = rules["checkout"] ?? "12:00PM";
                if (start.isNotEmpty && end.isNotEmpty) {
                  while (start != end) {
                    options.add(start);
                    start = Helpers.addHours(start,
                        formatString: "hh:mma", hours: 1);
                  }
                  options.add(end);
                }
                final time =
                    await Sheets.showOptions("Arrival time", "", options);
                arrivalController.text = time;
                handleUpdate("arrivalTime", time);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class HotelInformation extends StatelessWidget {
  const HotelInformation(
      {super.key,
      required this.item,
      required this.values,
      required this.total,
      required this.processingFee});

  final Map<String, dynamic> item;
  final Map<String, dynamic> values;
  final double total;
  final double processingFee;

  @override
  Widget build(BuildContext context) {
    var checkInLabel = "Check-in";
    var checkoutLabel = "Check-out";
    var numRooms = "Total length of stay";
    switch (item["listingType"].toString()) {
      case "1":
        checkInLabel = "Event Date";
        checkoutLabel = "End Date";
        numRooms = "Number of Tickets";
        break;
      case "6":
        checkInLabel = "Booking Date";
        numRooms = "Number of Tickets";
        break;
      case "2":
        checkInLabel = "Pick up";
        numRooms = "Duration";
        checkoutLabel = "Drop off";
        break;
      case "4":
        checkInLabel = "Rental Date";
        checkoutLabel = "End Date";
        numRooms = "Duration";
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.0,
      children: [
        if (item.containsKey("amenities") && item["amenities"].isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final amenity = item["amenities"][index] ?? "";
                return Container(
                  decoration: BoxDecoration(
                    color: Palette.get("text.white"),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Widgets.buildText(
                      Defaults.hotelAmenities[amenity]?["name"] ?? "", context,
                      size: 12.0, weight: 400, color: "main.primary"),
                );
              },
              itemCount: (item["amenities"] ?? []).length,
            ),
          ),
        if (item.containsKey("services") && item["services"].isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var amenity = item["services"][index] ?? {};
                if (amenity.runtimeType == String) {
                  amenity = Defaults.boatAmenities.firstWhere(
                      (i) => i["value"].toString() == amenity.toString(),
                      orElse: () => {"label": ""});
                }
                return Container(
                  decoration: BoxDecoration(
                    color: Palette.get("text.white"),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    spacing: 10.0,
                    children: [
                      if (amenity.containsKey("icon") &&
                          amenity["icon"].toString().isNotEmpty)
                        Helpers.fetchIcons(amenity["icon"], "regular",
                            color: "main.primary"),
                      Widgets.buildText(
                          amenity["name"] ??
                              amenity["label"] ??
                              amenity.toString(),
                          context,
                          size: 12.0,
                          weight: 400,
                          color: "main.primary"),
                    ],
                  ),
                );
              },
              itemCount: (item["services"] ?? []).length,
            ),
          ),
        if ((!item.containsKey("amenities") || item["amenities"].isNotEmpty) &&
            item.containsKey("included") &&
            item["included"].isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final amenity = item["included"][index] ?? {};
                return Container(
                  decoration: BoxDecoration(
                    color: Palette.get("text.white"),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Widgets.buildText(amenity.toString(), context,
                      size: 12.0, weight: 400, color: "main.primary"),
                );
              },
              itemCount: (item["included"] ?? []).length,
            ),
          ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.get("background.paper"),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0x0D000000))),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Widgets.buildText(
                  "Your ${item["listingType"].toString() == "2" || item["listingType"].toString() == "4" ? "Rental" : "Booking"} Details",
                  context,
                  color: "text.secondary",
                  isMedium: true),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Widgets.buildText(checkInLabel, context,
                            color: "text.disabled", size: 13.0, weight: 500),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: const DashedDivider(
                                  color: Color(0x40000000))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size(200.0, double.infinity)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(
                            values["startDate"].toString(), context,
                            color: "text.secondary", size: 13.0, weight: 500),
                        Widgets.buildText(
                            "From ${values["startTime"].toString()}", context,
                            color: "text.secondary", size: 13.0, weight: 500),
                      ],
                    ),
                  ),
                ],
              ),
              if (item["listingType"].toString() != "6")
                const SizedBox(height: 15.0),
              if (item["listingType"].toString() != "6")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Widgets.buildText(checkoutLabel, context,
                              color: "text.disabled", size: 13.0, weight: 500),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: SizedBox(
                                width: double.infinity,
                                child: const DashedDivider(
                                    color: Color(0x40000000))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(200.0, double.infinity)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText(
                              values["endDate"].toString(), context,
                              color: "text.secondary", size: 13.0, weight: 500),
                          Widgets.buildText(
                              "To ${values["endTime"].toString()}", context,
                              color: "text.secondary", size: 13.0, weight: 500),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Widgets.buildText(numRooms, context,
                            color: "text.disabled", size: 13.0, weight: 500),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: const DashedDivider(
                                  color: Color(0x40000000))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(200.0, 20.0)),
                    child: Widgets.buildText(
                        values["numRooms"].toString(), context,
                        color: "text.secondary",
                        size: 13.0,
                        weight: 500,
                        lines: 3),
                  ),
                ],
              ),
              if (values["selectedRoom"].toString().isNotEmpty)
                const SizedBox(height: 15.0),
              if (values["selectedRoom"].toString().isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Widgets.buildText(
                              item["listingType"].toString() == "1"
                                  ? "Selected ticket(s)"
                                  : (item["listingType"].toString() == "4"
                                      ? "No. of Occupants"
                                      : "Selected room"),
                              context,
                              color: "text.disabled",
                              size: 13.0,
                              weight: 500),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: SizedBox(
                                width: double.infinity,
                                child: const DashedDivider(
                                    color: Color(0x40000000))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(200.0, double.infinity)),
                      child: Widgets.buildText(
                          values["selectedRoom"].toString(), context,
                          color: "text.secondary",
                          size: 13.0,
                          weight: 500,
                          lines: 3),
                    ),
                  ],
                ),
              const SizedBox(height: 15.0),
              if (values["selected"].toString().split("for").length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Widgets.buildText("Guests", context,
                              color: "text.disabled", size: 13.0, weight: 500),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: SizedBox(
                                width: double.infinity,
                                child: const DashedDivider(
                                    color: Color(0x40000000))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.loose(Size(200.0, double.infinity)),
                      child: Widgets.buildText(
                          values["selected"].toString().split("for").length > 1
                              ? values["selected"]
                                  .toString()
                                  .split("for")[1]
                                  .trim()
                              : "",
                          context,
                          color: "text.secondary",
                          size: 13.0,
                          weight: 500),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.get("background.paper"),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0x0D000000))),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Widgets.buildText("Your Price Summary", context,
                  color: "text.secondary", isMedium: true),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Widgets.buildText("Subtotal", context,
                            color: "text.disabled", size: 13.0, weight: 500),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: const DashedDivider(
                                  color: Color(0x40000000))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size(200.0, double.infinity)),
                    child: Widgets.buildText(
                        Helpers.formatCurrency(
                            (total - processingFee).toString()),
                        context,
                        color: "text.secondary",
                        size: 13.0,
                        weight: 500),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Widgets.buildText("Processing fee", context,
                            color: "text.disabled", size: 13.0, weight: 500),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: const DashedDivider(
                                  color: Color(0x40000000))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size(200.0, double.infinity)),
                    child: Widgets.buildText(
                        Helpers.formatCurrency(processingFee.toString()),
                        context,
                        color: "text.secondary",
                        size: 13.0,
                        weight: 500),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Widgets.buildText("Total", context,
                            color: "text.disabled", size: 13.0, weight: 500),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: const DashedDivider(
                                  color: Color(0x40000000))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size(200.0, double.infinity)),
                    child: Widgets.buildText(
                        Helpers.formatCurrency(total.toString()), context,
                        color: "text.secondary", size: 13.0, weight: 500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentInformation extends StatelessWidget {
  const PaymentInformation(
      {super.key,
      required this.method,
      required this.setMethod,
      required this.total,
      required this.walletBalance,
      required this.setPaymentReference});

  final String method;
  final Function setMethod;
  final Function setPaymentReference;
  final double total;
  final double walletBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Palette.get("background.paper"),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0x0D000000))),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Widgets.buildText("How would you like to pay?", context,
                  color: "text.secondary", isMedium: true),
              const SizedBox(height: 20.0),
              Widgets.buildText(
                  "Select your preferred payment method below to proceed.",
                  context,
                  lines: 3,
                  color: "text.disabled"),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            setMethod("paystack");
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Palette.get("background.paper"),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0x0D000000))),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Image.asset("assets/images/paystack.png",
                    height: 30.0, fit: BoxFit.contain),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Pay with Paystack", context,
                          color: "text.secondary", isMedium: true),
                      const SizedBox(height: 5.0),
                      Widgets.buildText("Cards & Transfer", context,
                          color: "text.disabled", size: 13.0, weight: 500),
                    ],
                  ),
                ),
                Checkbox(
                    value: method == "paystack",
                    onChanged: (checked) {
                      setMethod("paystack");
                    })
              ],
            ),
          ),
        ),
        // const SizedBox(height: 10.0),
        // GestureDetector(
        //   onTap: () {
        //     setMethod("wallet");
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //         color: Palette.get("background.paper"),
        //         borderRadius: BorderRadius.circular(10.0),
        //         border: Border.all(color: Color(0x0D000000))),
        //     padding: const EdgeInsets.all(20.0),
        //     child: Row(
        //       children: [
        //         Image.asset("assets/images/logo.png",
        //             height: 44.0, fit: BoxFit.contain),
        //         const SizedBox(width: 15.0),
        //         Expanded(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Widgets.buildText("Wallet", context,
        //                   color: "text.secondary", isMedium: true),
        //               const SizedBox(height: 5.0),
        //               Widgets.buildText(
        //                   "Use Your Wallet for Fast & Secure Payments", context,
        //                   color: "text.disabled",
        //                   size: 13.0,
        //                   weight: 500,
        //                   lines: 3),
        //             ],
        //           ),
        //         ),
        //         Checkbox(
        //             value: method == "wallet",
        //             onChanged: (checked) {
        //               setMethod("wallet");
        //             })
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 10.0),
        // GestureDetector(
        //   onTap: () {
        //     setMethod("stripe");
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //         color: Palette.get("background.paper"),
        //         borderRadius: BorderRadius.circular(10.0),
        //         border: Border.all(color: Color(0x0D000000))),
        //     padding: const EdgeInsets.all(20.0),
        //     child: Row(
        //       children: [
        //         Image.asset("assets/images/stripe.jpeg",
        //             height: 44.0, fit: BoxFit.contain),
        //         const SizedBox(width: 15.0),
        //         Expanded(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Widgets.buildText("Stripe", context,
        //                   color: "text.secondary", isMedium: true),
        //               const SizedBox(height: 5.0),
        //               Widgets.buildText(
        //                   "Seamless international Payments", context,
        //                   color: "text.disabled",
        //                   size: 13.0,
        //                   weight: 500,
        //                   lines: 3),
        //             ],
        //           ),
        //         ),
        //         Checkbox(
        //             value: method == "stripe",
        //             onChanged: (checked) {
        //               setMethod("stripe");
        //             })
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
