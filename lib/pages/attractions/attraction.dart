import 'dart:convert';

import 'package:afritas/globals/attraction_item.dart';
import 'package:afritas/globals/event_item.dart';
import 'package:afritas/utils/bookings/attraction.dart';
import 'package:afritas/utils/bookings/event.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/markers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class Attraction extends StatefulWidget {
  const Attraction({Key? key}) : super(key: key);

  @override
  _AttractionState createState() => _AttractionState();
}

class _AttractionState extends State<Attraction>
    with SingleTickerProviderStateMixin {
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
  bool _isReviewAll = false;

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
    "weekdays": ["Tuesday", "Monday", "Wednesday"],
    "weekends": ["Saturday", "Sunday"],
    "openingTimes": ["08:00pm", "10:00pm"],
    "title": "Lekki Conservation Center",
    "location": "Lagos",
    "image": "assets/images/attraction-1.jpeg",
    "date": "2024-07-07 14:10:00",
    "endDate": "2024-07-07 14:10:00",
    "time": "14:10:00",
    "endTime": "17:00:00",
    "frequency": "",
    "categories": ["arts-culture"],
    "subtitle":
        "A day tour to see city's landmarks including Sheikh Zayed Grand Mosque and more",
    "price": 61000,
    "images": [
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-3.jpeg",
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-3.jpeg",
    ],
    "videos": [
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-3.jpeg",
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-3.jpeg",
    ],
    "otherPhotos": [
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-3.jpeg",
      "assets/images/attraction-2.jpeg",
      "assets/images/attraction-1.jpeg",
      "assets/images/attraction-3.jpeg",
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
    "faq": [
      {
        "question": "How do I book a ticket?",
        "answer":
            "Select a date and time.\nChoose the number of tickets.\nClick through to the next page and enter your personal details."
      },
      {"question": "Can I cancel or modify my tickets?", "answer": "Yes."}
    ],
    "health": [
      "Suitable for all fitness levels",
      "Also suitable for all scenarios"
    ],
    "information": [
      "Require clothing to cover shoulders & knees. You may risk refused entry if you fail to comply with these dress requirements.",
      "Please bring your ticket with you to the attraction.",
      "Be aware that operators may cancel for unforeseen reasons.",
      "You need to be 18 years or older to book or be accompanied by an adult."
    ],
    "policy": [
      {"name": "Last entry", "value": "12:00pm"},
      {"name": "Id required", "value": "No"},
      {"name": "Age", "value": ""},
      {"name": "Dress code", "value": ""}
    ],
    "publisher": {
      "name": "Abigail Rose",
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
            "assets/images/attraction-2.jpeg",
            "assets/images/attraction-2.jpeg",
            "assets/images/attraction-2.jpeg"
          ],
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
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-1.jpeg",
        "listingId": "473307",
        "price": "12000",
        "rating": "2.5",
        "reviews": "200",
        "favourite": "0",
        "duration": "9:00 AM - 6:00PM",
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
        "host": "Ola Alli"
      },
      {
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-2.jpeg",
        "listingId": "473307",
        "price": "12000",
        "rating": "2.5",
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
        "reviews": "200",
        "favourite": "0",
        "host": "Ola Alli",
        "duration": "9:00 AM - 6:00PM",
      },
      {
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-1.jpeg",
        "listingId": "473307",
        "price": "12000",
        "rating": "2.5",
        "reviews": "200",
        "favourite": "0",
        "duration": "9:00 AM - 6:00PM",
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
        "host": "Ola Alli"
      },
      {
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-2.jpeg",
        "listingId": "473307",
        "price": "12000",
        "rating": "2.5",
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
        "reviews": "200",
        "favourite": "0",
        "host": "Ola Alli",
        "duration": "9:00 AM - 6:00PM",
      },
    ],
    "tickets": [
      {
        "id": "23",
        "name": "Regular Tickets",
        "type": "free",
        "adultPrice": "0",
        "childrenPrice": "0",
        "infantPrice": "0",
        "isRefundable": "0",
        "description": "",
        "remaining": "3",
        "purchaseLimit": "5",
        "categories": "[\"adults\",\"children\",\"infants\"]"
      },
      {
        "id": "23",
        "name": "Regular Tickets",
        "type": "free",
        "adultPrice": "0",
        "childrenPrice": "0",
        "infantPrice": "0",
        "isRefundable": "0",
        "description": "",
        "remaining": "3",
        "purchaseLimit": "5",
        "categories": "[\"adults\",\"children\",\"infants\"]"
      },
      {
        "id": "23",
        "name": "Regular Tickets",
        "type": "free",
        "adultPrice": "0",
        "childrenPrice": "0",
        "infantPrice": "0",
        "isRefundable": "0",
        "description": "",
        "remaining": "3",
        "purchaseLimit": "5",
        "categories": "[\"adults\",\"children\",\"infants\"]"
      },
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
  late TabController tabController;
  int _selectedTab = 0;

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
    tabController.dispose();
  }

  void handleCheckout(Map<String, dynamic> selected) {
    try {
      Helpers.addToCart(_data, 6, {
        "dateFrom": selected["date"],
        "time": selected["time"],
        "numRooms": 1,
        "numNights": 1,
        "selectedRoom": selected["ticket"],
        "adults": selected["adults"] ?? 0,
        "children": selected["children"] ?? 0,
        "infants": selected["infants"] ?? 0,
      });
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
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Sheets.showImagePreview(
                            _data["images"], _data["title"].toString());
                      },
                      child: Image.asset(_data["images"][_selectedImageIndex],
                          width: double.infinity,
                          height: 420,
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 400.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                      (cat) =>
                                                          cat["value"] == c,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                            BorderRadius
                                                                .circular(24.0),
                                                        border: Border.all(
                                                            color: Palette.get(
                                                                "background.paper"))),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                          _data["participants"]
                                                                  [n]["photo"]
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
                                                            BorderRadius
                                                                .circular(
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
                            const SizedBox(
                              height: 15.0,
                            ),
                            TabBar(
                              labelStyle: GoogleFonts.poppins(
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
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 90.0),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: Column(children: [
                                  if (_selectedTab == 0)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Widgets.buildText(
                                                "Description", context,
                                                isMedium: true),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Wrap(
                                              children: [
                                                Widgets.buildText(
                                                    _data["description"]
                                                        .toString()
                                                        .replaceAll(
                                                            "<br />", "\n"),
                                                    context,
                                                    lines: isDescriptionExpanded
                                                        ? 2000
                                                        : 3,
                                                    color: "text.secondary"),
                                                if (Helpers.hasTextOverflow(
                                                    _data["description"]
                                                        .toString(),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Widgets.buildText(
                                                    "Included", context,
                                                    isMedium: true),
                                                GestureDetector(
                                                  onTap: () {
                                                    EventModals.showIncluded(
                                                        (_data["included"] ??
                                                            []),
                                                        (_data["notIncluded"] ??
                                                            []));
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
                                                        ? (_data["included"] ??
                                                            [])
                                                        : (_data["included"] ??
                                                                [])
                                                            .getRange(0, 5)))
                                                  IntrinsicWidth(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Helpers.fetchIcons(
                                                            "check-double",
                                                            "solid",
                                                            color:
                                                                "main.primary"),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Widgets.buildText(
                                                            included, context,
                                                            color:
                                                                "text.disabled")
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
                                                  color: Palette.get(
                                                      "background.paper"),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x1A000000),
                                                      spreadRadius: 0,
                                                      blurRadius: 5,
                                                      offset: Offset(-1, 1),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: Palette.get(
                                                              "main.primary")))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 10.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Helpers.getPhoto(
                                                          _data["publisher"]
                                                                      ["image"]
                                                                  .toString()
                                                                  .isEmpty
                                                              ? ""
                                                              : "assets/images/${_data["publisher"]["image"].toString()}",
                                                          text:
                                                              _data["publisher"]
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
                                                                          [
                                                                          "name"],
                                                                      context,
                                                                      size:
                                                                          16.0,
                                                                      weight:
                                                                          500,
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
                                                          SizedBox(
                                                            width: 25.0,
                                                            child: VerticalDivider(
                                                                thickness: 1.0,
                                                                color: Color(
                                                                    0x14000000)),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    FittedBox(
                                                                      child: Widgets.buildText(
                                                                          _data["publisher"]["rating"]
                                                                              .toString(),
                                                                          context,
                                                                          size:
                                                                              16.0,
                                                                          weight:
                                                                              500,
                                                                          lines:
                                                                              1),
                                                                    ),
                                                                    const SizedBox(
                                                                      width:
                                                                          5.0,
                                                                    ),
                                                                    Helpers.fetchIcons(
                                                                        "star",
                                                                        "solid",
                                                                        color:
                                                                            "warning.main")
                                                                  ],
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                child: Widgets
                                                                    .buildText(
                                                                        "Rating",
                                                                        context,
                                                                        color:
                                                                            "text.secondary",
                                                                        lines:
                                                                            1),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 25.0,
                                                            child: VerticalDivider(
                                                                thickness: 1.0,
                                                                color: Color(
                                                                    0x14000000)),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Widgets.buildText(
                                                                  Helpers.formatNumber(
                                                                      _data["publisher"]
                                                                              [
                                                                              "reviews"]
                                                                          .toString()),
                                                                  context,
                                                                  size: 16.0,
                                                                  weight: 500),
                                                              FittedBox(
                                                                child: Widgets
                                                                    .buildText(
                                                                        "Reviews",
                                                                        context,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Widgets.buildText(
                                                "Landmark", context,
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
                                                      BorderRadius.circular(
                                                          10.0)),
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                Helpers.fetchIcons(
                                                    "marker", "solid",
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
                                            Widgets.buildText(
                                                "Gallery", context,
                                                weight: 500,
                                                size: 16.0,
                                                color: "text.secondary"),
                                            GridView.custom(
                                              gridDelegate:
                                                  SliverQuiltedGridDelegate(
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
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              childrenDelegate:
                                                  SliverChildBuilderDelegate(
                                                      childCount:
                                                          _data["images"]
                                                              .length,
                                                      (context, index) {
                                                final item =
                                                    _data["images"][index];
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
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
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Widgets.buildText(
                                                    "Why Visit", context,
                                                    isMedium: true),
                                                GestureDetector(
                                                  onTap: () {
                                                    AttractionModals.showIncluded(
                                                        (_data["included"] ??
                                                            []),
                                                        (_data["notIncluded"] ??
                                                            []),
                                                        restrictions: (_data[
                                                                "restrictions"] ??
                                                            []),
                                                        information: (_data[
                                                                "information"] ??
                                                            []),
                                                        faq: (_data["faq"] ??
                                                            []),
                                                        title: _data["title"] ??
                                                            "");
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
                                                        ? (_data["included"] ??
                                                            [])
                                                        : (_data["included"] ??
                                                                [])
                                                            .getRange(0, 5)))
                                                  IntrinsicWidth(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Helpers.fetchIcons(
                                                            "check-double",
                                                            "solid",
                                                            color:
                                                                "main.primary"),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Widgets.buildText(
                                                            included, context,
                                                            color:
                                                                "text.disabled")
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
                                          spacing: 20.0,
                                          children: [
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
                                        const SizedBox(
                                          height: 25.0,
                                        ),
                                        Widgets.buildText(
                                            "More Attractions similar to ${_data["title"]}",
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
                                                      (_data["similar"] ?? [])
                                                          .length,
                                                      screenWidth,
                                                      offset: 100.0),
                                              itemHeight: 400.0,
                                              itemWidth: screenWidth,
                                              loop: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final item =
                                                    _data["similar"][index];
                                                return AttractionItem(
                                                  item: item,
                                                  direction: "vertical",
                                                  offset: 80.0,
                                                  isRegular: true,
                                                );
                                              },
                                              itemCount:
                                                  _data["similar"].length,
                                            )),
                                      ],
                                    ),
                                  if (_selectedTab == 1)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Widgets.buildText(
                                                "Gallery", context,
                                                isMedium: true),
                                            Widgets.buildText(
                                                " (${Helpers.formatNumber(((_data["images"] ?? []).length + (_data["otherPhotos"] ?? []).length + (_data["videos"] ?? []).length).toString())})",
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
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              List<String> photos = [];
                                              String title = "";
                                              if (index == 0) {
                                                photos = _data["images"] ?? [];
                                                title = "All Photos";
                                              } else if (index == 1) {
                                                photos =
                                                    _data["otherPhotos"] ?? [];
                                                title = "Other Photos";
                                              } else {
                                                photos = _data["videos"] ?? [];
                                                title = "Videos";
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 40.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Widgets.buildText(
                                                        title, context,
                                                        color: "main.primary"),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    GridView.count(
                                                        crossAxisCount: 3,
                                                        mainAxisSpacing: 15,
                                                        crossAxisSpacing: 15,
                                                        physics:
                                                            NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                                        shrinkWrap: true,
                                                        children: <Widget>[
                                                          for (final item
                                                              in photos)
                                                            GestureDetector(
                                                              onTap: () {
                                                                Sheets
                                                                    .showImagePreview(
                                                                        photos,
                                                                        title);
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child:
                                                                    Image.asset(
                                                                  item,
                                                                  height: 110,
                                                                  width: 110,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                        ])
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: 3)
                                      ],
                                    ),
                                  if (_selectedTab == 2)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Widgets.buildText(
                                            "Guest reviews", context,
                                            isMedium: true),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        TextFormField(
                                          decoration: Widgets.inputDecoration(
                                              "Search in reviews",
                                              isOutline: true,
                                              hint: "Search in reviews",
                                              hintColor:
                                                  Palette.get("text.secondary"),
                                              prefixIcon: UnconstrainedBox(
                                                child: Helpers.fetchIcons(
                                                    "search", "regular",
                                                    size: 20.0,
                                                    color: "main.primary"),
                                              ),
                                              color: Palette.get(
                                                  "background.default"),
                                              radius: 40.0,
                                              isFilled: true,
                                              isFloating: true),
                                          style: GoogleFonts.poppins(
                                            color:
                                                Palette.get("text.secondary"),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor: Palette.get(
                                                    "background.default"),
                                                label: Widgets.buildText(
                                                    "Filters", context,
                                                    weight: 500),
                                              ),
                                            )),
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (reviewFilter
                                                      .contains("verified")) {
                                                    reviewFilter
                                                        .remove("verified");
                                                  } else {
                                                    reviewFilter
                                                        .add("verified");
                                                  }
                                                });
                                              },
                                              child: Chip(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor: reviewFilter
                                                        .contains("verified")
                                                    ? Palette.get(
                                                        "main.primary")
                                                    : Palette.get(
                                                        "background.default"),
                                                label: FittedBox(
                                                  child: Widgets.buildText(
                                                      "Verified", context,
                                                      weight: 500,
                                                      color:
                                                          reviewFilter.contains(
                                                                  "verified")
                                                              ? "text.white"
                                                              : "text.primary"),
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (reviewFilter
                                                      .contains("latest")) {
                                                    reviewFilter
                                                        .remove("latest");
                                                  } else {
                                                    reviewFilter.add("latest");
                                                  }
                                                });
                                              },
                                              child: Chip(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor: reviewFilter
                                                        .contains("latest")
                                                    ? Palette.get(
                                                        "main.primary")
                                                    : Palette.get(
                                                        "background.default"),
                                                label: FittedBox(
                                                  child: Widgets.buildText(
                                                      "Latest", context,
                                                      weight: 500,
                                                      color:
                                                          reviewFilter.contains(
                                                                  "latest")
                                                              ? "text.white"
                                                              : "text.primary"),
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (reviewFilter
                                                      .contains("photos")) {
                                                    reviewFilter
                                                        .remove("photos");
                                                  } else {
                                                    reviewFilter.add("photos");
                                                  }
                                                });
                                              },
                                              child: Chip(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor: reviewFilter
                                                        .contains("photos")
                                                    ? Palette.get(
                                                        "main.primary")
                                                    : Palette.get(
                                                        "background.default"),
                                                label: FittedBox(
                                                  child: Widgets.buildText(
                                                      "With Photos", context,
                                                      weight: 500,
                                                      color:
                                                          reviewFilter.contains(
                                                                  "photos")
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
                                              color: Palette.get(
                                                  "background.paper"),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    spreadRadius: 0,
                                                    offset: Offset(-1, 1),
                                                    color: Color(0x1A000000))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              for (final category
                                                  in (_isReviewAll
                                                      ? Defaults
                                                          .hotelReviewCategories
                                                      : Defaults
                                                          .hotelReviewCategories
                                                          .getRange(0, 3)))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Column(children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Widgets.buildText(
                                                              category["name"]
                                                                  .toString(),
                                                              context,
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Widgets.buildText(
                                                                "(${Helpers.formatNumber((((num.tryParse(_data["reviews"][category["value"].toString()].toString())?.toDouble() ?? 0.0) / 5.0) * 100.0).toString())}%)",
                                                                context,
                                                                color:
                                                                    "main.primary")
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
                                                                  color:
                                                                      "main.primary"))
                                                      ],
                                                    ),
                                                    SliderTheme(
                                                      data: SliderTheme.of(
                                                              context)
                                                          .copyWith(
                                                              trackHeight: 20.0,
                                                              thumbShape:
                                                                  RoundSliderThumbShape(
                                                                      enabledThumbRadius:
                                                                          17),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          0.0)),
                                                      child: Slider(
                                                          inactiveColor:
                                                              Palette.getColor(
                                                                  context,
                                                                  "background",
                                                                  "textfield"),
                                                          value: (((num.tryParse(
                                                                          _data["reviews"][category["value"].toString()]
                                                                              .toString())
                                                                      ?.toDouble() ??
                                                                  0.0) /
                                                              5.0)),
                                                          onChanged:
                                                              (value) {}),
                                                    ),
                                                  ]),
                                                )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final review = _data["reviews"]
                                                  ["reviews"][index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Helpers.getPhoto(
                                                                review["photo"] ??
                                                                    "",
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
                                                                        isMedium:
                                                                            true),
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
                                                                          .only(
                                                                          top:
                                                                              5.0),
                                                                  child:
                                                                      SvgPicture
                                                                          .string(
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            for (var i = 0;
                                                                i <
                                                                    (num.tryParse(review["rating"].toString())
                                                                            ?.toInt() ??
                                                                        0);
                                                                i += 1)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            2.0),
                                                                child: Helpers
                                                                    .fetchIcons(
                                                                        "star",
                                                                        "solid",
                                                                        color:
                                                                            "warning.main",
                                                                        size:
                                                                            18.0),
                                                              )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 60.0),
                                                      child: Column(
                                                        children: [
                                                          if (review
                                                              .containsKey(
                                                                  "photos"))
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          15.0),
                                                              child: Wrap(
                                                                spacing: 10.0,
                                                                runSpacing:
                                                                    10.0,
                                                                runAlignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                children: [
                                                                  for (final photo
                                                                      in review[
                                                                          "photos"])
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      child: Image.asset(
                                                                          photo,
                                                                          height:
                                                                              120,
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                          Widgets.buildText(
                                                              review["review"]
                                                                  .toString(),
                                                              context,
                                                              color:
                                                                  "text.disabled",
                                                              lines: 100),
                                                          const SizedBox(
                                                              height: 10.0),
                                                          if (review
                                                              .containsKey(
                                                                  "response"))
                                                            Column(
                                                              children: [
                                                                const SizedBox(
                                                                    height:
                                                                        10.0),
                                                                Row(
                                                                  children: [
                                                                    Helpers.getPhoto(
                                                                        review["response"]["photo"] ??
                                                                            "",
                                                                        text: review["response"]["name"]
                                                                            .toString(),
                                                                        height:
                                                                            40.0),
                                                                    const SizedBox(
                                                                      width:
                                                                          10.0,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Widgets.buildText(
                                                                              "Response from ${review["response"]["name"].toString()}",
                                                                              context,
                                                                              color: "text.secondary"),
                                                                          Widgets.buildText(
                                                                              review["date"].toString(),
                                                                              context,
                                                                              color: "text.disabled"),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        10.0),
                                                                Widgets.buildText(
                                                                    review["response"]
                                                                            [
                                                                            "review"]
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
                                            itemCount: _data["reviews"]
                                                    .containsKey("reviews")
                                                ? _data["reviews"]["reviews"]
                                                    .length
                                                : 0),
                                        const SizedBox(height: 20.0),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                              onPressed: () {},
                                              child: Widgets.buildText(
                                                  "Load More", context,
                                                  color: "main.primary",
                                                  size: 16.0)),
                                        )
                                      ],
                                    )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () async {
                  final selectedTicket =
                      await AttractionModals.showTickets(_data, fee);
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
                            Widgets.buildText(
                                "From ${Helpers.formatCurrency(_data["price"].toString())}",
                                context,
                                color: "main.primary",
                                isMedium: true),
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
