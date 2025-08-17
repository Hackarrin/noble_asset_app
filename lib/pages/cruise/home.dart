import 'dart:convert';

import 'package:nobleassets/globals/cruise_item.dart';
import 'package:nobleassets/utils/bookings/general.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/home_header.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class CruiseHome extends StatefulWidget {
  const CruiseHome({Key? key}) : super(key: key);

  @override
  _CruiseHomeState createState() => _CruiseHomeState();
}

class _CruiseHomeState extends State<CruiseHome> {
  var selected = 0;
  var selectedFilter = "all";
  var selectedLocation = "lagos";
  final Map<String, dynamic> data = {
    "featuredItems": [
      {
        "name": "The Landmark",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 5
      },
      {
        "name": "Eye of the storm",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 4
      },
      {
        "name": "The Landmark",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 5
      },
      {
        "name": "Eye of the storm",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 4
      },
      {
        "name": "The Landmark",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 5
      },
      {
        "name": "Eye of the storm",
        "image": "assets/images/boat-1.jpeg",
        "id": "hotel",
        "rating": 4
      },
    ],
    "featuredLocations": [
      {
        "title": "Lagos",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      },
      {
        "title": "Abuja",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      },
      {
        "title": "Rivers",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      },
      {
        "title": "Kano",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      }
    ],
    "recentSearches": [
      {
        "name": "The Landmark",
        "date": "15 - 18 Jan",
        "duration": "3 days",
        "image": "assets/images/boat-1.jpeg"
      },
      {
        "name": "Eye of the Storm",
        "date": "15 - 18 Jan",
        "guest": "7 days",
        "image": "assets/images/boat-2.jpeg"
      },
      {
        "name": "The Landmark",
        "date": "15 - 18 Jan",
        "duration": "3 days",
        "image": "assets/images/boat-1.jpeg"
      },
      {
        "name": "Eye of the Storm",
        "date": "15 - 18 Jan",
        "guest": "7 days",
        "image": "assets/images/boat-2.jpeg"
      }
    ],
    "popularHires": [
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
    ],
    "nearbyBoats": [
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
        "isNew": 1,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "Eye of the storm",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Pontoon Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "50000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
      {
        "title": "The Landmark",
        "berths": "90m",
        "speed": "150 knots",
        "occupants": "10",
        "location": "Lekki, Lagos",
        "listedBy": "Zizoo Boats",
        "image": "assets/images/boat-1.jpeg",
        "images": [
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg",
          "assets/images/boat-1.jpeg",
          "assets/images/boat-2.jpeg"
        ],
        "price": "90000",
        "rating": "4.9",
        "reviews": 250,
        "listingId": "687128",
        "isFavourite": 0,
      },
    ],
    "items": [
      {
        "title": "Sailboats",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "type": "Sailboats",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Sailboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      },
      {
        "title": "Motorboats",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "type": "Motorboats",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Motorboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "type": "Motorboats",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Motorboats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "type": "Motorboats",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "type": "Motorboats",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "type": "Motorboats",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "type": "Motorboats",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      },
      {
        "title": "Fishing boats",
        "items": [
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "Eye of the storm",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Pontoon Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "50000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
          {
            "title": "The Landmark",
            "berths": "90m",
            "speed": "150 knots",
            "occupants": "10",
            "location": "Lekki, Lagos",
            "listedBy": "Zizoo Boats",
            "type": "Fishing boats",
            "image": "assets/images/boat-1.jpeg",
            "images": [
              "assets/images/boat-1.jpeg",
              "assets/images/boat-2.jpeg"
            ],
            "price": "90000",
            "rating": "4.9",
            "reviews": 250,
            "listingId": "687128",
            "isFavourite": 0,
          },
        ]
      }
    ],
  };

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
    final locationItems = Helpers.flatten((data["featuredLocations"] ?? [])
        .where((item) =>
            item["title"].toString().toLowerCase() == selectedLocation ||
            selectedLocation == "all")
        .map((item) => [...(item["items"] ?? [])])
        .toList());
    final popular = Helpers.flatten((data["items"] ?? [])
        .where((item) =>
            item["title"].toString().toLowerCase() == selectedFilter ||
            selectedFilter == "all")
        .map((item) => [...(item["items"] ?? [])])
        .toList());
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
                  HomeHeader(searchPage: '/cruise-search'),
                  SizedBox(
                    height: mainPaddingTop * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 230.0)),
                              child: Swiper(
                                outer: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["featuredItems"] ?? [])[index];
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
                                                  item["name"].toString(),
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
                                itemCount: (data["featuredItems"] ?? []).length,
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
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  final item = index ==
                                          (data["featuredLocations"] ?? [])
                                              .length
                                      ? {"title": "See all"}
                                      : (data["featuredLocations"] ??
                                          [])[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (index ==
                                            (data["featuredLocations"] ?? [])
                                                .length) {
                                          Navigator.pushNamed(
                                              context, "/cruise-categories",
                                              arguments: jsonEncode(
                                                  data["featuredLocations"]));
                                        } else {
                                          setState(() {
                                            selectedLocation = item["title"]
                                                .toString()
                                                .toLowerCase();
                                          });
                                        }
                                      },
                                      child: Chip(
                                          backgroundColor: Palette.get(
                                              selectedLocation ==
                                                      item["title"]
                                                          .toString()
                                                          .toLowerCase()
                                                  ? "main.primary"
                                                  : "background.paper"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          label: Widgets.buildText(
                                              item["title"], context,
                                              weight: 500,
                                              size: 15.0,
                                              color: index == (data["featuredLocations"] ?? []).length
                                                  ? "main.primary"
                                                  : (selectedLocation ==
                                                          item["title"].toString().toLowerCase()
                                                      ? "text.white"
                                                      : "text.secondary"))),
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["featuredLocations"] ?? []).length +
                                        1),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 370.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.TINDER,
                                loop: true,
                                itemWidth: screenWidth,
                                itemHeight: 370.0,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = locationItems[index];
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Image.asset(
                                          item["image"].toString(),
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            color: Palette.get(
                                                "background.overlay")),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 10.0,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    style: Widgets.buildButton(
                                                        context,
                                                        background: Palette.get(
                                                            "background.paper"),
                                                        radius: 20.0),
                                                    icon: Helpers.fetchIcons(
                                                        "heart", "regular",
                                                        size: 24.0,
                                                        color: "main.primary")),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              spacing: 5.0,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    spacing: 5.0,
                                                    children: [
                                                      Widgets.buildText(
                                                          item["title"]
                                                              .toString(),
                                                          context,
                                                          color: "text.white"),
                                                      Widgets.buildText(
                                                          item["listedBy"]
                                                              .toString(),
                                                          context,
                                                          color: "text.white",
                                                          isMedium: true),
                                                      Row(
                                                        spacing: 5.0,
                                                        children: [
                                                          Helpers.fetchIcons(
                                                              "star", "solid",
                                                              color:
                                                                  "warning.main"),
                                                          Widgets.buildText(
                                                              "${item["rating"]} (${Helpers.formatNumber(item["reviews"].toString())})",
                                                              context,
                                                              color:
                                                                  "text.white",
                                                              size: 14.0)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                UtilsModals.lockedActionButton(
                                                    context, "Rent Now", () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    "/cruise",
                                                  );
                                                }, radius: 60.0)
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: locationItems.length,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Recent Search", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/cruise-search");
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
                                  Size(screenWidth, 100.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["recentSearches"] ?? []).length,
                                    screenWidth,
                                    offset: 130.0),
                                itemHeight: 80.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["recentSearches"] ?? [])[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 110.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/cruise-filter",
                                            arguments: jsonEncode({
                                              "location":
                                                  item["name"].toString(),
                                              "startDate": "2025-01-15",
                                              "endDate": "2025-01-18",
                                              "duration":
                                                  item["duration"].toString()
                                            }));
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        decoration: BoxDecoration(
                                            color: Palette.getColor(
                                                context, "background", "paper"),
                                            border: Border.all(
                                                color: Color(0x0d000000)),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                item["image"].toString(),
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Widgets.buildText(
                                                      item["name"].toString(),
                                                      context,
                                                      isMedium: true),
                                                  const SizedBox(height: 5.0),
                                                  Widgets.buildText(
                                                      "${item["date"]}, ${item["duration"]}",
                                                      context,
                                                      color: "text.secondary"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["recentSearches"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Popular boat brands", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/cruise-recommended",
                                        arguments: jsonEncode(
                                            (data["popularHires"] ?? [])));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 150.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final item =
                                    (data["popularHires"] ?? [])[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/cruise-filter",
                                          arguments: jsonEncode({
                                            "vendor": item["name"].toString(),
                                          }));
                                    },
                                    child: Container(
                                      width: ((screenWidth - 50) / 2),
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color:
                                              Palette.get("background.paper"),
                                          border: Border.all(
                                              color: Color(0x0D000000))),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        spacing: 5.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.asset(
                                                  item["image"],
                                                  height: 100.0,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 5.0,
                                                right: 10.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Palette.get(
                                                        "background.paper"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    spacing: 2.0,
                                                    children: [
                                                      for (var i = 0;
                                                          i < 5;
                                                          i += 1)
                                                        Helpers.fetchIcons(
                                                            "star", "solid",
                                                            color: i <
                                                                    (num.tryParse(item["rating"].toString())
                                                                            ?.toInt() ??
                                                                        0)
                                                                ? "warning.main"
                                                                : "text.secondary",
                                                            size: 11.0)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Widgets.buildText(
                                              item["title"], context,
                                              size: 14.0)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: (data["popularHires"] ?? []).length,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Nearby Boats", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/cruise-filter",
                                        arguments: jsonEncode({}));
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
                                  Size(screenWidth, 250.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["nearbyBoats"] ?? []).length,
                                    screenWidth,
                                    offset: 80.0),
                                itemHeight: 250.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["nearbyBoats"] ?? [])[index];
                                  return CruiseItem(
                                    item: item,
                                    offset: 80.0,
                                    direction: "horizontal",
                                  );
                                },
                                itemCount: (data["nearbyBoats"] ?? []).length,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  final item = index == 0
                                      ? {"title": "All"}
                                      : (data["items"] ?? [])[index - 1];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedFilter = item["title"]
                                              .toString()
                                              .toLowerCase();
                                        });
                                      },
                                      child: Chip(
                                          backgroundColor: Palette.get(
                                              selectedFilter ==
                                                      item["title"]
                                                          .toString()
                                                          .toLowerCase()
                                                  ? "main.primary"
                                                  : "background.paper"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 10.0),
                                          label: Widgets.buildText(
                                              item["title"], context,
                                              weight: 500,
                                              size: 15.0,
                                              color: selectedFilter ==
                                                      item["title"]
                                                          .toString()
                                                          .toLowerCase()
                                                  ? "text.white"
                                                  : "text.secondary")),
                                    ),
                                  );
                                },
                                itemCount: (data["items"] ?? []).length + 1),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = popular[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CruiseItem(item: item),
                              );
                            },
                            itemCount: popular.length,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Widgets.buildText("Load more", context,
                                  isMedium: true, color: "main.primary"))
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
