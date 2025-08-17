import 'dart:convert';

import 'package:nobleassets/globals/event_item.dart';
import 'package:nobleassets/utils/bookings/event.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/markers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController adultsController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController infantsController = TextEditingController();
  final LatLng _center = const LatLng(6.5244, 3.3792);
  int _selectedImageIndex = 0;

  int _roomSelected = -1;
  Map _numRooms = {};

  List<String> reviewFilter = ["verified", "latest"];
  bool isDescriptionExpanded = false;
  bool isViewAllIncluded = false;

  Map<String, dynamic> filter = {
    "checkin": "",
    "checkout": "",
    "adults": 1,
    "children": 0,
    "infants": 0
  };
  List<Map<String, dynamic>> _selectedRooms = [];

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
      infantsController.text =
          Helpers.formatNumber(filter["infants"].toString());
      if (res != null) {
        setState(() {
          filter = res;
        });
      }
      setState(() {
        _selectedRooms = _data["rooms"];
      });
    } catch (err) {
      print(err);
    }
  }

  final Map<String, dynamic> _data = {
    "title": "Davido 2024 Concert Tour",
    "date": "2024-07-07 14:10:00",
    "endDate": "2024-07-07 14:10:00",
    "time": "14:10:00",
    "endTime": "17:00:00",
    "frequency": "",
    "categories": ["music"],
    "subtitle":
        "A day tour to see city's landmarks including Sheikh Zayed Grand Mosque and more",
    "price": 61000,
    "location": "Eko Hotel International",
    "images": [
      "assets/images/event.jpeg",
      "assets/images/rema.jpeg",
      "assets/images/event.jpeg",
      "assets/images/rema.jpeg",
      "assets/images/rema.jpeg",
      "assets/images/event.jpeg",
    ],
    "videos": [
      "assets/images/event.jpeg",
      "assets/images/event.jpeg",
      "assets/images/event.jpeg",
      "assets/images/event.jpeg",
      "assets/images/event.jpeg",
      "assets/images/event.jpeg",
    ],
    "tags": ["music", "comedy", "entertainment"],
    "favourite": 1,
    "roomType": "Deluxe Room",
    "rating": 3.9,
    "isBreakfast": 1,
    "hid": "327833",
    "totalReviews": 75,
    "description":
        "In recent years, remote work has transitioned from a niche employment model to a mainstream phenomenon,  significantly accelerated by the global  pandemic. This  shift has redefined the traditional workplace, offering a myriad of benefits for both employers and employees.<br /><br />Contrary to initial skepticism,  numerous  studies  have  shown that  remote  workers  often demonstrate higher productivity levels compared to  their  office-bound  counterparts.  The flexibility  to create  a personalized work environment  and the  elimination of  commute-related stress contribute to this boost. Employees can allocate more time to their tasks and manage their schedules  in a way  that aligns  with their peak",
    "publisher": {
      "name": "Piller point",
      "image": "auto-item-1.jpeg",
      "website": "damocles.com",
      "years": 2024,
      "isNameConfirmed": 1,
      "isEmailConfirmed": 1,
      "isPhoneConfirmed": 1,
      "details": "Response rate 100%,Responds within an hour",
    },
    "included": [
      "Food and Beverages",
      "Music, Live band",
      "Games/Activities",
      "Welcome Gifts",
      "Free Wifi",
      "Welcome Gifts",
      "Free Wifi",
    ],
    "notIncluded": ["Games/Activities", "Welcome Gifts", "Music, Live band"],
    "policy": [
      {"name": "Age", "value": "All", "icon": "age-alt"},
      {"name": "Id required", "value": "No", "icon": "id-badge"},
      {"name": "Last entry", "value": "3pm", "icon": "clock-three"},
      {"name": "Dress code", "value": "Sexy", "icon": "clothes-hanger"},
    ],
    "health": ["Suitable for all fitness levels"],
    "restrictions": [
      "Require clothing to cover shoulders & knees. You may risk refused entry if you fail to comply with these  dress requirements.",
    ],
    "information": [
      "Please bring your ticket with you to the attraction.",
      "Be aware that operators may cancel for unforeseen reasons.",
      "You need to be 18 years or older to book or be accompanied by an adult.",
      "Operated by RAH Tourism",
    ],
    "landmarks": ["Lekki", "Ikota school", "Lagos", "Nigeria"],
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
      "reservation": 5.0,
      "communication": 4.2,
      "wifi": 4.1,
      "reviews": [
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "rating": 4,
          "date": "7 days ago",
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "rating": 4,
          "date": "7 days ago",
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "rating": 4,
          "date": "7 days ago",
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "rating": 4,
          "date": "7 days ago",
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
        {
          "name": "John Samuel",
          "location": "Nigeria",
          "rating": 4,
          "date": "7 days ago",
          "review":
              "Oxf is a great host. She stand by to welcome me to the house even it’s a late night. And she always takes care of me. When I get",
        },
      ],
    },
    "rules": [
      {
        "title": "Check-in",
        "content": "Check-in after 16:00",
        "icon": "check-in-calendar",
      },
      {
        "title": "Check-out",
        "content": "Checkout before 10:00",
        "icon": "check-in-calendar",
      },
      {
        "title": "Number of Guests ",
        "content": "6 guests maximum",
        "icon": "users-alt",
      },
      {
        "title": "Cancellation / Payment",
        "content": "Lorem ipsum dolor ",
        "icon": "refund",
      },
      {
        "title": "Smoking",
        "content": "Smoking is allowed",
        "icon": "smoking-ban",
      },
      {
        "title": "Party / Events",
        "content": "No party or events",
        "icon": "volume-slash",
      },
      {
        "title": "Age restrictions",
        "content": "Lorem ipsum dolor ",
        "icon": "arrow-right",
      },
      {
        "title": "Pets",
        "content": "Pets allowed",
        "icon": "paw",
      },
      {
        "title": "Accepted payment methods",
        "content": "Lorem ipsum dolor ",
        "icon": "credit-card",
      },
    ],
    "similar": [
      {
        "genre": [
          {
            "name": "Davido 001",
            "categories": ["R & B", "Afro Beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          }
        ],
        "title": "Davido 2024 Concert Tour",
        "subtitle":
            "Davido is currently touring across 3 countries and has 4 upcoming concerts. Their next tour date is at",
        "time": "12 PM",
        "date": "Sep 18",
        "location": "Ibeju Lekki, Lagos",
        "image": "assets/images/event.jpeg",
        "images": ["assets/images/event.jpeg"],
        "favourite": 1,
        "isLive": 1,
        "price": 5000,
        "host": "Roland",
        "dateEnds": "2024-07-13 18:06:00",
      },
      {
        "genre": [
          {
            "name": "Davido 001",
            "categories": ["R & B", "Afro Beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          }
        ],
        "title": "Rema 2024 Concert Tour",
        "subtitle":
            "Rema is currently touring across 3 countries and has 4 upcoming concerts. Their next tour date is at",
        "time": "12 PM",
        "date": "Oct 18",
        "location": "Ibeju Lekki, Lagos",
        "image": "assets/images/rema.jpeg",
        "images": ["assets/images/rema.jpeg"],
        "favourite": 1,
        "isLive": 1,
        "dateEnds": "2024-07-13 18:06:00",
        "host": "Roland",
        "price": 6000,
      },
      {
        "genre": [
          {
            "name": "Davido 001",
            "categories": ["R & B", "Afro Beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          }
        ],
        "title": "Burna 2024 Concert Tour",
        "subtitle":
            "Burna is currently touring across 3 countries and has 4 upcoming concerts. Their next tour date is at",
        "time": "12 PM",
        "date": "Oct 31",
        "location": "Ibeju Lekki, Lagos",
        "image": "assets/images/event.jpeg",
        "images": ["assets/images/event.jpeg"],
        "favourite": 0,
        "isLive": 0,
        "host": "Roland",
        "price": 4000,
      },
      {
        "genre": [
          {
            "name": "Davido 001",
            "categories": ["R & B", "Afro Beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          },
          {
            "name": "Davido 001",
            "categories": ["Afro-beat"],
            "photo": "assets/images/avatar.png",
            "facebook": "facebook.com",
            "instagram": "instagram.com",
            "youtube": "youtube.com"
          }
        ],
        "title": "Davido 2024 Concert Tour",
        "subtitle":
            "Davido is currently touring across 3 countries and has 4 upcoming concerts. Their next tour date is at",
        "time": "12 PM",
        "date": "Sep 18",
        "location": "Ibeju Lekki, Lagos",
        "image": "assets/images/event.jpeg",
        "images": ["assets/images/event.jpeg"],
        "favourite": 1,
        "isLive": 0,
        "host": "Roland",
        "price": 14000,
      },
    ],
    "tickets": [
      {
        "id": "17",
        "name": "Standard",
        "type": "free",
        "price": "0",
        "description": "Hurry you just got the biggest package and box",
        "remaining": "5",
        "purchaseLimit": "5"
      },
      {
        "id": "18",
        "name": "Diamond Tickets",
        "type": "paid",
        "price": "1000",
        "description": "Hurry you just got the biggest package and box",
        "remaining": "0",
        "purchaseLimit": "5"
      },
      {
        "id": "19",
        "name": "Silver Tickets",
        "type": "paid",
        "price": "5000",
        "description": "Hurry you just got the biggest package and box",
        "remaining": "7",
        "purchaseLimit": "5"
      }
    ],
    "genre": [
      {
        "name": "Davido 001",
        "categories": ["R & B", "Afro Beat"],
        "photo": "assets/images/avatar.png",
        "facebook": "facebook.com",
        "instagram": "instagram.com",
        "youtube": "youtube.com"
      },
      {
        "name": "Davido 001",
        "categories": ["Afro-beat"],
        "photo": "assets/images/avatar.png",
        "facebook": "facebook.com",
        "instagram": "instagram.com",
        "youtube": "youtube.com"
      }
    ],
    'participants': [
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
      {"name": "John Doe", "photo": "assets/images/avatar.png"},
    ],
    "artiste": {"name": "Davido 001", "image": "davido.png"},
  };
  double fee = 1200;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

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
          // markers
          List<Marker> markers = [];
          final icon = await HotelSingleMarker(icon: "ticket-alt")
              .toBitmapDescriptor(
                  logicalSize: const Size(250, 250),
                  imageSize: const Size(250, 250));
          Marker marker = Marker(
              markerId: MarkerId(_data["listinId"].toString()),
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
  }

  void handleCheckout(Map<String, dynamic> selected) {
    try {
      Helpers.addToCart(_data, 1, {
        "dateFrom": Helpers.formatDate(_data["date"]),
        "dateTo": Helpers.formatDate(_data["endDate"]),
        "numRooms": 1,
        "numNights": 0,
        "selectedRoom": selected
      });
    } catch (err) {
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
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Sheets.showImagePreview(
                          _data["images"], _data["title"].toString());
                    },
                    child: Image.asset(_data["images"][_selectedImageIndex],
                        width: double.infinity, height: 420, fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 3010,
                  ),
                  Positioned(
                    top: 400.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Palette.get("background.paper"),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20.0))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Palette.get("background.neutral"),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    child: Widgets.buildText(
                                        _data["categories"]
                                            .map((c) => Defaults
                                                .eventsCategories
                                                .firstWhere(
                                                    (cat) => cat["value"] == c,
                                                    orElse: () =>
                                                        {"name": ""})["name"])
                                            .join(", "),
                                        context,
                                        color: "main.primary")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText(
                                          _data["title"].toString(), context,
                                          weight: 500,
                                          size: 24.0,
                                          color: "text.secondary"),
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Helpers.fetchIcons(
                                                    "marker", "solid",
                                                    color: "main.primary"),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Widgets.buildText(
                                                    _data["landmarks"]
                                                        .join(", ")
                                                        .toString(),
                                                    context,
                                                    color: "text.other",
                                                    lines: 1),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Helpers.fetchIcons(
                                                    "calendar-clock", "solid",
                                                    color: "main.primary"),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                Widgets.buildText(
                                                    Helpers.formatDate(
                                                        _data["date"],
                                                        formatString:
                                                            "hh:MM a"),
                                                    context,
                                                    color: "text.other",
                                                    lines: 1),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Palette.get("background.default"),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Column(
                                      children: [
                                        Widgets.buildText(
                                            Helpers.formatDate(_data["date"],
                                                formatString: "MMM"),
                                            context,
                                            weight: 500),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Widgets.buildText(
                                            Helpers.formatDate(_data["date"],
                                                formatString: "dd"),
                                            context,
                                            color: "main.primary",
                                            isMedium: true),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.default"),
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 8.0),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          final selectedTicket =
                                              await EventModals.showTickets(
                                                  _data, fee);
                                          if (selectedTicket.isNotEmpty) {
                                            handleCheckout(selectedTicket);
                                          }
                                        },
                                        style: Widgets.buildButton(context,
                                            background:
                                                Palette.get("main.primary"),
                                            horizontal: 10.0,
                                            vertical: 10.0,
                                            radius: 11.0),
                                        child: Widgets.buildText(
                                            "Buy Now", context,
                                            weight: 500,
                                            color: "text.white",
                                            size: 14.0)),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    SizedBox(
                                      height: 50.0,
                                      child: VerticalDivider(
                                        color: Color(0x1A000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      children: [
                                        Widgets.buildText(
                                            "Participants", context,
                                            weight: 500, color: "text.black"),
                                        SizedBox(
                                          height: 30.0,
                                          width: 30 * 3,
                                          child: WidgetStack(
                                            positions: RestrictedPositions(
                                              maxCoverage: 0.4,
                                              minCoverage: 0.2,
                                              align: StackAlign.left,
                                            ),
                                            stackedWidgets: [
                                              for (var n = 0;
                                                  n <
                                                      (_data["participants"] ??
                                                              [])
                                                          .length;
                                                  n++)
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      border: Border.all(
                                                          color: Palette.get(
                                                              "background.paper"))),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                        _data["participants"][n]
                                                                ["photo"]
                                                            .toString(),
                                                        width: 30.0,
                                                        height: 30.0,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                            ],
                                            buildInfoWidget: (surplus, ctx) {
                                              return Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(
                                                          "main.primary"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0)),
                                                  child: Center(
                                                    child: Widgets.buildText(
                                                        '+$surplus', context,
                                                        weight: 500,
                                                        color: "text.white",
                                                        size: 11.0),
                                                  ));
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    style: Widgets.buildButton(context,
                                        radius: 40.0,
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                        background:
                                            Palette.get("main.primary")),
                                    icon: Helpers.fetchIcons(
                                        "land-layer-location", "solid",
                                        color: "text.white", size: 24.0))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              lines: isDescriptionExpanded
                                                  ? 2000
                                                  : 3,
                                              color: "text.secondary"),
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
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText("Included", context,
                                              isMedium: true),
                                          GestureDetector(
                                            onTap: () {
                                              EventModals.showIncluded(
                                                  (_data["included"] ?? []),
                                                  (_data["notIncluded"] ?? []));
                                            },
                                            child: Widgets.buildText(
                                                "See all", context,
                                                color: "main.primary",
                                                weight: 500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: [
                                          for (final included
                                              in (isViewAllIncluded
                                                  ? (_data["included"] ?? [])
                                                  : (_data["included"] ?? [])
                                                      .getRange(0, 5)))
                                            IntrinsicWidth(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Helpers.fetchIcons(
                                                      "check-double", "solid",
                                                      color: "main.primary"),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                      included, context,
                                                      color: "text.disabled")
                                                ],
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText("Policy", context,
                                          isMedium: true),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        spacing: 10.0,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (final policy
                                              in (_data["policy"] ?? []))
                                            IntrinsicWidth(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 60.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                        color: Palette.get(
                                                            "background.default"),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    60.0)),
                                                    child: UnconstrainedBox(
                                                      child: Helpers.fetchIcons(
                                                          policy["icon"],
                                                          "solid",
                                                          color: "main.primary",
                                                          size: 24.0),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                      policy["name"], context,
                                                      color: "main.primary",
                                                      weight: 500),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                    policy["value"],
                                                    context,
                                                  ),
                                                ],
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText(
                                          "Meet Your Organizer", context,
                                          isMedium: true),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color:
                                                Palette.get("background.paper"),
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
                                                            child: Widgets
                                                                .buildText(
                                                                    _data["publisher"]
                                                                        [
                                                                        "name"],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: GoogleMap(
                                              onMapCreated: _onMapCreated,
                                              initialCameraPosition:
                                                  CameraPosition(
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
                                  Column(
                                    spacing: 10.0,
                                    children: [
                                      Widgets.buildText(
                                          "How to get there", context,
                                          weight: 500,
                                          size: 16.0,
                                          color: "text.secondary"),
                                      Row(
                                        spacing: 20.0,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Helpers.fetchIcons(
                                                  "car-rear", "regular",
                                                  size: 24.0)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Helpers.fetchIcons(
                                                  "biking", "regular",
                                                  size: 24.0)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Helpers.fetchIcons(
                                                  "walking", "regular",
                                                  size: 24.0)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Helpers.fetchIcons(
                                                  "bus", "regular",
                                                  size: 24.0)),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Column(
                                    spacing: 10.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Widgets.buildText("Gallery", context,
                                          weight: 500,
                                          size: 16.0,
                                          color: "text.secondary"),
                                      GridView.custom(
                                        gridDelegate: SliverQuiltedGridDelegate(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            repeatPattern:
                                                QuiltedGridRepeatPattern
                                                    .inverted,
                                            pattern: [
                                              QuiltedGridTile(2, 2),
                                              QuiltedGridTile(1, 1),
                                              QuiltedGridTile(1, 1),
                                            ]),
                                        primary: false,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        childrenDelegate:
                                            SliverChildBuilderDelegate(
                                                childCount: _data["images"]
                                                    .length, (context, index) {
                                          final item = _data["images"][index];
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              item,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: 10.0,
                                    children: [
                                      Widgets.buildText("Genre", context,
                                          color: "text.secondary",
                                          isMedium: true),
                                      GestureDetector(
                                        onTap: () {
                                          EventModals.showGenre(
                                              _data["genre"] ?? [],
                                              _data["tags"] ?? [],
                                              "Genre");
                                        },
                                        child: Widgets.buildText(
                                            "See all", context,
                                            color: "main.primary", weight: 500),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Column(
                                    spacing: 10.0,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (final genre in (_data["genre"] ?? [])
                                          .getRange(0, 1))
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 10.0,
                                          children: [
                                            Wrap(
                                              spacing: 10.0,
                                              runSpacing: 10.0,
                                              alignment: WrapAlignment.start,
                                              runAlignment: WrapAlignment.start,
                                              children: [
                                                for (final category
                                                    in genre["categories"] ??
                                                        [])
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        border: Border.all(
                                                            color: Color(
                                                                0x1A000000))),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 8.0),
                                                    child: Widgets.buildText(
                                                        category, context),
                                                  )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              spacing: 10.0,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    spacing: 10.0,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        child: Image.asset(
                                                          genre["photo"],
                                                          width: 50.0,
                                                          height: 50.0,
                                                        ),
                                                      ),
                                                      Widgets.buildText(
                                                          genre["name"],
                                                          context,
                                                          weight: 500,
                                                          size: 16.0)
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {},
                                                    style: Widgets.buildButton(
                                                        context,
                                                        radius: 20.0,
                                                        horizontal: 20.0,
                                                        background: Palette.get(
                                                            "main.primary")),
                                                    child: Widgets.buildText(
                                                        "Follow", context,
                                                        color: "text.white"))
                                              ],
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10.0,
                                    children: [
                                      Widgets.buildText(
                                        "Refund Policy",
                                        context,
                                        isMedium: true,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0x2641B11A),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          spacing: 20.0,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/images/icon.png",
                                                  width: 36.0,
                                                  height: 36.0,
                                                  fit: BoxFit.cover,
                                                ),
                                                Expanded(
                                                  child: Widgets.buildText(
                                                      "Contact the organizer to request a refund. Noble Assets's fee is nonrefundable",
                                                      context,
                                                      lines: 4,
                                                      color: "text.secondary"),
                                                )
                                              ],
                                            ),
                                            Row(
                                              spacing: 10.0,
                                              children: [
                                                Helpers.fetchIcons(
                                                    "exclamation", "solid",
                                                    color: "error.main",
                                                    size: 20.0),
                                                Widgets.buildText(
                                                    "Report this listing",
                                                    context,
                                                    color: "text.secondary",
                                                    weight: 500,
                                                    size: 16.0)
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
                                      "More Events from ${_data["publisher"]["name"]}",
                                      context,
                                      color: "text.secondary",
                                      isMedium: true,
                                      lines: 2),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  ConstrainedBox(
                                      constraints: BoxConstraints.loose(
                                          Size(screenWidth, 415.0)),
                                      child: Swiper(
                                        outer: true,
                                        layout: SwiperLayout.CUSTOM,
                                        customLayoutOption:
                                            Widgets.customLayout(
                                                (_data["similar"] ?? []).length,
                                                screenWidth,
                                                offset: 100.0),
                                        itemHeight: 400.0,
                                        itemWidth: screenWidth,
                                        loop: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item = _data["similar"][index];
                                          return EventItem(
                                            item: item,
                                            direction: "vertical",
                                            offset: 80.0,
                                          );
                                        },
                                        itemCount: _data["similar"].length,
                                      )),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () async {
                  final selectedTicket =
                      await EventModals.showTickets(_data, fee);
                  if (selectedTicket.isNotEmpty) {
                    handleCheckout(selectedTicket);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(90)),
                  height: 80.0,
                  child: Row(
                      spacing: 10.0,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.get("main.primary"),
                              borderRadius: BorderRadius.circular(30.0)),
                          padding: const EdgeInsets.all(15.0),
                          child: Helpers.fetchIcons("lock", "regular",
                              size: 30.0, color: "text.white"),
                        ),
                        Row(
                          spacing: 15.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Widgets.buildText("Buy Tickets", context,
                                color: "main.primary", isMedium: true),
                            Row(
                              spacing: 2.0,
                              children: [
                                Helpers.fetchIcons("angle-small-right", "solid",
                                    color: "main.primary",
                                    size: 20.0,
                                    overrideColor: Color(0x4041B11A)),
                                Helpers.fetchIcons("angle-small-right", "solid",
                                    color: "main.primary",
                                    size: 20.0,
                                    overrideColor: Color(0x8041B11A)),
                                Helpers.fetchIcons("angle-small-right", "solid",
                                    color: "main.primary", size: 20.0),
                              ],
                            )
                          ],
                        ),
                        Helpers.fetchIcons("lock", "regular",
                            size: 30.0, color: "main.primary")
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
