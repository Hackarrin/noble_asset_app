import 'dart:convert';

import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> with SingleTickerProviderStateMixin {
  Map<String, dynamic> booking = {};

  bool loading = true;
  String error = "";
  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getBooking(booking["bookingId"] ?? "");
      setState(() {
        booking = res;
        loading = false;
      });
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final data = jsonDecode(arguments.toString());
          setState(() {
            booking = data;
          });
          fetch();
        } catch (err) {
          print("dante - $err");
        }
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
                Navigator.pop(context);
              },
              icon: Helpers.fetchIcons(
                "arrow-small-left",
                "solid",
                size: 24,
                color: "text.other",
              )),
        ),
        title: Widgets.buildText(
            "Booking Details - #${booking["bookingId"]}", context,
            isMedium: true),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/messages",
                      arguments: jsonEncode(booking));
                },
                style: Widgets.buildButton(context,
                    radius: 50.0, sideColor: Color(0xFFF1F1F1)),
                icon: Helpers.fetchIcons("comment-alt", "solid",
                    color: "text.black", size: 16.0)),
          )
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
              bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
          child: SingleChildScrollView(
            child: loading
                ? Shimmer.fromColors(
                    baseColor: Palette.get("background.neutral"),
                    highlightColor: Palette.get("background.default"),
                    loop: 1,
                    child: AbsorbPointer(child: buildContent()),
                  )
                : (error.isNotEmpty
                    ? Alert.showErrorMessage(context, "",
                        padding: 50.0,
                        buttonText: "Retry",
                        message: error,
                        action: fetch)
                    : buildContent()),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    final stat = Defaults.bookingStatus.firstWhere((stat) =>
        stat["value"].toString() == (booking["status"] ?? "0").toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            color: Palette.get("${stat["color"]}.main"),
                            borderRadius: BorderRadius.circular(10.0))),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Widgets.buildText(stat["label"].toString(), context,
                        color: "text.secondary")
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Widgets.buildText(
                          booking.containsKey("roomType")
                              ? (booking["roomType"] is List
                                  ? booking["roomType"][0]["listingName"]
                                      .toString()
                                  : (booking["roomType"]["listingName"] ??
                                          booking["roomType"]["title"])
                                      .toString())
                              : "",
                          context,
                          lines: 10,
                          isMedium: true),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ...List.generate(
                        num.tryParse(booking.containsKey("roomType")
                                    ? (booking["roomType"] is List
                                        ? booking["roomType"][0]["rating"]
                                            .toString()
                                        : booking["roomType"]["rating"]
                                            .toString())
                                    : "3")
                                ?.toInt() ??
                            3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Helpers.fetchIcons(
                          "star",
                          "solid",
                          color: "warning.main",
                          size: 14.0,
                        ),
                      );
                    })
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("calendar-clock", "solid"),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Widgets.buildText("Check-in date", context,
                                size: 13.0,
                                weight: 500,
                                color: "text.disabled"),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            Helpers.formatDate(booking["checkin"].toString(),
                                formatString: "EEE, d MMM yyyy"),
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Helpers.fetchIcons("calendar-clock", "solid"),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Widgets.buildText("Check-out date", context,
                                size: 13.0,
                                weight: 500,
                                color: "text.disabled"),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Widgets.buildText(
                            Helpers.formatDate(booking["checkout"].toString(),
                                formatString: "EEE, d MMM yyyy"),
                            context,
                            size: 13.0,
                            weight: 500)
                      ],
                    ),
                  ],
                ),
                if (booking.containsKey("checkinTime"))
                  const SizedBox(
                    height: 15.0,
                  ),
                if (booking.containsKey("checkinTime"))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText("Check-in time", context,
                              size: 13.0, weight: 500, color: "text.disabled"),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Widgets.buildText(
                              Helpers.formatDate(booking["checkin"].toString(),
                                  formatString: "hh:mma"),
                              context,
                              size: 13.0,
                              weight: 500)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Widgets.buildText("Check-out time", context,
                              size: 13.0, weight: 500, color: "text.disabled"),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Widgets.buildText(
                              Helpers.formatDate(booking["checkout"].toString(),
                                  formatString: "hh:mma"),
                              context,
                              size: 13.0,
                              weight: 500)
                        ],
                      ),
                    ],
                  ),
                if (booking["type"].toString() == '0')
                  const SizedBox(
                    height: 15.0,
                  ),
                if (booking["type"].toString() == '0')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Booked room(s)", context,
                          size: 13.0, weight: 500, color: "text.disabled"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(
                          booking.containsKey("roomType")
                              ? booking["roomType"] is List
                                  ? booking["roomType"]
                                      .map((room) =>
                                          "${room["title"].toString()} x ${room["quantity"]}")
                                      .toList()
                                      .join("\n")
                                  : "${booking["roomType"][0]["title"].toString()} x ${booking["quantity"]}"
                              : "",
                          context,
                          size: 13.0,
                          lines: 10,
                          weight: 500)
                    ],
                  ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Widgets.buildText("Property Address", context,
                        size: 13.0, weight: 500, color: "text.disabled"),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Widgets.buildText(
                        booking.containsKey("roomType")
                            ? (booking["roomType"] is List
                                ? booking["roomType"][0]["location"].toString()
                                : booking["roomType"]["location"].toString())
                            : "",
                        context,
                        size: 13.0,
                        weight: 500)
                  ],
                )
              ],
            )),
        // Container(
        //     width: double.infinity,
        //     padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        //     decoration: BoxDecoration(
        //       color: Palette.getColor(context, "background", "paper"),
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Helpers.fetchIcons(
        //                     booking["type"].toString() != "1" ? "bed" : "car",
        //                     "solid"),
        //                 const SizedBox(
        //                   width: 10.0,
        //                 ),
        //                 Widgets.buildText(
        //                     "${booking["type"].toString() != "1" ? "Property" : "Rental"} policies",
        //                     context,
        //                     isMedium: true,
        //                     color: "text.secondary"),
        //               ],
        //             ),
        //             Widgets.buildText("View policies", context,
        //                 size: 13.0,
        //                 weight: 400,
        //                 color: "main.primary",
        //                 isUnderlined: true)
        //           ],
        //         ),
        //       ],
        //     )),
        const SizedBox(
          height: 10.0,
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.buildText("Guest", context, isMedium: true),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Helpers.fetchIcons("user", "regular"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Expanded(
                          child: Widgets.buildText(
                              booking["guestName"].toString(), context,
                              size: 13.0, weight: 500, lines: 2),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("envelope", "regular"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Expanded(
                          child: Widgets.buildText(
                              booking["guestEmail"].toString(), context,
                              size: 13.0, weight: 500, lines: 2),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("phone-flip", "regular"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Widgets.buildText(
                          "+234${booking["guestPhone"].toString()}",
                          context,
                          size: 13.0,
                          weight: 500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("land-layer-location", "solid"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Expanded(
                          child: Widgets.buildText(
                              booking["guestAddress"].toString(), context,
                              size: 13.0, weight: 500, lines: 4),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.buildText("Vendor", context, isMedium: true),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Helpers.fetchIcons("user", "regular"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Widgets.buildText(
                          booking.containsKey("vendor") &&
                                  booking["vendor"].runtimeType != String
                              ? booking["vendor"]["name"].toString()
                              : booking["vendor"].toString(),
                          context,
                          size: 13.0,
                          weight: 500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("exclamation", "solid",
                            color: "warning.main"),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Widgets.buildText(
                          "Non-refundable",
                          context,
                          size: 13.0,
                          weight: 500,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Widgets.buildText(
                    "If you cancel, modify the booking, or don't show up, the fee will be the total price of the reservation.",
                    context,
                    size: 13.0,
                    weight: 500,
                    lines: 3,
                    color: "text.disabled"),
                const SizedBox(
                  height: 20.0,
                ),
                Widgets.buildText("Contact the property", context,
                    isMedium: true, color: "text.secondary"),
                const SizedBox(
                  height: 10.0,
                ),
                Widgets.buildText(
                    "Discuss changes to your booking or enquire about payments and refunds.",
                    context,
                    size: 13.0,
                    weight: 500,
                    lines: 3,
                    color: "text.disabled"),
              ],
            )),

        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Helpers.openLink(
                            "tel:${booking["vendor"]["phone"]}", "");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Helpers.fetchIcons("circle-phone", "solid",
                              size: 22.0),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText("Call Host", context,
                              size: 15.0, weight: 500, color: "text.disabled"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/messages",
                            arguments: jsonEncode(booking));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Helpers.fetchIcons("comment-alt", "solid",
                              size: 22.0),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText("Message Host", context,
                              size: 15.0, weight: 500, color: "text.disabled"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 20.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Payment method", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      "${booking["paymentMethod"].toString()} ${booking["paymentMethod"].toString() == "Card / Transfer" ? " (Paystack)" : ""}",
                      context,
                      color: "text.secondary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Subtotal", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      Helpers.formatCurrency(booking["amount"].toString()),
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Discount", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      "- ${Helpers.formatCurrency(booking["discount"].toString())}",
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Processing Fees", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      Helpers.formatCurrency(booking["fees"].toString()),
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Widgets.buildText("Total", context,
                      color: "text.disabled", size: 13.0, weight: 500),
                  const SizedBox(width: 10.0),
                  Widgets.buildText(
                      Helpers.formatCurrency(booking["total"].toString()),
                      context,
                      color: "main.primary",
                      size: 13.0,
                      weight: 500),
                ],
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            decoration: BoxDecoration(
              color: Palette.getColor(context, "background", "paper"),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Palette.get("text.white"),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border(
                                bottom: BorderSide(
                                    color: Palette.get("main.primary"))),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x0D000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 4.0,
                                  spreadRadius: 2)
                            ]),
                        child: UnconstrainedBox(
                            child: Helpers.fetchIcons(
                                booking["type"].toString() == "1"
                                    ? "bed"
                                    : "car-alt",
                                "solid",
                                color: "main.primary",
                                size: 20.0))),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/home",
                            arguments: "");
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Widgets.buildText(
                            booking["type"].toString() == "1"
                                ? "Book a stay"
                                : "Car rental",
                            context,
                            size: 13.0,
                            isMedium: true,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Widgets.buildText(
                              booking["type"].toString() == "1"
                                  ? "Need a place to stay? Book an hotel / short-let."
                                  : "Need a Ride? Book a Car Rental for Your Stay!",
                              context,
                              size: 12.0,
                              weight: 400,
                              lines: 3,
                              color: "text.secondary"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Actions", context, isMedium: true),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                SharePlus.instance.share(ShareParams(
                    title: booking["type"].toString() == "1"
                        ? "I rented a car from Noble Assets"
                        : "I booked a ${booking["type"].toString() == "0" ? "room" : "short-let"} from Noble Assets",
                    subject: booking["type"].toString() == "1"
                        ? "I rented a car from Noble Assets"
                        : "I booked a ${booking["type"].toString() == "0" ? "room" : "short-let"} from Noble Assets",
                    uri: Uri.https(
                      "nobleassets.com",
                      "/bookings/${booking["bookingId"]}",
                    )));
              },
              child: Row(
                children: [
                  Helpers.fetchIcons("paper-plane-top", "regular",
                      color: "main.primary"),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText("Share this booking", context,
                      size: 13.0, weight: 500, color: "main.primary")
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                SharePlus.instance.share(ShareParams(
                    title:
                        "Check out ${booking["roomType"][0]["listingName"].toString()} on Noble Assets",
                    subject:
                        "Check out ${booking["roomType"][0]["listingName"].toString()} on Noble Assets",
                    uri: Uri.https(
                      "nobleassets.com",
                      "/${booking["type"].toString() == "1" ? "rental" : "place"}/${booking["roomType"][0]["listingId"]}-${booking["roomType"][0]["listingName"].toString().toLowerCase().replaceAll(" ", "-")}",
                    )));
              },
              child: Row(
                children: [
                  Helpers.fetchIcons("inbox-out", "regular",
                      color: "main.primary"),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText("Share this listing", context,
                      size: 13.0, weight: 500, color: "main.primary")
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                SharePlus.instance.share(ShareParams(
                  title: "Find top stays and rentals at Noble Assets",
                  subject: "Find top stays and rentals at Noble Assets",
                  text:
                      "Check out the best stays and rental at Noble Assets. \n nobleassets.com",
                ));
              },
              child: Row(
                children: [
                  Helpers.fetchIcons("tap", "regular", color: "main.primary"),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText("Share this app", context,
                      size: 13.0, weight: 500, color: "main.primary")
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/home",
                    arguments: "1");
              },
              child: Row(
                children: [
                  Helpers.fetchIcons("calendar-day", "regular",
                      color: "main.primary"),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Widgets.buildText("Back to bookings", context,
                      size: 13.0, weight: 500, color: "main.primary")
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
