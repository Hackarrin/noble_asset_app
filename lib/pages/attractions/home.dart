import 'dart:convert';

import 'package:afritas/globals/attraction_item.dart';
import 'package:afritas/utils/defaults.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/home_header.dart';
import 'package:afritas/utils/widget.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';

import '../../utils/palette.dart';

class AttractionHome extends StatefulWidget {
  const AttractionHome({Key? key}) : super(key: key);

  @override
  _AttractionHomeState createState() => _AttractionHomeState();
}

class _AttractionHomeState extends State<AttractionHome> {
  var selected = 0;

  final Map<String, dynamic> data = {
    "favouriteCategories": [
      "museum",
      "park",
      "cultural_site",
      "historical_site",
      "amusement_park"
    ],
    "locations": [
      {
        "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg",
        "name": "lagos",
        "dateFrom": "2025-04-03",
        "dateTo": "",
        "value": "lagos"
      },
      {
        "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg",
        "name": "lagos",
        "dateFrom": "2025-03-27",
        "dateTo": "",
        "value": "lagos"
      },
      {
        "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg",
        "name": "lagos",
        "dateFrom": "2025-03-26",
        "dateTo": "",
        "value": "lagos"
      },
      {
        "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg",
        "name": "lagos",
        "dateFrom": "2025-02-10",
        "dateTo": "",
        "value": "lagos"
      },
      {
        "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg",
        "name": "lagos",
        "dateFrom": "2025-02-09",
        "dateTo": "",
        "value": "lagos"
      }
    ],
    "topAttractions": [
      {
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-1.jpeg",
        "listingId": "473307",
        "price": "0",
        "reviews": "200",
        "favourite": "0",
        "host": "Ola Alli"
      },
      {
        "title": "Lekki Conservation Center",
        "category": "arts-culture",
        "location": "Lagos",
        "image": "assets/images/attraction-2.jpeg",
        "listingId": "473307",
        "price": "0",
        "reviews": "200",
        "favourite": "0",
        "host": "Ola Alli"
      },
    ],
    "featuredAttractions": [
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
    "explore": [
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
    "mustVisit": [
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
    "featuredCountries": [
      {
        "country": "Lagos",
        "total": "10",
        "image": "assets/images/attraction-3.jpeg",
        "items": [
          {
            "name": "Lagos",
            "count": "1",
            "image": "Qeqli0xtZWc7hCFMVQC9pVWZOlH9Jz.jpeg"
          }
        ]
      },
      {
        "country": "Imo",
        "image": "assets/images/attraction-3.jpeg",
        "items": [],
        "total": "10",
      },
      {
        "country": "Ogun",
        "image": "assets/images/attraction-3.jpeg",
        "items": [],
        "total": "10",
      },
      {
        "country": "Anambra",
        "image": "assets/images/attraction-3.jpeg",
        "items": [],
        "total": "10",
      },
      {
        "country": "Abuja",
        "image": "assets/images/attraction-3.jpeg",
        "items": [],
        "total": "10",
      },
      {
        "country": "Rivers",
        "image": "assets/images/attraction-3.jpeg",
        "items": [],
        "total": "10",
      }
    ],
    "items": [
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
  };
  final List filters = [
    {"title": "All", "value": ""},
    {"title": "Paid", "value": "paid"},
    {"title": "Virtual", "value": "virtual"},
    {"title": "Free", "value": "free"},
    {"title": "Future", "value": "future"},
  ];
  String selectedFilter = "";

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
    final height = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final backgroundHeight = height * 0.25;
    final mainPaddingTop = backgroundHeight / 10;
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: backgroundHeight,
            decoration: BoxDecoration(
              color: Palette.getColor(context, "main", "primary"),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/homebg-transparent.png',
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(120),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const SizedBox()),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 15.0, right: 15.0, top: mainPaddingTop),
              child: Column(
                children: [
                  HomeHeader(
                    searchPage: '/attraction-filter',
                    hint: "Search attractions, parks...",
                  ),
                  SizedBox(
                    height: mainPaddingTop * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Categories", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/attraction-categories",
                                        arguments: jsonEncode(
                                            data["favouriteCategories"]));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0;
                                  i <
                                      ((data["favouriteCategories"] ?? [])
                                                  .length >
                                              5
                                          ? 5
                                          : (data["favouriteCategories"] ?? [])
                                              .length);
                                  i += 1)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/attraction-filter",
                                            arguments: jsonEncode({
                                              "category":
                                                  (data["favouriteCategories"] ??
                                                          {})[i]
                                                      .toString(),
                                            }));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              color: Palette.getColor(context,
                                                  "background", "paper"),
                                              border: Border.all(
                                                color: Color(0x0d000000),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: FittedBox(
                                              child: Helpers.fetchIcons(
                                                  Defaults.attractionCategories
                                                      .firstWhere(
                                                          (item) =>
                                                              item["value"]
                                                                  .toString() ==
                                                              (data["favouriteCategories"] ??
                                                                      [])[i]
                                                                  .toString(),
                                                          orElse: () => {
                                                                "icon": ""
                                                              })["icon"]
                                                      .toString(),
                                                  "solid",
                                                  size: 24.0,
                                                  color: "main.primary"),
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          FittedBox(
                                            child: Widgets.buildText(
                                                Defaults.attractionCategories
                                                    .firstWhere(
                                                        (item) =>
                                                            item["value"]
                                                                .toString() ==
                                                            (data["favouriteCategories"] ??
                                                                    [])[i]
                                                                .toString(),
                                                        orElse: () => {
                                                              "name": ""
                                                            })["name"]
                                                    .toString()
                                                    .split(" ")[0]
                                                    .trim(),
                                                context),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 230.0)),
                              child: Swiper(
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["topAttractions"] ?? [])[index];
                                  return Container(
                                    height: 180.0,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Palette.getColor(
                                            context, "background", "paper"),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            item["image"].toString(),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  stops: [
                                                    0.1,
                                                    0.9
                                                  ],
                                                  colors: [
                                                    Colors.black.withAlpha(204),
                                                    Colors.black.withAlpha(26)
                                                  ])),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, bottom: 10.0),
                                              child: Widgets.buildText(
                                                  item["title"].toString(),
                                                  context,
                                                  isMedium: true,
                                                  color: "text.white"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3.0),
                                          decoration: BoxDecoration(
                                              color: Color(0xB3403c3c),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Widgets.buildText(
                                              "Ads", context,
                                              size: 12.0,
                                              weight: 500,
                                              color: "text.white"),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["topAttractions"] ?? []).length,
                                pagination: SwiperPagination(builder:
                                    SwiperCustomPagination(builder:
                                        (BuildContext context,
                                            SwiperPluginConfig config) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i < config.itemCount;
                                          i += 1)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 0.0),
                                          child: Container(
                                              width: config.activeIndex == i
                                                  ? 25
                                                  : 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: config.activeIndex == i
                                                      ? Palette.getColor(
                                                          context,
                                                          "main",
                                                          "primary")
                                                      : Color(0xffd9d9d9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                    ],
                                  );
                                })),
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Featured Attractions", context,
                                  isMedium: true),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 300.0)),
                              child: Swiper(
                                layout: SwiperLayout.TINDER,
                                itemHeight: 300.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = (data["featuredAttractions"] ??
                                      [])[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/attraction",
                                          arguments: jsonEncode(item));
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Palette.getColor(
                                              context, "background", "paper"),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, -7),
                                                blurRadius: 22.5,
                                                spreadRadius: 0,
                                                color: Color(0x0A000000))
                                          ]),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              item["image"].toString(),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "background.overlay"),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              spacing: 10.0,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  spacing: 10.0,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Palette.get(
                                                              "background.paper"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      80)),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      child: Row(
                                                        children: [
                                                          Helpers.fetchIcons(
                                                            "star",
                                                            "solid",
                                                            color:
                                                                "warning.main",
                                                          ),
                                                          const SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Widgets.buildText(
                                                            item["rating"]
                                                                .toString(),
                                                            context,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Palette.getColor(
                                                                context,
                                                                "background",
                                                                "default"),
                                                        radius: 20.0,
                                                        child:
                                                            Helpers.fetchIcons(
                                                          "heart",
                                                          "regular",
                                                          size: 20.0,
                                                          color: "main.primary",
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  spacing: 10.0,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        spacing: 10.0,
                                                        children: [
                                                          Widgets.buildText(
                                                              item["title"]
                                                                  .toString(),
                                                              context,
                                                              weight: 500,
                                                              size: 16.0,
                                                              color:
                                                                  "text.white"),
                                                          Row(
                                                            spacing: 5.0,
                                                            children: [
                                                              Widgets.buildText(
                                                                  item["duration"]
                                                                      .toString(),
                                                                  context,
                                                                  color:
                                                                      "text.white",
                                                                  isMedium:
                                                                      true,
                                                                  size: 13.0),
                                                              Widgets.buildText(
                                                                  "·", context,
                                                                  color:
                                                                      "text.white",
                                                                  isMedium:
                                                                      true,
                                                                  size: 13.0),
                                                              Widgets.buildText(
                                                                  Helpers.formatCurrency(
                                                                      item["price"]
                                                                          .toString()),
                                                                  context,
                                                                  color:
                                                                      "text.white",
                                                                  isMedium:
                                                                      true,
                                                                  size: 13.0)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 26.0,
                                                            width: 26 * 3,
                                                            child: WidgetStack(
                                                              positions:
                                                                  RestrictedPositions(
                                                                maxCoverage:
                                                                    0.4,
                                                                minCoverage:
                                                                    0.2,
                                                                align:
                                                                    StackAlign
                                                                        .left,
                                                              ),
                                                              stackedWidgets: [
                                                                for (var n = 0;
                                                                    n <
                                                                        (item["genre"] ??
                                                                                [])
                                                                            .length;
                                                                    n++)
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                24.0),
                                                                        border: Border.all(
                                                                            color:
                                                                                Palette.get("background.paper"))),
                                                                    child:
                                                                        ClipOval(
                                                                      child: Image.asset(
                                                                          item["genre"][n]["photo"]
                                                                              .toString(),
                                                                          width:
                                                                              26.0,
                                                                          height:
                                                                              26.0,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                              ],
                                                              buildInfoWidget:
                                                                  (surplus,
                                                                      ctx) {
                                                                return Container(
                                                                    width: 24.0,
                                                                    height:
                                                                        24.0,
                                                                    decoration: BoxDecoration(
                                                                        color: Palette.get(
                                                                            "main.primary"),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                24.0)),
                                                                    child:
                                                                        Center(
                                                                      child: Widgets.buildText(
                                                                          '+$surplus',
                                                                          context,
                                                                          weight:
                                                                              500,
                                                                          color:
                                                                              "text.white",
                                                                          size:
                                                                              11.0),
                                                                    ));
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Palette.getColor(
                                                                context,
                                                                "main",
                                                                "primary"),
                                                        radius: 30.0,
                                                        child:
                                                            Helpers.fetchIcons(
                                                          "arrow-up-right",
                                                          "regular",
                                                          size: 16.0,
                                                          color: "text.white",
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["featuredAttractions"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Explore", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/attraction-explore",
                                        arguments: jsonEncode({
                                          "data": (data["explore"] ?? []),
                                          "title": "Explore"
                                        }));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 365.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["explore"] ?? []).length, screenWidth,
                                    offset: 100.0),
                                itemHeight: 365.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = (data["explore"] ?? [])[index];
                                  return AttractionItem(
                                    item: item,
                                    offset: 100.0,
                                    isRegular: true,
                                    direction: "vertical",
                                  );
                                },
                                itemCount: (data["explore"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Must Visit Places", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/attraction-explore",
                                        arguments: jsonEncode({
                                          "data": (data["mustVisit"] ?? []),
                                          "title": "Must Visit Places"
                                        }));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverToBoxAdapter(
                                child: MasonryGrid(
                                    column: 2,
                                    staggered: true,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 20.0,
                                    children: [
                                      for (int i = 0;
                                          i < (data["mustVisit"] ?? []).length;
                                          i += 1)
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/attraction",
                                                arguments: jsonEncode(
                                                    (data["mustVisit"] ??
                                                        [])[i]));
                                          },
                                          child: SizedBox(
                                            height: i == 0 ||
                                                    i == 2 ||
                                                    i == 3 ||
                                                    i == 4
                                                ? 250
                                                : 120.0,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.asset(
                                                    (data["mustVisit"] ?? [])[i]
                                                            ["image"]
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(
                                                          "background.overlay"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    spacing: 10.0,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: GestureDetector(
                                                          onTap: () {},
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Palette.getColor(
                                                                    context,
                                                                    "background",
                                                                    "default"),
                                                            radius: 20.0,
                                                            child: Helpers
                                                                .fetchIcons(
                                                              "heart",
                                                              "regular",
                                                              size: 20.0,
                                                              color:
                                                                  "main.primary",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Widgets.buildText(
                                                              (data["mustVisit"] ??
                                                                          [])[i]
                                                                      ["title"]
                                                                  .toString(),
                                                              context,
                                                              color:
                                                                  "text.white",
                                                              isMedium: true,
                                                              size: 15.0),
                                                          Widgets.buildText(
                                                              Helpers.formatCurrency(
                                                                  (data["mustVisit"] ??
                                                                              [])[i]
                                                                          [
                                                                          "price"]
                                                                      .toString()),
                                                              context,
                                                              color:
                                                                  "text.white",
                                                              weight: 500),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                    ]),
                              )
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Featured Countries", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, "/attraction-explore",
                                      arguments: jsonEncode({
                                        "data":
                                            (data["featuredCountries"] ?? []),
                                        "title": "Featured Countries"
                                      })),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    child: Row(
                                      spacing: 1.0,
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            "assets/images/NGN.png",
                                            width: 24.0,
                                            height: 24.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                          child: VerticalDivider(
                                            color: Color(0x1A000000),
                                          ),
                                        ),
                                        Widgets.buildText("See all", context,
                                            color: "main.primary"),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 150.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final item =
                                    (data["featuredCountries"] ?? [])[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      spacing: 5.0,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.asset(
                                            item["image"].toString(),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Widgets.buildText(
                                            item["country"].toString(), context,
                                            isMedium: true),
                                        Widgets.buildText(
                                            "${Helpers.formatNumber(item["total"].toString())} attractions",
                                            context,
                                            color: "text.secondary"),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  (data["featuredCountries"] ?? []).length,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = (data["items"] ?? [])[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: AttractionItem(
                                  item: item,
                                  direction: "horizontal",
                                ),
                              );
                            },
                            itemCount: (data["items"] ?? []).length,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {},
                                child: Widgets.buildText("Load more", context,
                                    isMedium: true, color: "main.primary")),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
