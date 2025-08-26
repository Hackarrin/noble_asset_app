import 'dart:convert';
import 'dart:io';

import 'package:nobleassets/globals/hotel_item.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/bookings/hotel.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/markers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class Hotel extends StatefulWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> with SingleTickerProviderStateMixin {
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

  Map<String, dynamic> filter = {
    "checkin": "",
    "checkout": "",
    "adults": 1,
    "children": 0,
    "rooms": 0
  };
  List<dynamic> _selectedRooms = [];

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

  Map<String, dynamic> _data = {
    "title": "Urban hotels ",
    "subtitle": "Two bedroom Apartment",
    "latitude": 6.5,
    "longitude": 3.4,
    "price": 61000,
    "location": "Abuja, Durumi, Garki, Abuja Municipal Area Council,  Nigeria",
    "images": [
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
      "assets/images/hotels.jpeg",
    ],
    "favourite": 1,
    "roomType": "Deluxe Room",
    "rating": 3.9,
    "isBreakfast": 1,
    "hotelId": "327833",
    "totalReviews": 75,
    "description":
        "Located within 3.2 km of Nike Art Gallery and 7.9 km of Lekki Conservation Centre, Jotani Living provides rooms with air conditioning and a private bathroom in Lagos. This property offers access to a balcony and free private parking. The accommodation offers a 24-hour front desk and full-day.<br /><br />Featuring free WiFi, the units have a washing machine and a flat-screen TV with cable channels. Each unit is equipped with a private bathroom equipped with a walk-in shower, while some rooms include a fully equipped kitchen.",
    "host": {
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
        "title": "Urban hotels ",
        "subtitle": "Two bedroom Apartment",
        "price": 61000,
        "location": "Lekki Lagos",
        "images": [
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg"
        ],
        "favourite": 1,
        "roomType": "Deluxe Room",
        "rating": 3.9,
        "ratingText": "Very Good",
        "isBreakfast": 1,
        "hid": "327823",
      },
      {
        "title": "Urban hotels ",
        "subtitle": "Two bedroom Apartment",
        "price": 61000,
        "location": "Lekki Lagos",
        "images": [
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg"
        ],
        "favourite": 1,
        "roomType": "Deluxe Room",
        "rating": 3.9,
        "ratingText": "Very Good",
        "isBreakfast": 1,
        "hid": "327823",
      },
      {
        "title": "Urban hotels ",
        "subtitle": "Two bedroom Apartment",
        "price": 61000,
        "location": "Lekki Lagos",
        "images": [
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg",
          "assets/images/hotels.jpeg"
        ],
        "favourite": 1,
        "roomType": "Deluxe Room",
        "rating": 3.9,
        "ratingText": "Very Good",
        "isBreakfast": 1,
        "hid": "327823",
      },
    ],
  };
  Set<Marker> _markers = {};
  late TabController tabController;
  var loading = false;
  var error = "";
  int imageIndex = 0;
  List<int> roomsSelected = [];

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      print("dante ${_data["images"]}");
      final res = await JWT.getHotel(_data["listingId"]);
      print("dante ${res["images"]}");
      setState(() {
        _data = res;
        _selectedRooms = _data["rooms"] ?? [];
        loading = false;
      });
      // markers
      List<Marker> markers = [];
      final icon = await HotelSingleMarker(icon: "bed").toBitmapDescriptor(
          logicalSize: const Size(250, 250), imageSize: const Size(250, 250));
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
    tabController = TabController(length: 3, vsync: this);

    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final defaultDate = DateTime.now();
          final defaultEndDate = DateTime.now().add(Duration(days: 1));
          setState(() {
            filter["checkin"] =
                "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}";
            filter["checkout"] =
                "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}";
          });
          updateData(null);
          final data = jsonDecode(arguments.toString());
          setState(() {
            _data = data;
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
    tabController.dispose();
  }

  void handleCheckout({isBuyNow = true}) {
    try {
      if (roomsSelected.isEmpty) {
        Alert.show(
            context, "", "Please select your preferred room(s) to proceed.");
        return;
      }
      final selectedRoom = roomsSelected.isNotEmpty ? roomsSelected : {};
      Helpers.addToCart(
          _data,
          0,
          {
            "dateFrom": Helpers.formatDate(filter["checkin"]),
            "dateTo": Helpers.formatDate(filter["checkout"]),
            "selectedRoom": selectedRoom,
            "numRooms": _numRooms,
            "numNights": Helpers.dateDiff(
                filter["checkin"].toString(), filter["checkout"].toString()),
            "adults": num.tryParse(filter["adults"].toString())?.toInt() ?? 1,
            "children":
                num.tryParse(filter["children"].toString())?.toInt() ?? 1,
          },
          isBuyNow: true);
    } catch (err) {
      print(err);
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
            onPressed: () async {
              if (!loading) {
                SharePlus.instance.share(ShareParams(
                    title:
                        "Check out ${_data["title"].toString()} on Noble Assets",
                    subject:
                        "Check out ${_data["title"].toString()} on Noble Assets",
                    uri: Uri.https(
                      "nobleassets.com",
                      "/place/${_data["listingId"]}-${_data["title"].toString().toLowerCase().replaceAll(" ", "-")}",
                    )));
              }
            },
            style: Widgets.buildButton(context,
                sideColor: Palette.getColor(context, "background", "neutral"),
                radius: 40.0),
            icon: Helpers.fetchIcons("paper-plane-top", "regular",
                size: 16.0, color: "text.other"),
          ),
          IconButton(
            onPressed: () async {
              Helpers.wishlist(_data, "0");
              setState(() {
                _data = {
                  ..._data,
                  "favourite": _data["favourite"].toString() == "0" ? "1" : "0"
                };
              });
            },
            style: Widgets.buildButton(context,
                sideColor: Palette.getColor(context, "background", "neutral"),
                radius: 40.0),
            icon: Helpers.fetchIcons("heart",
                _data["favourite"].toString() == "0" ? "regular" : "solid",
                size: 16.0, color: "text.other"),
          ),
          const SizedBox(width: 10.0),
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
          child: loading
              ? Shimmer.fromColors(
                  baseColor: Palette.get("background.neutral"),
                  highlightColor: Palette.get("background.default"),
                  loop: 1,
                  child: AbsorbPointer(child: buildContent(screenWidth)))
              : (error.isNotEmpty
                  ? Alert.showErrorMessage(context, "",
                      message: error, buttonText: "Retry", action: fetch)
                  : buildContent(screenWidth))),
    );
  }

  Widget buildContent(double screenWidth) {
    final roomImages = Helpers.flatten(
        (_data["rooms"] ?? []).map((room) => room["images"] ?? []).toList());
    final images = [...(_data["images"] ?? []), ...roomImages];
    return Stack(
      children: [
        SingleChildScrollView(
          child: DefaultTabController(
            length: 3,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(screenWidth, 350.0)),
                    child: Stack(
                      children: [
                        Swiper(
                          outer: true,
                          layout: SwiperLayout.DEFAULT,
                          itemHeight: 350.0,
                          itemWidth: screenWidth,
                          onIndexChanged: (v) {
                            setState(() {
                              imageIndex = v;
                            });
                          },
                          loop: true,
                          itemBuilder: (BuildContext context, int index) {
                            final image = images[index];
                            return GestureDetector(
                              onTap: () {
                                Sheets.showImagePreview(_data["images"] ?? [],
                                    _data["title"].toString(),
                                    startIndex: index);
                              },
                              child: Helpers.getPhoto(image,
                                  height: 350.0, radius: 0.0, type: "hotel"),
                            );
                          },
                          itemCount: images.length,
                        ),
                        Positioned(
                          bottom: 10.0,
                          left: 0,
                          right: 0,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: 40, maxHeight: 80),
                            child: FittedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.neutral"),
                                    borderRadius: BorderRadius.circular(20.0)),
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 10.0,
                                  children: [
                                    for (int i = 0;
                                        i <
                                            (images.length > 6
                                                ? 6
                                                : images.length);
                                        i += 1)
                                      Container(
                                        decoration: BoxDecoration(
                                            border: imageIndex == i
                                                ? Border.all(
                                                    color: Palette.get(
                                                        "main.primary"),
                                                    width: 1.5)
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        padding: const EdgeInsets.all(1),
                                        child: Stack(
                                          children: [
                                            Helpers.getPhoto(images[i],
                                                width: 50.0,
                                                height: 50.0,
                                                type: "hotel"),
                                            if (images.length > 6 && i == 5)
                                              Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    color: Palette.get(
                                                            "text.black")
                                                        .withAlpha(150),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Center(
                                                  child: Widgets.buildText(
                                                      "+${images.length - 6}",
                                                      context,
                                                      isMedium: true,
                                                      color: "text.white"),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_data.containsKey("discount"))
                        Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.neutral"),
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Widgets.buildText("10% Off", context,
                                color: "main.primary")),
                      if (!_data.containsKey("discount")) SizedBox(),
                      Row(
                        children: [
                          Helpers.fetchIcons("star", "solid",
                              color: "warning.main"),
                          const SizedBox(width: 5.0),
                          Widgets.buildText(
                              "${_data["rating"]} (${Helpers.formatNumber(_data["totalReviews"].toString())} reviews)",
                              context,
                              color: "text.secondary",
                              weight: 500)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText(
                                _data["title"].toString(), context,
                                isBold: true, color: "text.secondary"),
                            Widgets.buildText(
                                (_data["landmarks"] ?? [])
                                    .join(", ")
                                    .toString(),
                                context,
                                color: "text.other",
                                lines: 1),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Platform.isAndroid) {
                            Helpers.openLink(
                                "https://www.google.com/maps/search/?api=1&query=${_data["latitude"].toString()},${_data["longitude"].toString()}",
                                "Get directions");
                          } else {
                            Helpers.openLink(
                                "https://maps.apple.com/?q=${_data["latitude"].toString()},${_data["longitude"].toString()}",
                                "Get directions");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.get("main.primary"),
                              borderRadius: BorderRadius.circular(40.0)),
                          padding: const EdgeInsets.all(15.0),
                          child: Helpers.fetchIcons(
                              "land-layer-location", "solid",
                              color: "text.white", size: 24.0),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TabBar(
                  labelStyle: GoogleFonts.nunito(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                  dividerColor: Color(0x1A000000),
                  indicatorWeight: 3.0,
                  dividerHeight: 2.0,
                  onTap: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  tabs: [
                    Tab(text: "About"),
                    Tab(text: "Gallery"),
                    Tab(text: "Reviews"),
                  ],
                ),
                const SizedBox(
                  height: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 90.0, top: 10.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Column(children: [
                      if (_selectedTab == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                for (var item in (_data["amenities"] ?? []))
                                  Container(
                                    height: 90,
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                        color: Palette.getColor(
                                            context, "background", "default"),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Palette.get(
                                                    "background.paper"),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            padding: EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Defaults.hotelAmenities
                                                      .containsKey(
                                                          item.toString())
                                                  ? Helpers.fetchIcons(
                                                      Defaults.hotelAmenities[
                                                              item.toString()]![
                                                              "icon"]
                                                          .toString(),
                                                      "solid",
                                                      size: 30.0,
                                                      color: "main.primary")
                                                  : const SizedBox(
                                                      width: 30, height: 30),
                                            ),
                                          ),
                                          const SizedBox(height: 0.0),
                                          FittedBox(
                                            child: Widgets.buildText(
                                                Defaults.hotelAmenities
                                                        .containsKey(
                                                            item.toString())
                                                    ? Defaults.hotelAmenities[
                                                            item.toString()]![
                                                            "name"]
                                                        .toString()
                                                    : item.toString(),
                                                context),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Description", context,
                                    isMedium: true, size: 18.0),
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
                                Widgets.buildText("Meet Your Host", context,
                                    isMedium: true, size: 18.0),
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
                                      borderRadius: BorderRadius.circular(50.0),
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
                                              _data.containsKey("host")
                                                  ? _data["host"]["image"]
                                                  : "",
                                              type: "host",
                                              isInitials: true,
                                              text: _data.containsKey("host")
                                                  ? _data["host"]["name"]
                                                  : "",
                                              radius: 80.0,
                                              width: 80.0,
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
                                                          _data.containsKey(
                                                                  "host")
                                                              ? _data["host"]
                                                                  ["name"]
                                                              : "",
                                                          context,
                                                          size: 16.0,
                                                          weight: 500,
                                                          lines: 1),
                                                    ),
                                                    FittedBox(
                                                      child: Widgets.buildText(
                                                          _data.containsKey(
                                                                  "host")
                                                              ? "${_data["host"]["years"].toString()} year${(num.tryParse(_data["host"]["years"].toString())?.toInt() ?? 0) > 1 ? "s" : ""} hosting"
                                                              : "",
                                                          context,
                                                          color:
                                                              "text.secondary",
                                                          lines: 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25.0,
                                                child: VerticalDivider(
                                                    thickness: 1.0,
                                                    color: Color(0x14000000)),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    child: Row(
                                                      children: [
                                                        FittedBox(
                                                          child: Widgets.buildText(
                                                              _data.containsKey(
                                                                      "host")
                                                                  ? _data["host"]
                                                                          [
                                                                          "rating"]
                                                                      .toString()
                                                                  : "",
                                                              context,
                                                              size: 16.0,
                                                              weight: 500,
                                                              lines: 1),
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Helpers.fetchIcons(
                                                            "star", "solid",
                                                            color:
                                                                "warning.main")
                                                      ],
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Widgets.buildText(
                                                        "Rating", context,
                                                        color: "text.secondary",
                                                        lines: 1),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 25.0,
                                                child: VerticalDivider(
                                                    thickness: 1.0,
                                                    color: Color(0x14000000)),
                                              ),
                                              Column(
                                                children: [
                                                  Widgets.buildText(
                                                      Helpers.formatNumber(_data
                                                              .containsKey(
                                                                  "host")
                                                          ? _data["host"]
                                                                  ["reviews"]
                                                              .toString()
                                                          : ""),
                                                      context,
                                                      size: 16.0,
                                                      weight: 500),
                                                  FittedBox(
                                                    child: Widgets.buildText(
                                                        "Reviews", context,
                                                        color:
                                                            "text.secondary"),
                                                  ),
                                                ],
                                              ),
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
                                      border:
                                          Border.all(color: Color(0x1A000000)),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(5.0),
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: GoogleMap(
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              num.tryParse(_data["latitude"]
                                                          .toString())
                                                      ?.toDouble() ??
                                                  _center.latitude,
                                              num.tryParse(_data["longitude"]
                                                          .toString())
                                                      ?.toDouble() ??
                                                  _center.longitude),
                                          zoom: 15.0,
                                        ),
                                        mapToolbarEnabled: true,
                                        zoomControlsEnabled: true,
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
                                          (_data["landmarks"] ?? [])
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Modify Selection", context,
                                    isMedium: true),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Palette.get("main.primary"),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Widgets.buildText(
                                              "Your Search: ${Helpers.formatNumber((num.tryParse(filter["adults"].toString())!.toInt() + num.tryParse(filter["children"].toString())!.toInt()).toString())} ${(num.tryParse(filter["adults"].toString())!.toInt() + num.tryParse(filter["children"].toString())!.toInt()) > 1 ? "People" : "Person"}, ${Helpers.dateDiff(filter["checkin"].toString(), filter["checkout"].toString())} ${Helpers.dateDiff(filter["checkin"].toString(), filter["checkout"].toString()) > 1 ? "Nights" : "Night"}, ${Helpers.formatNumber(filter["rooms"].toString())} ${num.tryParse(filter["rooms"].toString())!.toInt() > 1 ? "Rooms" : "Room"}",
                                              context,
                                              color: "text.white",
                                              weight: 500),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Widgets.buildText(
                                                  "Check-in date", context,
                                                  color: "text.white"),
                                              Widgets.buildText(
                                                  "Check-out date", context,
                                                  color: "text.white"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        startDateController,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            prefixIcon:
                                                                UnconstrainedBox(
                                                              child: Helpers.fetchIcons(
                                                                  "calendar-clock",
                                                                  "regular",
                                                                  size: 24,
                                                                  color:
                                                                      "text.other"),
                                                            ),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "other")),
                                                    onTap: () async {
                                                      final res = await Sheets
                                                          .selectDate(
                                                              filter["checkin"]
                                                                  .toString(),
                                                              disablePast: true,
                                                              title:
                                                                  "Select check-in date");
                                                      setState(() {
                                                        filter["checkin"] = res;
                                                      });
                                                      startDateController.text =
                                                          Helpers.formatDate(
                                                              res,
                                                              formatString:
                                                                  "MMM dd");
                                                    },
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "other")),
                                                  )),
                                                  SizedBox(
                                                    width: 5.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0,
                                                              bottom: 5.0),
                                                      child: VerticalDivider(
                                                          thickness: 1.0,
                                                          color: Color(
                                                              0x14000000)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        endDateController,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            prefixIcon:
                                                                UnconstrainedBox(
                                                              child: Helpers.fetchIcons(
                                                                  "calendar-clock",
                                                                  "regular",
                                                                  size: 24,
                                                                  color:
                                                                      "text.other"),
                                                            ),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "other")),
                                                    onTap: () async {
                                                      final res = await Sheets
                                                          .selectDate(
                                                              filter["checkout"]
                                                                  .toString(),
                                                              title:
                                                                  "Select check-out date");
                                                      setState(() {
                                                        filter["checkout"] =
                                                            res;
                                                      });
                                                      endDateController.text =
                                                          Helpers.formatDate(
                                                              res,
                                                              formatString:
                                                                  "MMM dd");
                                                    },
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "other")),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Widgets.buildText(
                                                      "Adults",
                                                      context,
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        adultsController,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            suffixIcon:
                                                                UnconstrainedBox(
                                                              child: Helpers
                                                                  .fetchIcons(
                                                                      "caret-down",
                                                                      "regular",
                                                                      size: 24,
                                                                      color:
                                                                          "text.secondary"),
                                                            ),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "secondary")),
                                                    onTap: () async {
                                                      final res =
                                                          await HotelModals
                                                              .filter(filter,
                                                                  _data);
                                                      updateData(res);
                                                    },
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "secondary")),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Widgets.buildText(
                                                      "Children",
                                                      context,
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        childrenController,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            suffixIcon:
                                                                UnconstrainedBox(
                                                              child: Helpers
                                                                  .fetchIcons(
                                                                      "caret-down",
                                                                      "regular",
                                                                      size: 24,
                                                                      color:
                                                                          "text.secondary"),
                                                            ),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "secondary")),
                                                    onTap: () async {
                                                      final res =
                                                          await HotelModals
                                                              .filter(filter,
                                                                  _data);
                                                      updateData(res);
                                                    },
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "secondary")),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Widgets.buildText(
                                                      "Rooms",
                                                      context,
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    readOnly: true,
                                                    controller: roomsController,
                                                    decoration:
                                                        Widgets.inputDecoration(
                                                            "",
                                                            suffixIcon:
                                                                UnconstrainedBox(
                                                              child: Helpers
                                                                  .fetchIcons(
                                                                      "caret-down",
                                                                      "regular",
                                                                      size: 24,
                                                                      color:
                                                                          "text.secondary"),
                                                            ),
                                                            isOutline: true,
                                                            borderColor: Colors
                                                                .transparent,
                                                            isFloating: true,
                                                            color: Palette
                                                                .getColor(
                                                                    context,
                                                                    "text",
                                                                    "secondary")),
                                                    onTap: () async {
                                                      final res =
                                                          await HotelModals
                                                              .filter(filter,
                                                                  _data);
                                                      updateData(res);
                                                    },
                                                    style: GoogleFonts.nunito(
                                                        color: Palette.getColor(
                                                            context,
                                                            "text",
                                                            "secondary")),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Widgets.buildText(
                                "${Helpers.formatNumber(_selectedRooms.length.toString())} result${_selectedRooms.length > 1 ? "s" : ""} from search",
                                context,
                                color: "text.secondary",
                                isMedium: true),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Widgets.buildText("House rules", context,
                                color: "text.secondary", isMedium: true),
                            const SizedBox(
                              height: 15.0,
                            ),nobl
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0x0d000000)),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (final rule
                                            in (_data["rules"] ?? []).getRange(
                                                0,
                                                (_data["rules"] ?? []).length >
                                                        3
                                                    ? 3
                                                    : (_data["rules"] ?? [])
                                                        .length))
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Widgets.buildText(
                                                "${rule["title"].toString()}: ${rule["content"]}",
                                                context,
                                                lines: 2),
                                          )
                                      ],
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      HotelModals.showRules(
                                          _data["rules"] ?? [],
                                          _data["title"].toString());
                                    },
                                    style: Widgets.buildButton(context,
                                        background: Palette.get("main.primary"),
                                        radius: 20.0,
                                        horizontal: 10.0,
                                        vertical: 10.0),
                                    label: Widgets.buildText(
                                        "Read all", context,
                                        color: "text.white", size: 16.0),
                                    icon: Helpers.fetchIcons("eye", "regular",
                                        color: "text.white", size: 20.0),
                                  )
                                ],
                              ),
                            ),
                            if ((_data["relatedListings"] ?? []).isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Widgets.buildText(
                                      "Similar properties to ${_data["title"]}",
                                      context,
                                      color: "text.secondary",
                                      isMedium: true,
                                      lines: 2),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                      width: screenWidth,
                                      height: 180.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item =
                                              _data["relatedListings"][index];
                                          return SizedBox(
                                            width: screenWidth - 70,
                                            child: HotelItem(
                                                item: item,
                                                offset: 10,
                                                direction: "horizontal"),
                                          );
                                        },
                                        itemCount:
                                            (_data["relatedListings"] ?? [])
                                                .length,
                                      )),
                                ],
                              ),
                          ],
                        ),
                      if (_selectedTab == 1)
                        Column(
                          children: [
                            Row(
                              children: [
                                Widgets.buildText("Gallery", context,
                                    isMedium: true),
                                if ((_data["images"] ?? []).length > 0)
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
                                  final List<dynamic> photos = index == 0
                                      ? _data["images"] ?? []
                                      : _data["rooms"][index - 1]["images"] ??
                                          [];
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
                                            color: "main.primary",
                                            isMedium: true),
                                        const SizedBox(height: 10.0),
                                        GridView.count(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15,
                                            physics:
                                                NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              for (var i = 0;
                                                  i < photos.length;
                                                  i += 1)
                                                GestureDetector(
                                                  onTap: () {
                                                    Sheets.showImagePreview(
                                                        photos, title,
                                                        startIndex: i);
                                                  },
                                                  child: Helpers.getPhoto(
                                                      photos[i],
                                                      height: 110.0,
                                                      radius: 10.0,
                                                      type: "hotel"),
                                                )
                                            ])
                                      ],
                                    ),
                                  );
                                },
                                itemCount: (_data["rooms"] ?? []).length +
                                    ((_data["images"] ?? []).length > 0
                                        ? 1
                                        : 0))
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
                            // TextFormField(
                            //   decoration:
                            //       Widgets.inputDecoration("Search in reviews",
                            //           isOutline: true,
                            //           hint: "Search in reviews",
                            //           hintColor: Palette.get("text.secondary"),
                            //           prefixIcon: UnconstrainedBox(
                            //             child: Helpers.fetchIcons(
                            //                 "search", "regular",
                            //                 size: 20.0, color: "main.primary"),
                            //           ),
                            //           color: Palette.get("background.default"),
                            //           radius: 40.0,
                            //           isFilled: true,
                            //           isFloating: true),
                            //   style: GoogleFonts.nunito(
                            //     color: Palette.get("text.secondary"),
                            //     fontSize: 16.0,
                            //   ),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(
                            //         child: GestureDetector(
                            //       onTap: () {},
                            //       child: Chip(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 5, horizontal: 5),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20)),
                            //         backgroundColor:
                            //             Palette.get("background.default"),
                            //         label: Widgets.buildText("Filters", context,
                            //             weight: 500),
                            //       ),
                            //     )),
                            //     Expanded(
                            //         child: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           if (reviewFilter.contains("verified")) {
                            //             reviewFilter.remove("verified");
                            //           } else {
                            //             reviewFilter.add("verified");
                            //           }
                            //         });
                            //       },
                            //       child: Chip(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 5, horizontal: 5),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20)),
                            //         backgroundColor:
                            //             reviewFilter.contains("verified")
                            //                 ? Palette.get("main.primary")
                            //                 : Palette.get("background.default"),
                            //         label: FittedBox(
                            //           child: Widgets.buildText(
                            //               "Verified", context,
                            //               weight: 500,
                            //               color:
                            //                   reviewFilter.contains("verified")
                            //                       ? "text.white"
                            //                       : "text.primary"),
                            //         ),
                            //       ),
                            //     )),
                            //     Expanded(
                            //         child: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           if (reviewFilter.contains("latest")) {
                            //             reviewFilter.remove("latest");
                            //           } else {
                            //             reviewFilter.add("latest");
                            //           }
                            //         });
                            //       },
                            //       child: Chip(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 5, horizontal: 5),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20)),
                            //         backgroundColor:
                            //             reviewFilter.contains("latest")
                            //                 ? Palette.get("main.primary")
                            //                 : Palette.get("background.default"),
                            //         label: FittedBox(
                            //           child: Widgets.buildText(
                            //               "Latest", context,
                            //               weight: 500,
                            //               color: reviewFilter.contains("latest")
                            //                   ? "text.white"
                            //                   : "text.primary"),
                            //         ),
                            //       ),
                            //     )),
                            //     Expanded(
                            //         child: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           if (reviewFilter.contains("photos")) {
                            //             reviewFilter.remove("photos");
                            //           } else {
                            //             reviewFilter.add("photos");
                            //           }
                            //         });
                            //       },
                            //       child: Chip(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 5, horizontal: 5),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20)),
                            //         backgroundColor:
                            //             reviewFilter.contains("photos")
                            //                 ? Palette.get("main.primary")
                            //                 : Palette.get("background.default"),
                            //         label: FittedBox(
                            //           child: Widgets.buildText(
                            //               "With Photos", context,
                            //               weight: 500,
                            //               color: reviewFilter.contains("photos")
                            //                   ? "text.white"
                            //                   : "text.primary"),
                            //         ),
                            //       ),
                            //     )),
                            //   ],
                            // ),
                            // const SizedBox(height: 20.0),
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
                                                  padding: EdgeInsets.all(0.0)),
                                          child: Slider(
                                              inactiveColor: Palette.getColor(
                                                  context,
                                                  "background",
                                                  "textfield"),
                                              value: (((num.tryParse(_data[
                                                                      "reviews"]
                                                                  [category[
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
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      CrossAxisAlignment.start,
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
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: SvgPicture.string(
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
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            children: [
                                              if (review.containsKey("photos"))
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
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               10),
                                              //       border: Border.all(
                                              //           color:
                                              //               Color(0x33000000))),
                                              //   padding:
                                              //       const EdgeInsets.all(10.0),
                                              //   child: Column(
                                              //     children: [
                                              //       Row(
                                              //         children: [
                                              //           Helpers.fetchIcons(
                                              //               "bed", "regular",
                                              //               size: 16.0,
                                              //               color:
                                              //                   "text.secondary"),
                                              //           const SizedBox(
                                              //               width: 10.0),
                                              //           Widgets.buildText(
                                              //               review["room"]
                                              //                       ["type"]
                                              //                   .toString(),
                                              //               context,
                                              //               color:
                                              //                   "text.secondary")
                                              //         ],
                                              //       ),
                                              //       const SizedBox(
                                              //           height: 10.0),
                                              //       Row(
                                              //         children: [
                                              //           Helpers.fetchIcons(
                                              //               "calendar-day",
                                              //               "regular",
                                              //               size: 16.0,
                                              //               color:
                                              //                   "text.secondary"),
                                              //           const SizedBox(
                                              //               width: 10.0),
                                              //           Widgets.buildText(
                                              //               "${Helpers.dateDiff(review["room"]["checkin"].toString(), review["room"]["checkout"].toString()).toString()} Night${Helpers.dateDiff(review["room"]["checkin"].toString(), review["room"]["checkout"].toString()) > 1 ? "s" : ""} • ${Helpers.formatDistanceDate(review["room"]["checkin"].toString(), review["room"]["checkout"].toString())}",
                                              //               context,
                                              //               color:
                                              //                   "text.secondary")
                                              //         ],
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
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
                                                                    ["photo"] ??
                                                                "",
                                                            text:
                                                                review["response"]
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
                                                        color: "text.disabled",
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
                            // const SizedBox(height: 20.0),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: TextButton(
                            //       onPressed: () {},
                            //       child: Widgets.buildText("Load More", context,
                            //           color: "main.primary", size: 16.0)),
                            // )
                          ],
                        )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            width: screenWidth,
            decoration: BoxDecoration(color: Palette.get("text.white")),
            height: 80.0,
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Widgets.buildText("Total Price", context,
                      color: "text.disabled"),
                  Row(
                    children: [
                      Widgets.buildText(
                          Helpers.formatCurrency(roomsSelected.isEmpty
                              ? _data["price"].toString()
                              : roomsSelected
                                  .map((i) => _selectedRooms[i])
                                  .map((i) =>
                                      (num.tryParse(i["price"].toString())
                                              ?.toDouble() ??
                                          0) *
                                      (num.tryParse(_numRooms[
                                                      i["name"].toString()]
                                                  .toString())
                                              ?.toDouble() ??
                                          0))
                                  .reduce((v, e) => e + v)
                                  .toString()),
                          context,
                          color: "main.primary",
                          isMedium: true),
                      Widgets.buildText("/night", context,
                          color: "text.primary"),
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 50.0,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      handleCheckout();
                    },
                    style: Widgets.buildButton(context,
                        background: Palette.get("main.primary"),
                        vertical: 15.0,
                        radius: 40.0),
                    child: Widgets.buildText("Reserve Now", context,
                        isMedium: true, color: "text.white")),
              )
            ]),
          ),
        )
      ],
    );
  }
}
