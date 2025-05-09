import 'package:afritas/globals/hotel_booking.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> with SingleTickerProviderStateMixin {
  final bookings = [
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "checkin": "2025-03-04 12:30:20",
      "checkout": "2025-04-04 12:30:20",
      "confirmationCode": "4378nd7343",
      "vendor": "Olamide Owoeye",
      "adults": "10",
      "children": 10,
      "infants": 5,
      "dateAdded": "2025-03-03 11:00:00",
      "quantity": 5,
      "roomType": "Deluxe Room",
      "type": "",
      "status": 4
    },
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "checkin": "2025-03-04 12:30:20",
      "checkout": "2025-04-04 12:30:20",
      "confirmationCode": "4378nd7343",
      "vendor": "Olamide Owoeye",
      "adults": "10",
      "children": 10,
      "infants": 5,
      "dateAdded": "2025-03-03 11:00:00",
      "quantity": 5,
      "roomType": "Deluxe Room",
      "type": "",
      "status": 4
    },
  ];

  @override
  void initState() {
    super.initState();
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
        title: Widgets.buildText("My Reviews", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.0, left: 0.0, right: 0.0, top: 20.0),
                    child: bookings.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              final item = bookings[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: Column(
                                  children: [
                                    if (index > 0)
                                      SizedBox(
                                        width: 25.0,
                                        height: 40.0,
                                        child: VerticalDivider(
                                            thickness: 1.0,
                                            color: Color(0x14000000)),
                                      ),
                                    HotelBooking(
                                      item: item,
                                      isReview: true,
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: bookings.length,
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/hotel.gif",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 30.0),
                                Widgets.buildText("No Reviews Yet", context,
                                    size: 24.0, weight: 500),
                                const SizedBox(height: 5.0),
                                Widgets.buildText(
                                    "You haven’t made any bookings yet, but don’t worry! Search and explore top hotels on Afritas to find the perfect stay.",
                                    lines: 4,
                                    context,
                                    isCenter: true,
                                    color: "text.secondary",
                                    size: 13.0,
                                    weight: 400),
                                const SizedBox(height: 30.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      style: Widgets.buildButton(context,
                                          background:
                                              Palette.get("main.primary"),
                                          vertical: 15.0,
                                          radius: 50.0),
                                      onPressed: () {},
                                      child: Widgets.buildText(
                                          "Find Hotels", context,
                                          color: "text.white", isMedium: true)),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
