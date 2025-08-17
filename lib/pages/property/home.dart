import 'dart:convert';

import 'package:nobleassets/globals/property_item.dart';
import 'package:nobleassets/main.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/home_header.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class PropertyHome extends StatefulWidget {
  const PropertyHome({Key? key}) : super(key: key);

  @override
  _PropertyHomeState createState() => _PropertyHomeState();
}

class _PropertyHomeState extends State<PropertyHome> {
  var selected = 0;
  final Map<String, dynamic> data = {
    "agents": [
      {"name": "Ola Alli", "image": "assets/images/avatar.png", "id": "hotel"},
      {"name": "John Doe", "image": "assets/images/avatar.png", "id": "house"},
      {
        "name": "Noble Assets",
        "image": "assets/images/avatar.png",
        "id": "villa"
      },
      {"name": "Smith", "image": "assets/images/avatar.png", "id": "resorts"},
      {"name": "Dante", "image": "assets/images/avatar.png", "id": "bungalow"},
    ],
    "featured": {
      "rent": [
        {
          "name": "Opulence Apartment",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Apartment",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Apartment",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Apartment",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Apartment",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
      ],
      "buy": [
        {
          "name": "Opulence Building",
          "image": "assets/images/buy.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Building",
          "image": "assets/images/buy.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Building",
          "image": "assets/images/buy.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Building",
          "image": "assets/images/buy.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        },
        {
          "name": "Opulence Building",
          "image": "assets/images/buy.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Lagos, Nigeria",
          "price": "2000000"
        }
      ],
      "land": [
        {
          "name": "3 Plot of land",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Osapa Lagos",
          "price": "2000000"
        },
        {
          "name": "3 Plot of land",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Osapa Lagos",
          "price": "2000000"
        },
        {
          "name": "3 Plot of land",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Osapa Lagos",
          "price": "2000000"
        },
        {
          "name": "3 Plot of land",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Osapa Lagos",
          "price": "2000000"
        },
        {
          "name": "3 Plot of land",
          "image": "assets/images/rent.jpg",
          "id": "hotel",
          "rating": 5,
          "isFavourite": 0,
          "location": "Osapa Lagos",
          "price": "2000000"
        }
      ]
    },
    "locations": [
      {
        "name": "Lagos",
        "listings": [
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          }
        ]
      },
      {
        "name": "Abuja",
        "listings": [
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          }
        ]
      },
      {
        "name": "Epe",
        "listings": [
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          }
        ]
      },
      {
        "name": "Aba",
        "listings": [
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          }
        ]
      },
      {
        "name": "Enugu",
        "listings": [
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Apartment",
            "image": "assets/images/rent.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "rent",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "Opulence Building",
            "image": "assets/images/buy.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "buy",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          },
          {
            "name": "3 plot of land",
            "image": "assets/images/land.jpg",
            "id": "hotel",
            "rating": 5,
            "isFavourite": 0,
            "type": "land",
            "location": "Lagos, Nigeria",
            "price": "2000000"
          }
        ]
      }
    ],
    "nearby": [
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Apartment",
        "image": "assets/images/rent.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "rent",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "Opulence Building",
        "image": "assets/images/buy.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "buy",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      },
      {
        "name": "3 plot of land",
        "image": "assets/images/land.jpg",
        "id": "hotel",
        "rating": 5,
        "isFavourite": 0,
        "type": "land",
        "location": "Lagos, Nigeria",
        "price": "2000000"
      }
    ],
    "featuredItems": [
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
    ]
  };
  String selectedCategory = "";
  String selectedFilter = "Lagos";

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
    final featured = selectedCategory == ""
        ? Helpers.flatten((data["featured"] ?? {}).values.toList())
        : (data["featured"] ?? {})[selectedCategory] ?? [];
    final popular = [];
    final locationItems = (data["locations"] ?? []).firstWhere(
            (item) => item["name"].toString() == selectedFilter,
            orElse: () => {"listings": []})['listings'] ??
        [];
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
              padding: EdgeInsets.only(bottom: 20.0, top: mainPaddingTop),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: HomeHeader(searchPage: '/property-filter'),
                  ),
                  SizedBox(
                    height: mainPaddingTop * 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.buildText("Categories", context,
                                    isMedium: true),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                SizedBox(
                                  height: 60.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        Defaults.propertyCategories.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final category =
                                          Defaults.propertyCategories[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedCategory =
                                                  category["value"].toString();
                                            });
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 15.0),
                                            decoration: BoxDecoration(
                                              color: Palette.get(
                                                  selectedCategory ==
                                                          category["value"]
                                                              .toString()
                                                      ? "main.primary"
                                                      : "background.paper"),
                                              border: Border.all(
                                                color: Color(0x0D000000),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: Row(
                                              spacing: 10.0,
                                              children: [
                                                if (category["icon"]
                                                    .toString()
                                                    .contains("/"))
                                                  FittedBox(
                                                    child: Image.asset(
                                                      category["icon"]
                                                          .toString(),
                                                      width: 30.0,
                                                      height: 30.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                if (!category["icon"]
                                                    .toString()
                                                    .contains("/"))
                                                  FittedBox(
                                                    child: Helpers.fetchIcons(
                                                        category["icon"]
                                                            .toString(),
                                                        "solid",
                                                        size: 30.0,
                                                        color: selectedCategory ==
                                                                category[
                                                                        "value"]
                                                                    .toString()
                                                            ? "text.white"
                                                            : "text.primary"),
                                                  ),
                                                FittedBox(
                                                  child: Widgets.buildText(
                                                      category["name"]
                                                          .toString(),
                                                      context,
                                                      isMedium: true,
                                                      color: selectedCategory ==
                                                              category["value"]
                                                                  .toString()
                                                          ? "text.white"
                                                          : "text.primary",
                                                      size: 13.0),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Widgets.buildText(
                                        "Top Estate Agents", context,
                                        isMedium: true),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/property-top-agents');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Palette.get(
                                                  "background.paper")),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          child: Row(
                                            spacing: 2.0,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
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
                                              Widgets.buildText(
                                                  "See all", context,
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
                                    height: 90,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item =
                                            (data["agents"] ?? [])[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/property-filter",
                                                  arguments: jsonEncode({
                                                    "agent":
                                                        item["name"].toString(),
                                                  }));
                                            },
                                            child: Column(
                                              spacing: 10.0,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Image.asset(
                                                    item["image"].toString(),
                                                    fit: BoxFit.cover,
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                ),
                                                Widgets.buildText(
                                                    item["name"].toString(),
                                                    context),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: (data["agents"] ?? []).length,
                                    )),
                                const SizedBox(
                                  height: 30.0,
                                ),
                              ],
                            ),
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 330.0)),
                              child: Swiper(
                                layout: SwiperLayout.STACK,
                                itemHeight: 330.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = featured[index];
                                  double padding =
                                      15.0 + ((featured.length - index) * 1.0);
                                  padding = padding > 100 ? 100 : padding;
                                  return IntrinsicWidth(
                                    child: Container(
                                      height: double.infinity,
                                      margin: EdgeInsets.only(left: padding),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  item["image"].toString())),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              bottomLeft:
                                                  Radius.circular(30.0))),
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30.0),
                                                bottomLeft:
                                                    Radius.circular(30.0)),
                                            color: Color(0x8c000000)),
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 30.0,
                                            bottom: 15.0,
                                            top: 30.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 20.0,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Widgets.buildText(
                                                item["name"].toString(),
                                                context,
                                                isMedium: true,
                                                size: 24.0,
                                                lines: 2,
                                                color: "text.white"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              spacing: 5.0,
                                              children: [
                                                Widgets.buildText(
                                                    Helpers.formatCurrency(
                                                        item["price"]
                                                            .toString()),
                                                    context,
                                                    isBold: true,
                                                    size: 20.0,
                                                    color: "text.white"),
                                                Widgets.buildText(
                                                    "Month", context,
                                                    size: 20.0,
                                                    color: "text.white"),
                                              ],
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Widgets.buildText(
                                                  item["location"].toString(),
                                                  context,
                                                  isMedium: true,
                                                  size: 14.0,
                                                  isRight: true,
                                                  color: "text.white"),
                                            ),
                                            Row(
                                              spacing: 20.0,
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                      onPressed: () {},
                                                      style: Widgets.buildButton(
                                                          context,
                                                          radius: 90.0,
                                                          background: Palette.get(
                                                              "background.paper"),
                                                          horizontal: 15.0,
                                                          vertical: 20.0),
                                                      child: Widgets.buildText(
                                                          "Take a look",
                                                          context,
                                                          isMedium: true)),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    style: Widgets.buildButton(
                                                        context,
                                                        radius: 40.0,
                                                        vertical: 15.0,
                                                        horizontal: 15.0,
                                                        background:
                                                            Color(0xCCFFFFFF)),
                                                    icon: Helpers.fetchIcons(
                                                        "heart", "regular",
                                                        size: 20.0))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: featured.length,
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Widgets.buildText("Top Locations", context,
                                        isMedium: true),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/property-filter');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Palette.get(
                                                  "background.paper")),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          child: Row(
                                            spacing: 2.0,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
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
                                              Widgets.buildText(
                                                  "See all", context,
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
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item =
                                            (data["locations"] ?? [])[index];
                                        final image =
                                            item["listings"][0]["image"] ?? "";
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedFilter =
                                                    item["name"].toString();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Palette.get(
                                                      selectedFilter ==
                                                              item["name"]
                                                                  .toString()
                                                          ? "main.primary"
                                                          : "background.paper"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              child: Row(
                                                spacing: 10.0,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                      image,
                                                      fit: BoxFit.cover,
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                  Widgets.buildText(
                                                      item["name"].toString(),
                                                      context,
                                                      color: selectedFilter ==
                                                              item["name"]
                                                                  .toString()
                                                          ? "text.white"
                                                          : "text.black"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          (data["locations"] ?? []).length,
                                    )),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  height: 230.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = locationItems[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/property",
                                                arguments: jsonEncode(item));
                                          },
                                          child: IntrinsicWidth(
                                            child: Container(
                                              height: 230,
                                              constraints: BoxConstraints.loose(
                                                  Size(300, 230)),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        item["image"])),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: Colors.black38,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.black38,
                                                ),
                                                child: Column(
                                                  spacing: 5.0,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      spacing: 30.0,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Palette.get(
                                                                "background.paper"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical:
                                                                      5.0),
                                                          child: Widgets.buildText(
                                                              item["type"]
                                                                  .toString()
                                                                  .capitalize(),
                                                              context),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x80000000),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical:
                                                                      5.0),
                                                          child: Widgets.buildText(
                                                              Helpers.formatCurrency(
                                                                  item["price"]
                                                                      .toString()),
                                                              context,
                                                              color:
                                                                  "text.white",
                                                              isMedium: true,
                                                              size: 13.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      spacing: 10.0,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Widgets.buildText(
                                                                  item["name"],
                                                                  context,
                                                                  isMedium:
                                                                      true,
                                                                  color:
                                                                      "text.white"),
                                                              Row(
                                                                spacing: 5.0,
                                                                children: [
                                                                  Helpers.fetchIcons(
                                                                      "marker",
                                                                      "solid",
                                                                      color:
                                                                          "text.white"),
                                                                  Widgets.buildText(
                                                                      item["location"]
                                                                          .toString(),
                                                                      context,
                                                                      color:
                                                                          "text.white")
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {},
                                                            style: Widgets
                                                                .buildButton(
                                                                    context,
                                                                    radius:
                                                                        20.0,
                                                                    background:
                                                                        Color(
                                                                            0x80FFFFFF)),
                                                            icon: Helpers
                                                                .fetchIcons(
                                                                    "heart",
                                                                    "regular",
                                                                    size: 20.0,
                                                                    color:
                                                                        "text.white"))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: locationItems.length,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Widgets.buildText("Nearby", context,
                                        isMedium: true),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/property-nearby",
                                              arguments: jsonEncode(
                                                  (data["nearby"] ?? [])));
                                        },
                                        child: Widgets.buildText(
                                            "See all", context,
                                            color: "main.primary"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  height: 270.0,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item =
                                          (data["nearby"] ?? [])[index];
                                      return PropertyItem(
                                        item: item,
                                        direction: "horizontal",
                                        offset: 20.0,
                                      );
                                    },
                                    itemCount: (data["nearby"] ?? []).length,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Widgets.buildText(
                                        "Featured Properties", context,
                                        isMedium: true),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/property-recommended",
                                              arguments: jsonEncode(
                                                  (data["featuredItems"] ??
                                                      [])));
                                        },
                                        child: Widgets.buildText(
                                            "See all", context,
                                            color: "main.primary"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  height: 300.0,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item =
                                          (data["featuredItems"] ?? [])[index];
                                      return PropertyItem(
                                        item: item,
                                        offset: 20.0,
                                      );
                                    },
                                    itemCount:
                                        (data["featuredItems"] ?? []).length,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
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
        ),
      ],
    );
  }
}
