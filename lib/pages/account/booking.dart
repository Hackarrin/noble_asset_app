import 'dart:convert';

import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> with SingleTickerProviderStateMixin {
  Map<String, dynamic> booking = {};

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
    final stat = Defaults.bookingStatus.firstWhere((stat) =>
        stat["value"].toString() == (booking["status"] ?? "0").toString());
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
            "Booking Details - #${booking["confirmationCode"]}", context,
            isMedium: true),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {},
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                                  booking["title"].toString(), context,
                                  isMedium: true),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            ...List.generate(
                                num.tryParse(booking["rating"].toString())
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
                                    Helpers.fetchIcons(
                                        "calendar-clock", "solid"),
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
                                    Helpers.formatDate(
                                        booking["checkin"].toString(),
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
                                    Helpers.fetchIcons(
                                        "calendar-clock", "solid"),
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
                                    Helpers.formatDate(
                                        booking["checkout"].toString(),
                                        formatString: "EEE, d MMM yyyy"),
                                    context,
                                    size: 13.0,
                                    weight: 500)
                              ],
                            ),
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
                                Widgets.buildText("Check-in time", context,
                                    size: 13.0,
                                    weight: 500,
                                    color: "text.disabled"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Widgets.buildText(
                                    Helpers.formatDate(
                                        booking["checkin"].toString(),
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
                                    size: 13.0,
                                    weight: 500,
                                    color: "text.disabled"),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Widgets.buildText(
                                    Helpers.formatDate(
                                        booking["checkout"].toString(),
                                        formatString: "hh:mma"),
                                    context,
                                    size: 13.0,
                                    weight: 500)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Property Address", context,
                                size: 13.0,
                                weight: 500,
                                color: "text.disabled"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Widgets.buildText(
                                booking["location"].toString(), context,
                                size: 13.0, weight: 500)
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("bed", "solid"),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Widgets.buildText("Property policies", context,
                                    isMedium: true, color: "text.secondary"),
                              ],
                            ),
                            Widgets.buildText("View policies", context,
                                size: 13.0,
                                weight: 400,
                                color: "main.primary",
                                isUnderlined: true)
                          ],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(
                            "You have booked ${booking["rooms"] ?? "1"} room",
                            context,
                            isMedium: true),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Widgets.buildText(
                            booking["roomType"].toString(), context,
                            size: 13.0, weight: 500, color: "text.secondary"),
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
                                  booking["vendor"].toString(),
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
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("circle-phone", "solid",
                                    size: 22.0),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Widgets.buildText("Call Host", context,
                                    size: 15.0,
                                    weight: 500,
                                    color: "text.disabled"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Helpers.fetchIcons("comment-alt", "solid",
                                    size: 22.0),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Widgets.buildText("Message Host", context,
                                    size: 15.0,
                                    weight: 500,
                                    color: "text.disabled"),
                              ],
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
                          Widgets.buildText("Wallet", context,
                              color: "text.secondary", size: 13.0, weight: 500),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Widgets.buildText("Total Price", context,
                              color: "text.disabled", size: 13.0, weight: 500),
                          const SizedBox(width: 10.0),
                          Widgets.buildText(
                              Helpers.formatCurrency(
                                  booking["price"].toString()),
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
                              Helpers.formatCurrency(
                                  booking["discount"].toString()),
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
                              Helpers.formatCurrency(booking["fee"].toString()),
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
                          Widgets.buildText("Subtotal (Naira)", context,
                              color: "text.disabled", size: 13.0, weight: 500),
                          const SizedBox(width: 10.0),
                          Widgets.buildText(
                              Helpers.formatCurrency(
                                  booking["price"].toString()),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                    decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Palette.get("text.white"),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Palette.get("main.primary"))),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x0D000000),
                                          offset: Offset(0, 1),
                                          blurRadius: 4.0,
                                          spreadRadius: 2)
                                    ]),
                                child: UnconstrainedBox(
                                    child: Helpers.fetchIcons(
                                        "car-alt", "solid",
                                        color: "main.primary", size: 20.0))),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Car rental", context,
                                      size: 13.0,
                                      weight: 500,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText(
                                      "Need a Ride? Book a Car Rental for Your Stay!",
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
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                    decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Palette.get("text.white"),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Palette.get("main.primary"))),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x0D000000),
                                          offset: Offset(0, 1),
                                          blurRadius: 4.0,
                                          spreadRadius: 2)
                                    ]),
                                child: UnconstrainedBox(
                                    child: Helpers.fetchIcons(
                                        "calendar-day", "solid",
                                        color: "main.primary", size: 20.0))),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText(
                                      "Event and Attraction", context,
                                      size: 13.0,
                                      weight: 500,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText(
                                      "Enjoy Flexibility Book Attractions with Free Cancellation",
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
                Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                    decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Palette.get("text.white"),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Palette.get("main.primary"))),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x0D000000),
                                          offset: Offset(0, 1),
                                          blurRadius: 4.0,
                                          spreadRadius: 2)
                                    ]),
                                child: UnconstrainedBox(
                                    child: Helpers.fetchIcons("ship", "solid",
                                        color: "main.primary", size: 20.0))),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Boat", context,
                                      size: 13.0,
                                      weight: 500,
                                      color: "text.secondary"),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Widgets.buildText(
                                      "Set Sail on Adventure! Book a Cruise with Your Stay",
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
                    Row(
                      children: [
                        Helpers.fetchIcons("paper-plane-top", "regular",
                            color: "main.primary"),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Widgets.buildText("Share this bookings", context,
                            size: 13.0, weight: 500, color: "main.primary")
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("inbox-out", "regular",
                            color: "main.primary"),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Widgets.buildText("Share this property", context,
                            size: 13.0, weight: 500, color: "main.primary")
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Helpers.fetchIcons("tap", "regular",
                            color: "main.primary"),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Widgets.buildText("Share this app", context,
                            size: 13.0, weight: 500, color: "main.primary")
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
