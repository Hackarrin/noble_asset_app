import 'dart:convert';

import 'package:cribsfinder/globals/automobile_item.dart';
import 'package:cribsfinder/globals/property_item.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/markers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property>
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

  int _roomSelected = -1;
  Map _numRooms = {};

  bool _isReviewAll = false;
  List<String> reviewFilter = ["verified", "latest"];
  bool isDescriptionExpanded = false;
  String selectedCategory = "buy";

  Map<String, dynamic> filter = {
    "pickupDate": "",
    "dropoffDate": "",
    "pickupLocation": "",
    "dropoffLocation": "",
    "dropoffTime": "",
    "pickupTime": "",
    "adults": 1
  };
  List<Map<String, dynamic>> _selectedRooms = [];
  List<int> openedFaq = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void updateData(Map<String, dynamic>? res) {
    try {
      startDateController.text =
          Helpers.formatDate(filter["checkin"], formatString: "MMM dd");
      endDateController.text =
          Helpers.formatDate(filter["checkout"], formatString: "MMM dd");
      adultsController.text = Helpers.formatNumber(filter["adults"].toString());
      childrenController.text =
          Helpers.formatNumber(filter["children"].toString());
      roomsController.text = Helpers.formatNumber(filter["rooms"].toString());
      if (res != null) {
        setState(() {
          filter = res;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  final Map<String, dynamic> _data = {
    "title": "Opulence Apartment",
    "latitude": 6.5,
    "bathroom": 5,
    "sittingroom": 10,
    "bedrooms": 5,
    "length": 1200,
    "year": "1980",
    "listingType": "Detached",
    "longitude": 3.4,
    "price": 6100000,
    "location": "Abuja, Durumi, Garki, Abuja Municipal Area Council,  Nigeria",
    "images": [
      "assets/images/rent.jpg",
      "assets/images/buy.jpg",
      "assets/images/rent.jpg",
      "assets/images/buy.jpg",
      "assets/images/rent.jpg",
      "assets/images/buy.jpg",
      "assets/images/rent.jpg",
      "assets/images/buy.jpg",
    ],
    "passengers": "6",
    "power": "Hybrid",
    "steering": "Automatic",
    "doors": "4",
    "type": "4x4",
    "seats": 4,
    "favourite": 1,
    "roomType": "Deluxe Room",
    "rating": 3.9,
    "isBreakfast": 1,
    "hotelId": "327833",
    "totalReviews": 75,
    "description":
        "Located within 3.2 km of Nike Art Gallery and 7.9 km of Lekki Conservation Centre, Jotani Living provides rooms with air conditioning and a private bathroom in Lagos. This property offers access to a balcony and free private parking. The accommodation offers a 24-hour front desk and full-day.<br /><br />Featuring free WiFi, the units have a washing machine and a flat-screen TV with cable channels. Each unit is equipped with a private bathroom equipped with a walk-in shower, while some rooms include a fully equipped kitchen.",
    "publisher": {
      "name": "Urban hotels",
      "image": "avatar.png",
      "isVerified": 1,
      "reviews": 173,
      "rating": 4.9,
      "years": 8,
      "isNameConfirmed": 1,
      "isEmailConfirmed": 1,
      "isPhoneConfirmed": 1,
      "details": "Response rate 100%,Responds within an hour",
    },
    "amenities": [
      "workspace",
      "parking",
      "swimming_pool",
      "wifi",
      "gym",
      "pet",
      "reception",
      "breakfast"
    ],
    "rooms": [
      {
        "name": "Twin Bed Classic",
        "image": "assets/images/room.jpeg",
        "images": [
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg"
        ],
        "singleBed": 2,
        "doubleBed": 3,
        "largeBed": 3,
        "xLargeBed": 3,
        "occupants": 3,
        "roomSize": 25,
        "amenities": ["gym", "pets"],
        "other_amenities": [
          "Shower",
          "Washing Machine",
          "Toilet",
          "Towels",
          "TV",
          "Refrigerator",
          "Microwave",
          "Kitchenware",
          "Kitchenette",
          "Cable channels",
          "Toaster",
          "Dining area",
          "Dining table",
          "Private apartment in building",
          "Entire unit wheelchar accessible",
        ],
        "price": 40000,
        "quantity": 5,
        "attributes": [
          "Continental breakfast included",
          "Free cancellation before 18:00  on 22 May 2024",
          "Prepayment needed",
        ],
        "isReserved": 1,
      },
      {
        "name": "Queen Bed Classic",
        "image": "assets/images/room.jpeg",
        "images": [
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg",
          "assets/images/room.jpeg"
        ],
        "singleBed": 2,
        "doubleBed": 3,
        "largeBed": 3,
        "xLargeBed": 3,
        "occupants": 3,
        "roomSize": 35,
        "amenities": ["gym", "pets", "breakfast"],
        "other_amenities": [
          "Shower",
          "Washing Machine",
          "Toilet",
          "Towels",
          "TV",
          "Refrigerator",
          "Microwave",
          "Kitchenware",
          "Kitchenette",
          "Cable channels",
          "Toaster",
          "Dining area",
          "Dining table",
          "Private apartment in building",
          "Entire unit wheelchar accessible",
        ],
        "price": 80000,
        "quantity": 5,
        "attributes": [
          "Continental breakfast included",
          "Free cancellation before 18:00  on 22 May 2024",
          "Prepayment needed",
        ],
        "isReserved": 1,
      },
    ],
    'landmarks': ["Abuja", "Durumi", "Abuja Municipal Area Council", "Nigeria"],
    "locations": [
      {"name": "Lagos", "value": "lagos"},
      {"name": "Abuja", "value": "abuja"},
      {"name": "Ibadan", "value": "ibadan"},
      {"name": "Ado Ekiti", "value": "ado-ekiti"},
      {"name": "Port harcourt", "value": "port-harcourt"},
      {"name": "Epe", "value": "epe"},
    ],
    "reviews": {
      "rating": 4.9,
      "ratingText": "Very Good",
      "totalReviews": 415,
      "cleanliness": 4.5,
      "location": 4.6,
      "value": 4.7,
      "comfort": 4.8,
      "facilities": 4.9,
      "accuracy": 5.0,
      "communication": 4.2,
      "wifi": 4.1,
      "reviews": [
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "flag":
              '<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="600" viewBox="0 0 6 3"><title>Flag of Nigeria</title><path fill="#008751" d="m0 0h6v3H0z"/><path fill="#fff" d="m2 0h2v3H2z"/></svg>',
          "rating": 4,
          "date": "7 days ago",
          "photo": "assets/images/avatar.png",
          "photos": [
            "assets/images/hotels.jpeg",
            "assets/images/hotels.jpeg",
            "assets/images/hotels.jpeg"
          ],
          "room": {
            "type": "Standard Double Room",
            "checkin": "2024-01-02",
            "checkout": "2024-02-02"
          },
          "response": {
            "name": "Responder Samuel",
            "location": "Nigeria",
            "rating": 4,
            "date": "7 days ago",
            "photo": "",
            "review":
                "We're sorry to hear that you forgot some items during your stay. Please contact our front desk as soon as possible, and we'll do our best to locate your belongings and arrange for their return. Your satisfaction is important to us, and we're here to help."
          },
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
      ],
    },
    "rules": [
      {
        "title": "Check-In and Check-Out",
        "content": "Check-in after 16:00",
        "description":
            "Check-in time starts at 2:00 PM; check-out is by 11:00 AM.\nEarly check-in or late check-out may be available for an additional fee (subject to availability).",
        "icon": "check-in-calendar",
      },
      {
        "title": "Identification and Payment",
        "content": "Smoking is allowed",
        "description":
            "A valid government-issued ID is required at check-in.\nFull payment is due upon arrival unless pre-paid.",
        "icon": "mode-portrait",
      },
      {
        "title": "No Smoking Policy",
        "content": "Smoking is strictly prohibited.",
        "description":
            "Smoking is strictly prohibited in rooms and indoor areas.\nDesignated smoking areas are provided. Guests violating this rule may incur a cleaning fee.",
        "icon": "smoking-ban",
      },
      {
        "title": "Quiet Hours",
        "content": "Maintain low noise levels between 10:00 PM and 7:00 AM.",
        "description":
            "Maintain low noise levels between 10:00 PM and 7:00 AM to respect other guests.",
        "icon": "volume-slash",
      },
      {
        "title": "Room Occupancy",
        "content": "6 guests maximum",
        "description":
            "The maximum number of guests per room is as specified in your booking.\nUnauthorized extra guests may result in additional charges or cancellation.",
        "icon": "users-alt",
      },
      {
        "title": "Cancellation and Refunds",
        "content": "Lorem ipsum dolor ",
        "description":
            "Cancellations made within the agreed period will receive a refund, as per our cancellation policy.\nNo-shows and last-minute cancellations may forfeit their booking fee.",
        "icon": "refund",
      },
      {
        "title": "Pets",
        "content": "Pets allowed",
        "description":
            "Pets are not allowed unless specified in your booking confirmation.\nA pet fee may apply, and additional rules will be shared if pets are accommodated.",
        "icon": "paw",
      },
      {
        "title": "Age restrictions",
        "content": "Lorem ipsum dolor ",
        "description": "Lorem ipsum dolor ",
        "icon": "arrow-right",
      },
      {
        "title": "Accepted payment methods",
        "content": "Lorem ipsum dolor ",
        "icon": "credit-card",
      },
    ],
    "similarHotels": [
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "acres": 400,
        "amenities":
            "[\"water\",\"street_light\",\"gas\",\"drainage\",\"light\",\"internet\",\"playground\",\"security\"]"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "acres": 400,
        "amenities":
            "[\"water\",\"street_light\",\"gas\",\"drainage\",\"light\",\"internet\",\"playground\",\"security\"]"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "acres": 400,
        "amenities":
            "[\"water\",\"street_light\",\"gas\",\"drainage\",\"light\",\"internet\",\"playground\",\"security\"]"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "baths": 2,
        "garage": 5,
        "beds": 4
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000",
        "acres": 400,
        "amenities":
            "[\"water\",\"street_light\",\"gas\",\"drainage\",\"light\",\"internet\",\"playground\",\"security\"]"
      },
    ],
    "faq": [
      {
        "question": "How do I book a ticket?",
        "answer":
            "Select a date and time.\nChoose the number of tickets.\nClick through to the next page and enter your personal details."
      },
      {"question": "Can I cancel or modify my tickets?", "answer": "Yes."},
      {"question": "Can I cancel or modify my tickets?", "answer": "Yes."},
      {"question": "Can I cancel or modify my tickets?", "answer": "Yes."},
      {"question": "Can I cancel or modify my tickets?", "answer": "Yes."},
    ]
  };
  Set<Marker> _markers = {};
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final defaultDate = DateTime.now();
          final defaultEndDate = DateTime.now().add(Duration(days: 1));

          setState(() {
            filter["pickupLocation"] = "Lekki, Lagos";
            filter["dropoffLocation"] = "Lekki, Lagos";
            filter["pickupDate"] =
                "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}";
            filter["dropoffDate"] =
                "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
            filter["pickupTime"] =
                "${defaultDate.hour}:${defaultDate.minute > 9 ? defaultDate.minute : "0${defaultDate.minute}"}:${defaultDate.second > 9 ? defaultDate.second : "0${defaultDate.second}"}";
            filter["dropoffTime"] =
                "${defaultEndDate.hour}:${defaultEndDate.minute > 9 ? defaultEndDate.minute : "0${defaultEndDate.minute}"}:${defaultEndDate.second > 9 ? defaultEndDate.second : "0${defaultEndDate.second}"}";
          });
          updateData(null);
          final data = jsonDecode(arguments.toString());
          // markers
          List<Marker> markers = [];
          final icon = await HotelSingleMarker(icon: "bed").toBitmapDescriptor(
              logicalSize: const Size(250, 250),
              imageSize: const Size(250, 250));
          Marker marker = Marker(
              markerId: MarkerId(_data["hotelId"].toString()),
              icon: icon,
              position: LatLng(
                  num.tryParse(_data["latitude"].toString())?.toDouble() ??
                      _center.latitude,
                  num.tryParse(_data["longitude"].toString())?.toDouble() ??
                      _center.longitude),
              onTap: () {});
          markers.add(marker);
          setState(() {
            _markers = markers.toSet();
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
    tabController.dispose();
  }

  void handleCheckout({isBuyNow = true}) {
    try {
      if (filter["pickupLocation"].toString().isNotEmpty &&
          filter["dropoffLocation"].toString().isNotEmpty) {
        if ((num.tryParse(filter["adults"].toString())?.toInt() ?? 0) <=
            (num.tryParse(_data["seats"].toString())?.toInt() ?? 0)) {
          final defaultPrice =
              num.tryParse(_data["price"].toString())?.toDouble() ?? 0;
          if (Helpers.handleCalendarEntry([
                filter["pickupDate"].toString(),
                filter["dropoffDate"].toString()
              ], _data["calendar"] ?? [], defaultPrice,
                  _data["listingId"] ?? "") >
              0) {
            Helpers.addToCart(_data, 2, {
              "dateFrom": Helpers.formatDate(filter["pickupDate"]),
              "dateTo": Helpers.formatDate(filter["dropoffDate"]),
              "time": Helpers.formatDate(
                  "${filter["pickupDate"]} ${filter["pickupTime"]}",
                  formatString: "HH:mm:ss"),
              "endTime": Helpers.formatDate(
                  "${filter["dropoffDate"]} ${filter["dropoffTime"]}",
                  formatString: "HH:mm:ss"),
              "selectedRoom": {
                "pickupLocation": filter["pickupLocation"],
                "dropoffLocation": filter["dropoffLocation"],
              },
              "numRooms": 1,
              "numNights": Helpers.dateDiff(filter["pickupDate"].toString(),
                  filter["dropoffDate"].toString()),
              "adults": num.tryParse(filter["adults"].toString())?.toInt() ?? 1,
              "children": 0,
              "infants": 0
            });
          } else {
            Alert.show(context, "",
                "This item is not available for the date(s) selected! Please select a different date to proceed.",
                type: "warning");
          }
        } else {
          Alert.show(context, "",
              "You cannot set the number of people more than ${_data["seats"]}",
              type: "warning");
        }
      } else {
        Alert.show(context, "",
            "Please enter a valid pickup and dropoff location to proceed.",
            type: "warning");
      }
    } catch (err) {
      print(err);
      // console.log(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.getColor(context, "background", "paper"),
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
        title: Widgets.buildText("Details", context, isMedium: true),
        actions: [
          IconButton(
            onPressed: () async {},
            style: Widgets.buildButton(context,
                sideColor: Palette.getColor(context, "background", "neutral"),
                radius: 40.0),
            icon: Helpers.fetchIcons("paper-plane-top", "regular",
                size: 16.0, color: "text.other"),
          ),
          IconButton(
            onPressed: () async {},
            style: Widgets.buildButton(context,
                sideColor: Palette.getColor(context, "background", "neutral"),
                radius: 40.0),
            icon: Helpers.fetchIcons("heart", "regular",
                size: 16.0, color: "text.other"),
          ),
          const SizedBox(width: 10.0),
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: DefaultTabController(
                length: 3,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Sheets.showImagePreview(
                            _data["images"], _data["title"].toString());
                      },
                      child: Stack(
                        children: [
                          Image.asset(_data["images"][_selectedImageIndex],
                              width: double.infinity,
                              height: 350,
                              fit: BoxFit.cover),
                          Positioned(
                            top: 30.0,
                            right: 30.0,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0x80FFFFFF),
                                    borderRadius: BorderRadius.circular(90.0)),
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  spacing: 5.0,
                                  children: [
                                    for (var i = 0;
                                        i <
                                            (_data["images"].length > 3
                                                ? 3
                                                : _data["images"].length);
                                        i += 1)
                                      Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.asset(
                                                  _data["images"][0],
                                                  width: 40.0,
                                                  height: 40.0,
                                                  fit: BoxFit.cover)),
                                          if (_data["images"].length > 3 &&
                                              i == 2)
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(
                                                          "background.overlay"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Center(
                                                    child: Widgets.buildText(
                                                        "+${(_data["images"].length - 3).toString()}",
                                                        context,
                                                        color: "text.white",
                                                        isMedium: true),
                                                  ),
                                                ))
                                        ],
                                      )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Palette.get("background.neutral"),
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Widgets.buildText("New Build", context,
                                  color: "main.primary")),
                          Container(
                              decoration: BoxDecoration(
                                  color: Palette.get("background.neutral"),
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Widgets.buildText("Safety Types", context,
                                  color: "text.primary")),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText(
                                    _data["title"].toString(), context,
                                    isBold: true, color: "text.secondary"),
                                Widgets.buildText(
                                    _data["landmarks"].join(", ").toString(),
                                    context,
                                    color: "text.other",
                                    lines: 1),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Widgets.buildText(
                              Helpers.formatCurrency(_data["price"].toString()),
                              context,
                              isMedium: true,
                              color: "main.primary")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 90.0, top: 10.0),
                      child: Column(children: [
                        if (_selectedTab == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                          mainAxisExtent: 70.0),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    Map<String, String> content = {
                                      "title": "",
                                      "icon": ""
                                    };
                                    switch (index) {
                                      case 0:
                                        content = {
                                          "title":
                                              "${_data["bedrooms"].toString()} Bedrooms",
                                          "icon": "bed-empty"
                                        };
                                        break;
                                      case 1:
                                        content = {
                                          "title":
                                              "${_data["sittingroom"].toString()} Sitting room",
                                          "icon": "couch"
                                        };
                                        break;
                                      case 2:
                                        content = {
                                          "title":
                                              "${_data["bathroom"].toString()} Bathrooms",
                                          "icon": "bath"
                                        };
                                        break;
                                      case 3:
                                        content = {
                                          "title":
                                              "${_data["length"].toString()} sqm",
                                          "icon": "bath"
                                        };
                                        break;
                                      case 4:
                                        content = {
                                          "title":
                                              "Built in ${_data["year"].toString()}",
                                          "icon": "clock-three"
                                        };
                                        break;
                                      case 5:
                                        content = {
                                          "title":
                                              _data["listingType"].toString(),
                                          "icon": "home"
                                        };
                                        break;
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 5.0,
                                      children: [
                                        Helpers.fetchIcons(
                                            content["icon"].toString(), "solid",
                                            color: "text.black", size: 24.0),
                                        Widgets.buildText(
                                            content["title"].toString(),
                                            context,
                                            color: "text.secondary")
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Description", context,
                                      isMedium: true),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Wrap(
                                    children: [
                                      Widgets.buildText(
                                          _data["description"]
                                              .toString()
                                              .replaceAll("<br />", "\n"),
                                          context,
                                          lines:
                                              isDescriptionExpanded ? 2000 : 3),
                                      if (Helpers.hasTextOverflow(
                                          _data["description"].toString(),
                                          maxLines: 3))
                                        GestureDetector(
                                          onTap: () => setState(() =>
                                              isDescriptionExpanded =
                                                  !isDescriptionExpanded),
                                          child: Widgets.buildText(
                                              isDescriptionExpanded
                                                  ? "Show less"
                                                  : "Read more",
                                              context,
                                              weight: 500,
                                              color: "main.primary",
                                              isUnderlined: true),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Meet Your Agent", context,
                                      isMedium: true),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Palette.get("background.paper"),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x1A000000),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: Offset(-1, 1),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border(
                                            top: BorderSide(
                                                color: Palette.get(
                                                    "main.primary")))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Helpers.getPhoto(
                                                _data["publisher"]["image"]
                                                        .toString()
                                                        .isEmpty
                                                    ? ""
                                                    : "assets/images/${_data["publisher"]["image"].toString()}",
                                                text: _data["publisher"]
                                                    ["name"],
                                                height: 80.0),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                        child: Widgets.buildText(
                                                            _data["publisher"]
                                                                ["name"],
                                                            context,
                                                            size: 16.0,
                                                            weight: 500,
                                                            lines: 1),
                                                      ),
                                                      FittedBox(
                                                        child: Widgets.buildText(
                                                            "${_data["publisher"]["years"].toString()} year${(num.tryParse(_data["publisher"]["years"].toString())?.toInt() ?? 0) > 1 ? "s" : ""} hosting",
                                                            context,
                                                            color:
                                                                "text.secondary",
                                                            lines: 1),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 25.0,
                                                  height: 25.0,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color(0xFF41B11A),
                                                            Color(0xFF61FF61)
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  child: Center(
                                                      child: Widgets.buildText(
                                                          "1", context,
                                                          color: "text.white")),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Widgets.buildText("Landmark", context,
                                      isMedium: true),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x0A000000),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                4), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Color(0x1A000000)),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.all(5.0),
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: GoogleMap(
                                          onMapCreated: _onMapCreated,
                                          initialCameraPosition: CameraPosition(
                                            target: _center,
                                            zoom: 11.0,
                                          ),
                                          mapToolbarEnabled: false,
                                          zoomControlsEnabled: false,
                                          markers: _markers),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Helpers.fetchIcons("marker", "solid",
                                          color: "main.primary"),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                        child: Widgets.buildText(
                                            _data["landmarks"]
                                                .join(", ")
                                                .toString(),
                                            context,
                                            color: "text.secondary"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.paper"),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(-1, 1),
                                          blurRadius: 12,
                                          spreadRadius: 0,
                                          color: Color(0x17000000))
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Palette.get("main.primary")))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  spacing: 15.0,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText(
                                        "More information", context,
                                        isMedium: true,
                                        color: "text.secondary"),
                                    Row(
                                      spacing: 10.0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          spacing: 5.0,
                                          children: [
                                            Helpers.fetchIcons(
                                                "blueprint", "regular",
                                                size: 16.0,
                                                color: "text.secondary"),
                                            Widgets.buildText(
                                                "Floor plans", context,
                                                size: 14.0),
                                          ],
                                        ),
                                        Helpers.fetchIcons(
                                            "caret-right", "regular",
                                            size: 24.0, color: "main.primary"),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10.0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          spacing: 5.0,
                                          children: [
                                            Helpers.fetchIcons(
                                                "film", "regular",
                                                size: 16.0,
                                                color: "text.secondary"),
                                            Widgets.buildText("Video", context,
                                                size: 14.0),
                                          ],
                                        ),
                                        Helpers.fetchIcons(
                                            "caret-right", "regular",
                                            size: 24.0, color: "main.primary"),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10.0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          spacing: 5.0,
                                          children: [
                                            Helpers.fetchIcons(
                                                "copy-image", "regular",
                                                size: 16.0,
                                                color: "text.secondary"),
                                            Widgets.buildText("Images", context,
                                                size: 14.0),
                                          ],
                                        ),
                                        Helpers.fetchIcons(
                                            "caret-right", "regular",
                                            size: 24.0, color: "main.primary"),
                                      ],
                                    ),
                                    Row(
                                      spacing: 10.0,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          spacing: 5.0,
                                          children: [
                                            Helpers.fetchIcons(
                                                "document", "regular",
                                                size: 16.0,
                                                color: "text.secondary"),
                                            Widgets.buildText(
                                                "Documents", context,
                                                size: 14.0),
                                          ],
                                        ),
                                        Helpers.fetchIcons(
                                            "caret-right", "regular",
                                            size: 24.0, color: "main.primary"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Widgets.buildText(
                                  "Property for Sale from ${_data["publisher"]["name"]}",
                                  context,
                                  color: "text.secondary",
                                  isMedium: true,
                                  lines: 2),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Palette.getColor(
                                        context, "background", "default"),
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 10.0,
                                  children: [
                                    for (final category
                                        in Defaults.propertyCategories)
                                      if (category["value"]
                                          .toString()
                                          .isNotEmpty)
                                        TextButton(
                                          style: Widgets.buildButton(context,
                                              horizontal: 15.0,
                                              vertical: 10.0,
                                              radius: 10.0,
                                              background: selectedCategory ==
                                                      category["value"]
                                                          .toString()
                                                  ? Palette.get("main.primary")
                                                  : Colors.transparent),
                                          onPressed: () {
                                            setState(() => selectedCategory =
                                                category["value"].toString());
                                          },
                                          child: Widgets.buildText(
                                              category["name"].toString(),
                                              context,
                                              color: selectedCategory ==
                                                      category["value"]
                                                          .toString()
                                                  ? "text.white"
                                                  : "text.secondary"),
                                        )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              ConstrainedBox(
                                  constraints: BoxConstraints.loose(
                                      Size(screenWidth, 280.0)),
                                  child: Swiper(
                                    outer: true,
                                    layout: SwiperLayout.CUSTOM,
                                    customLayoutOption: Widgets.customLayout(
                                        _data["similarHotels"].length,
                                        screenWidth,
                                        offset: 80.0),
                                    itemHeight: 280.0,
                                    itemWidth: screenWidth,
                                    loop: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item =
                                          _data["similarHotels"][index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 70.0),
                                        child: PropertyItem(
                                          item: item,
                                        ),
                                      );
                                    },
                                    itemCount: _data["similarHotels"].length,
                                  )),
                            ],
                          ),
                        if (_selectedTab == 1)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Widgets.buildText("Gallery", context,
                                      isMedium: true),
                                  Widgets.buildText(
                                      " (${Helpers.formatNumber((_data["images"].length + _data["rooms"].map((room) => room["images"].length).reduce((a, b) => a + b)).toString())})",
                                      context,
                                      isMedium: true,
                                      color: "main.primary"),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final List<String> photos = index == 0
                                        ? _data["images"]
                                        : _data["rooms"][index - 1]["images"];

                                    final String title = index == 0
                                        ? "All Photos"
                                        : _data["rooms"][index - 1]["name"]
                                            .toString();
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 40.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Widgets.buildText(title, context,
                                              color: "main.primary"),
                                          const SizedBox(height: 20.0),
                                          GridView.count(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 15,
                                              crossAxisSpacing: 15,
                                              physics:
                                                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                for (final item in photos)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Sheets.showImagePreview(
                                                          photos, title);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: Image.asset(
                                                        item,
                                                        height: 110,
                                                        width: 110,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                              ])
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: _data["rooms"].length + 1)
                            ],
                          ),
                        if (_selectedTab == 2)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets.buildText("Guest reviews", context,
                                  isMedium: true),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                decoration: Widgets.inputDecoration(
                                    "Search in reviews",
                                    isOutline: true,
                                    hint: "Search in reviews",
                                    hintColor: Palette.get("text.secondary"),
                                    prefixIcon: UnconstrainedBox(
                                      child: Helpers.fetchIcons(
                                          "search", "regular",
                                          size: 20.0, color: "main.primary"),
                                    ),
                                    color: Palette.get("background.default"),
                                    radius: 40.0,
                                    isFilled: true,
                                    isFloating: true),
                                style: GoogleFonts.nunito(
                                  color: Palette.get("text.secondary"),
                                  fontSize: 16.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {},
                                    child: Chip(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          Palette.get("background.default"),
                                      label: Widgets.buildText(
                                          "Filters", context,
                                          weight: 500),
                                    ),
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (reviewFilter.contains("verified")) {
                                          reviewFilter.remove("verified");
                                        } else {
                                          reviewFilter.add("verified");
                                        }
                                      });
                                    },
                                    child: Chip(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: reviewFilter
                                              .contains("verified")
                                          ? Palette.get("main.primary")
                                          : Palette.get("background.default"),
                                      label: FittedBox(
                                        child: Widgets.buildText(
                                            "Verified", context,
                                            weight: 500,
                                            color: reviewFilter
                                                    .contains("verified")
                                                ? "text.white"
                                                : "text.primary"),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (reviewFilter.contains("latest")) {
                                          reviewFilter.remove("latest");
                                        } else {
                                          reviewFilter.add("latest");
                                        }
                                      });
                                    },
                                    child: Chip(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: reviewFilter
                                              .contains("latest")
                                          ? Palette.get("main.primary")
                                          : Palette.get("background.default"),
                                      label: FittedBox(
                                        child: Widgets.buildText(
                                            "Latest", context,
                                            weight: 500,
                                            color:
                                                reviewFilter.contains("latest")
                                                    ? "text.white"
                                                    : "text.primary"),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (reviewFilter.contains("photos")) {
                                          reviewFilter.remove("photos");
                                        } else {
                                          reviewFilter.add("photos");
                                        }
                                      });
                                    },
                                    child: Chip(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: reviewFilter
                                              .contains("photos")
                                          ? Palette.get("main.primary")
                                          : Palette.get("background.default"),
                                      label: FittedBox(
                                        child: Widgets.buildText(
                                            "With Photos", context,
                                            weight: 500,
                                            color:
                                                reviewFilter.contains("photos")
                                                    ? "text.white"
                                                    : "text.primary"),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.paper"),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5.0,
                                          spreadRadius: 0,
                                          offset: Offset(-1, 1),
                                          color: Color(0x1A000000))
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    for (final category in (_isReviewAll
                                        ? Defaults.hotelReviewCategories
                                        : Defaults.hotelReviewCategories
                                            .getRange(0, 3)))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Widgets.buildText(
                                                    category["name"].toString(),
                                                    context,
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                      "(${Helpers.formatNumber((((num.tryParse(_data["reviews"][category["value"].toString()].toString())?.toDouble() ?? 0.0) / 5.0) * 100.0).toString())}%)",
                                                      context,
                                                      color: "main.primary")
                                                ],
                                              ),
                                              if (category["name"]!
                                                      .toLowerCase() ==
                                                  "cleanliness")
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _isReviewAll =
                                                            !_isReviewAll;
                                                      });
                                                    },
                                                    child: Widgets.buildText(
                                                        _isReviewAll
                                                            ? "See less"
                                                            : "See all",
                                                        context,
                                                        weight: 500,
                                                        color: "main.primary"))
                                            ],
                                          ),
                                          SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                                    trackHeight: 20.0,
                                                    thumbShape:
                                                        RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                17),
                                                    padding:
                                                        EdgeInsets.all(0.0)),
                                            child: Slider(
                                                inactiveColor: Palette.getColor(
                                                    context,
                                                    "background",
                                                    "textfield"),
                                                value: (((num.tryParse(_data[
                                                                    "reviews"][category[
                                                                        "value"]
                                                                    .toString()]
                                                                .toString())
                                                            ?.toDouble() ??
                                                        0.0) /
                                                    5.0)),
                                                onChanged: (value) {}),
                                          ),
                                        ]),
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final review =
                                        _data["reviews"]["reviews"][index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Helpers.getPhoto(
                                                      review["photo"] ?? "",
                                                      height: 60.0),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Widgets.buildText(
                                                              review["name"]
                                                                  .toString(),
                                                              context,
                                                              isMedium: true),
                                                          Widgets.buildText(
                                                              review["date"]
                                                                  .toString(),
                                                              context,
                                                              color:
                                                                  "text.secondary"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child:
                                                            SvgPicture.string(
                                                          review["flag"]
                                                              .toString(),
                                                          width: 25.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          (num.tryParse(review[
                                                                          "rating"]
                                                                      .toString())
                                                                  ?.toInt() ??
                                                              0);
                                                      i += 1)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2.0),
                                                      child: Helpers.fetchIcons(
                                                          "star", "solid",
                                                          color: "warning.main",
                                                          size: 18.0),
                                                    )
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 60.0),
                                            child: Column(
                                              children: [
                                                if (review
                                                    .containsKey("photos"))
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 15.0),
                                                    child: Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      children: [
                                                        for (final photo
                                                            in review["photos"])
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image.asset(
                                                                photo,
                                                                height: 120,
                                                                fit: BoxFit
                                                                    .contain),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                Widgets.buildText(
                                                    review["review"].toString(),
                                                    context,
                                                    color: "text.disabled",
                                                    lines: 100),
                                                const SizedBox(height: 10.0),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Color(
                                                              0x33000000))),
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Helpers.fetchIcons(
                                                              "bed", "regular",
                                                              size: 16.0,
                                                              color:
                                                                  "text.secondary"),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Widgets.buildText(
                                                              review["room"]
                                                                      ["type"]
                                                                  .toString(),
                                                              context,
                                                              color:
                                                                  "text.secondary")
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Row(
                                                        children: [
                                                          Helpers.fetchIcons(
                                                              "calendar-day",
                                                              "regular",
                                                              size: 16.0,
                                                              color:
                                                                  "text.secondary"),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Widgets.buildText(
                                                              "${Helpers.dateDiff(review["room"]["checkin"].toString(), review["room"]["checkout"].toString()).toString()} Night${Helpers.dateDiff(review["room"]["checkin"].toString(), review["room"]["checkout"].toString()) > 1 ? "s" : ""} • ${Helpers.formatDistanceDate(review["room"]["checkin"].toString(), review["room"]["checkout"].toString())}",
                                                              context,
                                                              color:
                                                                  "text.secondary")
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0),
                                                if (review
                                                    .containsKey("response"))
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Row(
                                                        children: [
                                                          Helpers.getPhoto(
                                                              review["response"]
                                                                      [
                                                                      "photo"] ??
                                                                  "",
                                                              text: review[
                                                                          "response"]
                                                                      ["name"]
                                                                  .toString(),
                                                              height: 40.0),
                                                          const SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Widgets.buildText(
                                                                    "Response from ${review["response"]["name"].toString()}",
                                                                    context,
                                                                    color:
                                                                        "text.secondary"),
                                                                Widgets.buildText(
                                                                    review["date"]
                                                                        .toString(),
                                                                    context,
                                                                    color:
                                                                        "text.disabled"),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Widgets.buildText(
                                                          review["response"]
                                                                  ["review"]
                                                              .toString(),
                                                          context,
                                                          color:
                                                              "text.disabled",
                                                          lines: 100)
                                                    ],
                                                  )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      _data["reviews"].containsKey("reviews")
                                          ? _data["reviews"]["reviews"].length
                                          : 0),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Widgets.buildText(
                                        "Load More", context,
                                        color: "main.primary", size: 16.0)),
                              )
                            ],
                          )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -2),
                          blurRadius: 17.9,
                          spreadRadius: 0,
                          color: Color(0x17000000))
                    ],
                    color: Palette.get("background.paper"),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    border: Border(top: BorderSide(color: Color(0x1A000000)))),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Column(
                  spacing: 10.0,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5.0,
                      children: [
                        Row(
                          spacing: 5.0,
                          children: [
                            Helpers.fetchIcons("exclamation", "solid",
                                color: "main.primary"),
                            Widgets.buildText("Total Price", context,
                                color: "text.secondary")
                          ],
                        ),
                        Row(
                          children: [
                            Widgets.buildText(
                                Helpers.formatCurrency(
                                    _data["price"].toString()),
                                context,
                                color: "main.primary",
                                isMedium: true,
                                size: 15.0),
                            Widgets.buildText(
                                Helpers.formatCurrency("/day"), context,
                                color: "text.secondary",
                                weight: 500,
                                size: 12.0),
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        handleCheckout();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Palette.get("background.paper"),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(-1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border(
                                top: BorderSide(
                                    color: Palette.get("main.primary")))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Helpers.getPhoto(
                                    _data["publisher"]["image"]
                                            .toString()
                                            .isEmpty
                                        ? ""
                                        : "assets/images/${_data["publisher"]["image"].toString()}",
                                    text: _data["publisher"]["name"],
                                    height: 80.0),
                              ],
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Widgets.buildText(
                                                _data["publisher"]["name"],
                                                context,
                                                size: 16.0,
                                                weight: 500,
                                                lines: 1),
                                          ),
                                          FittedBox(
                                            child: Widgets.buildText(
                                                "Real-estate Agent", context,
                                                color: "text.secondary",
                                                lines: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Row(
                                      spacing: 5.0,
                                      children: [
                                        Helpers.fetchIcons(
                                            "phone-call", "solid",
                                            color: "main.primary"),
                                        Widgets.buildText("Call", context)
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Row(
                                      spacing: 5.0,
                                      children: [
                                        Helpers.fetchIcons("envelope", "solid",
                                            color: "main.primary"),
                                        Widgets.buildText("Mail", context)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
