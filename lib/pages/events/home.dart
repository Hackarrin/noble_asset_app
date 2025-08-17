import 'dart:convert';

import 'package:nobleassets/globals/event_item.dart';
import 'package:nobleassets/globals/shortlet_item.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/home_header.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class EventHome extends StatefulWidget {
  const EventHome({Key? key}) : super(key: key);

  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  var selected = 0;

  final Map<String, dynamic> data = {
    "recentSearch": [
      {"name": "Burna boy Live", "value": "burna"},
      {"name": "Burna boy Live", "value": "burna"},
      {"name": "Burna boy Live", "value": "burna"},
      {"name": "Burna boy Live", "value": "burna"},
      {"name": "Burna boy Live", "value": "burna"},
    ],
    "favouriteCategories": {
      "sports": "category-sport.jpeg",
      "music": "category-music.jpeg",
      "arts-culture": "category-arts.jpeg",
      "food-drink": "category-food.jpeg",
      "education": "category-education.jpeg",
      "networking": "category-networking.jpeg",
      "family-kids": "category-family.jpeg",
      "technology": "category-technology.jpeg",
      "health-wellness": "category-health.jpeg",
      "film-media": "category-media.jpeg",
      "hobbies-interests": "category-hobbies.png",
      "fashion": "category-fashion.png",
      "travel-outdoor": "category-outdoor.jpeg",
      "religion-spirituality": "category-religion.jpeg",
      "government-politics": "category-youth.jpeg",
      "science-nature": "category-science.jpeg",
      "shopping-markets": "category-shopping.jpeg",
      "holiday-seasonal": "category-holiday.jpeg",
      "virtual-events": "category-virtual.jpeg",
      "charity-causes": "category-charity.jpeg",
    },
    "comingSoon": [
      {
        "image": "coming-soon-drink.jpeg",
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
        "title": "Food & Drink",
      },
      {
        "image": "coming-soon-music.jpeg",
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
        "title": "Music",
      },
      {
        "image": "coming-soon-networking.jpeg",
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
        "title": "Networking",
      },
      {
        "image": "coming-soon-drink.jpeg",
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
        "title": "Food & Drink",
      },
      {
        "image": "coming-soon-music.jpeg",
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
        "title": "Music",
      },
      {
        "image": "coming-soon-networking.jpeg",
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
        "title": "Networking",
      },
    ],
    "topAttractions": [
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
      {
        "image": "attraction.png",
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
        "title": "INSIDE CAGE",
        "location": "Lekki, Lagos",
        "host": "John wick",
        "price": 6000,
      },
    ],
    "attractions": [
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
        "title": "Omu Resort",
        "price": 7000,
        "image": "omuresort.jpeg",
        "favourite": 1,
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
        "title": "Conservation",
        "price": 7000,
        "image": "londoneye.jpeg",
        "favourite": 1,
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
        "title": "London Eye",
        "price": 90000,
        "image": "londoneye.jpeg",
        "favourite": 1,
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
        "title": "Lagos Museum",
        "price": 10000,
        "image": "museum.png",
        "favourite": 1,
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
        "title": "London Eye",
        "price": 90000,
        "image": "londoneye.jpeg",
        "favourite": 1,
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
        "title": "Lagos Museum",
        "price": 10000,
        "image": "museum.png",
        "favourite": 1,
      },
    ],
    "items": [
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
    "paidEvents": [
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
    "todayEvents": [
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
    "featuredEvents": [
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
    "virtualEvents": [
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
    "featuredCountries": [
      {
        "country": "Nigeria",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(255, 15, 0, 0.91)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(23, 255, 74, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(28, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(23, 255, 227, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(195, 255, 23, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(255, 162, 23, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(139, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(255, 107, 23, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(255, 153, 0, 0.91)"},
          {"name": "Gombe", "count": 16, "color": "rgba(255, 232, 23, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(48, 58, 66, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(24, 89, 2, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(208, 208, 208, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(181, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(23, 255, 171, 1)"
          },
        ],
      },
      {
        "country": "South Africa",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
      {
        "country": "Kenya",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
      {
        "country": "Morroca",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
      {
        "country": "Angola",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
      {
        "country": "Dubai",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
      {
        "country": "Asia",
        "items": [
          {"name": "Bauchi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Anambra", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Akwa Ibom", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Adamawa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Abia", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Delta", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Cross River",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
          {"name": "Borno", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Benue", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Bayelsa", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Gombe", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Enugu", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ekiti", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Edo", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {"name": "Ebonyi", "count": 16, "color": "rgba(250, 23, 255, 1)"},
          {
            "name": "Port Harcourt",
            "count": 16,
            "color": "rgba(250, 23, 255, 1)"
          },
        ],
      },
    ],
    "featuredAttractionCountries": [
      {
        "country": "Nigeria",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "South Africa",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "Kenya",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "Morroca",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "Angola",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "Dubai",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
      },
      {
        "country": "Asia",
        "items": [
          {
            "name": "Bauchi",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {
            "name": "Anambra",
            "count": 16,
            "image": "featured-attraction-2.jpeg"
          },
          {
            "name": "Akwa Ibom",
            "count": 16,
            "image": "featured-attraction-3.jpeg"
          },
          {
            "name": "Adamawa",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Abia", "count": 16, "image": "featured-attraction-2.jpeg"},
          {"name": "Delta", "count": 16, "image": "featured-attraction-3.jpeg"},
          {
            "name": "Cross River",
            "count": 16,
            "image": "featured-attraction-1.jpeg"
          },
          {"name": "Borno", "count": 16, "image": "featured-attraction-2.jpeg"},
        ],
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
                  HomeHeader(searchPage: '/event-filter'),
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
                                        context, "/event-categories",
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
                                      ((data["favouriteCategories"] ?? {})
                                                  .keys
                                                  .length >
                                              5
                                          ? 5
                                          : (data["favouriteCategories"] ?? {})
                                              .keys
                                              .length);
                                  i += 1)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/event-filter",
                                            arguments: jsonEncode({
                                              "category":
                                                  (data["favouriteCategories"] ??
                                                          {})
                                                      .keys
                                                      .toList()[i]
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
                                                  Defaults.eventsCategories
                                                      .firstWhere(
                                                          (item) =>
                                                              item["value"]
                                                                  .toString() ==
                                                              (data["favouriteCategories"] ??
                                                                      {})
                                                                  .keys
                                                                  .toList()[i]
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
                                                Defaults.eventsCategories
                                                    .firstWhere(
                                                        (item) =>
                                                            item["value"]
                                                                .toString() ==
                                                            (data["favouriteCategories"] ??
                                                                    {})
                                                                .keys
                                                                .toList()[i]
                                                                .toString(),
                                                        orElse: () => {
                                                              "name": ""
                                                            })["name"]
                                                    .toString(),
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
                                      (data["featuredEvents"] ?? [])[index];
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
                                    (data["featuredEvents"] ?? []).length,
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
                              Widgets.buildText("Discover Events", context,
                                  isMedium: true),
                              GestureDetector(
                                onTap: () {
                                  Sheets.showConfirmation();
                                },
                                child: ClipOval(
                                    child: Image.asset("assets/images/NGN.png",
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 400.0)),
                              child: Swiper(
                                layout: SwiperLayout.TINDER,
                                itemHeight: 400.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["featuredEvents"] ?? [])[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/event",
                                          arguments: jsonEncode(item));
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
                                              color: Color(0x0D000000)),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, -7),
                                                blurRadius: 22.5,
                                                spreadRadius: 0,
                                                color: Color(0x0A000000))
                                          ]),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 26.0,
                                                width: 26 * 3,
                                                child: WidgetStack(
                                                  positions:
                                                      RestrictedPositions(
                                                    maxCoverage: 0.4,
                                                    minCoverage: 0.2,
                                                    align: StackAlign.left,
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
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                                color: Palette.get(
                                                                    "background.paper"))),
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                              item["genre"][n]
                                                                      ["photo"]
                                                                  .toString(),
                                                              width: 26.0,
                                                              height: 26.0,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                  ],
                                                  buildInfoWidget:
                                                      (surplus, ctx) {
                                                    return Container(
                                                        width: 24.0,
                                                        height: 24.0,
                                                        decoration: BoxDecoration(
                                                            color: Palette.get(
                                                                "main.primary"),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0)),
                                                        child: Center(
                                                          child: Widgets.buildText(
                                                              '+$surplus',
                                                              context,
                                                              weight: 500,
                                                              color:
                                                                  "text.white",
                                                              size: 11.0),
                                                        ));
                                                  },
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
                                                  child: Helpers.fetchIcons(
                                                    "heart",
                                                    "regular",
                                                    size: 20.0,
                                                    color: "main.primary",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Widgets.buildText(
                                                    item["title"].toString(),
                                                    context,
                                                    weight: 500,
                                                    size: 16.0),
                                              ),
                                              const SizedBox(width: 25.0),
                                              Row(
                                                children: [
                                                  Helpers.fetchIcons(
                                                    "marker",
                                                    "solid",
                                                    color: "main.primary",
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                      item["location"], context,
                                                      color: "text.secondary"),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Widgets.buildText(
                                                    "Hosted by ${item["host"].toString()}",
                                                    context,
                                                    color: "text.secondary"),
                                              ),
                                              const SizedBox(width: 25.0),
                                              Row(
                                                children: [
                                                  Helpers.fetchIcons(
                                                      "calendar-clock", "solid",
                                                      color: "main.primary"),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Widgets.buildText(
                                                      "${item["date"].toString()} - ${item["time"].toString()}",
                                                      context,
                                                      color: "text.secondary"),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                item["image"].toString(),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    (data["featuredEvents"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Events Today", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/events-today",
                                        arguments: jsonEncode({
                                          "data": (data["todayEvents"] ?? []),
                                          "title": "Events Today"
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
                                    (data["todayEvents"] ?? []).length,
                                    screenWidth,
                                    offset: 0.0),
                                itemHeight: 365.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["todayEvents"] ?? [])[index];
                                  return EventItem(item: item, offset: 0.0);
                                },
                                itemCount: (data["todayEvents"] ?? []).length,
                              )),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Events this Week", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/events-today",
                                        arguments: jsonEncode({
                                          "data": (data["todayEvents"] ?? []),
                                          "title": "Events this Week"
                                        }));
                                  },
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = (data["todayEvents"] ?? [])[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: EventItem(
                                    item: item, direction: "horizontal"),
                              );
                            },
                            itemCount: (data["todayEvents"] ?? []).length,
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets.buildText("Events this Month", context,
                                  isMedium: true),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, "/events-today",
                                      arguments: jsonEncode({
                                        "data": (data["todayEvents"] ?? []),
                                        "title": "Events this Month"
                                      })),
                                  child: Widgets.buildText("See all", context,
                                      color: "main.primary"))
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints.loose(
                                  Size(screenWidth, 415.0)),
                              child: Swiper(
                                outer: true,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: Widgets.customLayout(
                                    (data["todayEvents"] ?? []).length,
                                    screenWidth,
                                    offset: 100.0),
                                itemHeight: 400.0,
                                itemWidth: screenWidth,
                                loop: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      (data["todayEvents"] ?? [])[index];
                                  return EventItem(
                                    item: item,
                                    direction: "vertical",
                                    offset: 100.0,
                                  );
                                },
                                itemCount: (data["todayEvents"] ?? []).length,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Widgets.buildText("Popular Events", context,
                              isMedium: true),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 50.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  final item = filters[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedFilter =
                                              item["value"].toString();
                                        });
                                      },
                                      child: Chip(
                                          backgroundColor: Palette.get(
                                              selectedFilter ==
                                                      item["value"].toString()
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
                                                      item["value"].toString()
                                                  ? "text.white"
                                                  : "text.secondary")),
                                    ),
                                  );
                                },
                                itemCount: 5),
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
                                child: EventItem(
                                  item: item,
                                  isRegular: true,
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
