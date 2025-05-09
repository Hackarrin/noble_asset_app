class Defaults {
  static const String appName = 'Cribsfinder';
  static const String userid = "userid";
  static const String profile = "profile";
  static const String token = "token";
  static const String quickAccess = "transfer,deposit,exchange";
  static const String defaultQuickAccess = "transfer,deposit,exchange";

  static const String pusherApiKey = "50e8fdba9cdd94fa6aca";
  static const String pusherCluster = "mt1";
  static const String pusherBeamKey = "403498d8-d607-4791-b268-ac10b37928c9";
  static const String selectedEventCategories = "selected-event-categories";
  static const String selectedAttractionCategories =
      "selected-attraction-categories";
  static const String selectedCountry = "selected-country";

  static const List hotelCategories = [
    {
      "label": "Hotel",
      "value": "hotel",
      "icon": "material-symbols=>bed-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Camping house",
      "value": "camping_house",
      "icon": "fluent-emoji-high-contrast=>camping",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Flat/Apartment",
      "value": "apartment",
      "icon": "material-symbols-light=>apartment",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Boathouse",
      "value": "boathouse",
      "icon": "map=>boat-tour",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Penthouse",
      "value": "penthouse",
      "icon": "ph=>building",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Villa",
      "value": "villa",
      "icon": "material-symbols=>villa-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Bed & breakfast",
      "value": "bedbreakfast",
      "icon": "fluent-mdl2=>breakfast",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Guest house",
      "value": "guesthouse",
      "icon": "hugeicons=>guest-house",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Cabin",
      "value": "cabin",
      "icon": "material-symbols=>cabin",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Bungalow",
      "value": "bungalow",
      "icon": "material-symbols=>bungalow-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "House",
      "value": "house",
      "icon": "mingcute=>house-2-line",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Farm house",
      "value": "farmhouse",
      "icon": "mdi=>farm-home-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Chalet",
      "value": "chalet",
      "icon": "material-symbols=>chalet-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Cottage",
      "value": "cottage",
      "icon": "material-symbols=>cottage-outline",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Townhouse",
      "value": "townhouse",
      "icon": "fluent=>building-townhouse-32-regular",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
    {
      "label": "Resort",
      "value": "resort",
      "icon": "fluent-mdl2=>ski-resorts",
      "image": "9502c610d8d4731365beacc627258964.jpeg"
    },
  ];
  static const sorts = [
    {"name": "Relevance", "value": "relevance"},
    {"name": "Popularity", "value": "popularity"},
    {"name": "Rating", "value": "rating"},
    {"name": "Discounts", "value": "discounts"},
    {"name": "Newest", "value": "newest"},
  ];
  static const List hotelFacilities = [
    {"label": "Workspace", "value": "workspace", "icon": "desk"},
    {"label": "Air Conditioning", "value": "air_conditioning", "icon": "fan"},
    {"label": "Parking Area", "value": "parking", "icon": "parking"},
    {"label": "Breakfast", "value": "breakfast", "icon": "egg-fried"},
    {"label": "Wifi", "value": "wifi", "icon": "wifi"},
    {"label": "Swimming pool", "value": "swimming_pool", "icon": "swimmer"},
    {"label": "Electricity", "value": "electricity", "icon": "lightbulb-on"},
    {"label": "Housekeeping", "value": "housekeeping", "icon": "broom"},
    {
      "label": "24hrs Reception",
      "value": "reception",
      "icon": "concierge-bell"
    },
    {"label": "TV", "value": "tv", "icon": "screen"},
    {"label": "GYM", "value": "gym", "icon": "gym"},
    {"label": "Pet Services", "value": "pet", "icon": "paw"},
    {"label": "Bar", "value": "bar", "icon": "glass-cheers"},
  ];
  static const List reservationPolicies = [
    {"label": "Refundable", "value": "refundable"},
    {"label": "Non-refundable", "value": "non-refundable"},
  ];
  static const Map<String, Map<String, String>> hotelAmenities = {
    "workspace": {
      "icon": "briefcase",
      "name": "Workspace",
    },
    "parking": {
      "icon": "parking",
      "name": "Parking Area",
    },
    "breakfast": {
      "icon": "plate-utensils",
      "name": "Breakfast",
    },
    "wifi": {
      "icon": "router-wifi",
      "name": "Fast wifi",
    },
    "swimming_pool": {
      "icon": "swimmer",
      "name": "Swimming Pool",
    },
    "electricity": {
      "icon": "bulb",
      "name": "Electricity",
    },
    "large_double_bed": {
      "icon": "bed-alt",
      "name": "1 large double bed",
    },
    "room_wifi": {
      "icon": "router-wifi",
      "name": "Fast wifi",
    },
    "pool": {
      "icon": "swimmer",
      "name": "Pool",
    },
    "entire_room": {
      "icon": "bed-alt",
      "name": "Entire room",
    },
    "private_kitchenette": {
      "icon": "grill-hot-alt",
      "name": "Private kitchenette",
    },
    "ensuite_bathroom": {
      "icon": "hot-tub",
      "name": "Ensuite bathroom",
    },
    "tv": {
      "icon": "screen",
      "name": "Flat-screen TV",
    },
    "air_conditioning": {
      "icon": "fan",
      "name": "Air conditioning",
    },
    "housekeeping": {
      "icon": "broom",
      "name": "Housekeeping",
    },
    "reception": {
      "icon": "concierge-bell",
      "name": "24hrs Reception",
    },
    "gym": {
      "icon": "gym",
      "name": "GYM",
    },
    "pet": {
      "icon": "paw",
      "name": "Pet Services",
    },
    "bar": {
      "icon": "glass-cheers",
      "name": "Bar",
    },
    "more": {
      "icon": "eye",
      "name": "see more",
    },
  };
  static const List<Map<String, String>> hotelReviewCategories = [
    {"name": "Cleanliness", "value": "cleanliness"},
    {"name": "Location", "value": "location"},
    {"name": "Facilities", "value": "facilities"},
    {"name": "Value for Money", "value": "value"},
    {"name": "Comfort", "value": "comfort"},
    {"name": "Accuracy", "value": "accuracy"},
    {"name": "Communication", "value": "communication"},
    {"name": "Free Wifi", "value": "wifi"},
  ];
  static const successMessages = [
    "Your reservation has been successfully confirmed, and we are excited to have you as our guest. Thank you.",
    "Your event booking has been successfully confirmed. We look forward to helping you create an unforgettable experience",
    "Your car rental has been successfully confirmed. We look forward to providing you with an excellent driving experience",
    "Your reservation has been successfully confirmed, and we are excited to have you as our guest. Thank you.",
    "Your boat rental has been successfully confirmed. We look forward to providing you with an excellent driving experience",
    "Your reservation has been successfully confirmed, and we are excited to have you as our guest. Thank you.",
    "Your event booking has been successfully confirmed. We look forward to helping you create an unforgettable experience",
  ];
  static const sections = [
    "Hotel",
    "Event",
    "Automobile",
    "Short-let",
    "Cruise",
    "Property",
    "Attraction",
  ];
  static const bookingStatus = [
    {"label": "Upcoming", "color": "info", "value": "0"},
    {
      "label": "Confirmed",
      "color": "success",
      "value": "1",
    },
    {
      "label": "Cancelled",
      "color": "error",
      "value": "2",
    },
    {
      "label": "Deleted",
      "color": "error",
      "value": "3",
    },
    {
      "label": "Completed",
      "color": "info",
      "value": "4",
    },
  ];
  static const walletTransactionType = [
    {
      "name": "Hotel",
      "icon": "bed",
    },
    {
      "name": "Event",
      "icon": "calendar-day",
    },
    {
      "name": "Automobile",
      "icon": "car-side",
    },
    {
      "name": "Short-let",
      "icon": "house-building",
    },
    {
      "name": "Cruise",
      "icon": "ship",
    },
    {
      "name": "Buy/Sell",
      "icon": "apartment",
    },
    {
      "name": "Attractions",
      "icon": "roller-coaster",
    },
    {"name": "Wallet Debit", "icon": "arrow-small-down"},
    {
      "name": "Wallet Credit",
      "icon": "arrow-small-up",
    },
    {
      "name": "Airtime",
      "icon": "phone-call",
    },
    {
      "name": "Data",
      "icon": "site-alt",
    },
    {
      "name": "Cable TV",
      "icon": "screen",
    },
    {
      "name": "Electricity",
      "icon": "bolt",
    },
    {
      "name": "Currency Exchange",
      "icon": "exchange-alt",
    },
  ];
  static const walletTypes = [
    {
      "name": "Nigerian Naira",
      "country": "Nigeria",
      "icon": "NGN.png",
      "value": "NGN",
      "symbol": "₦",
      "color": "rgba(48, 168, 94, 1)",
      "background": "wallet-bg.svg",
    },
    {
      "name": "US Dollar",
      "icon": "USD.png",
      "value": "USD",
      "country": "United States of America",
      "symbol": "\$",
      "color": "rgb(44, 44, 44)",
      "background": "usd-bg.png",
    },
    {
      "name": "British Pound",
      "icon": "GBP.png",
      "value": "GBP",
      "country": "United Kingdom",
      "color": "rgb(249, 121, 89)",
      "symbol": "£",
      "background": "gbp-bg.png",
    },
  ];
  static const List<Map<String, dynamic>> walletMenu = [
    {
      "title": "Bills payment",
      "items": [
        {"title": "Airtime", "icon": "signal-bars-good", "action": "airtime"},
        {"title": "Data", "icon": "mobile-button", "action": "data"},
        {"title": "Cable", "icon": "tv-retro", "action": "cable"},
        {"title": "Electricity", "icon": "lightbulb-on", "action": "power"},
      ]
    },
    {
      "title": "Get paid",
      "items": [
        {"title": "Refer", "icon": "refer-arrow", "action": "/referrals"},
        {"title": "Exchange", "icon": "exchange", "action": "exchange"},
        {"title": "Send", "icon": "angle-up", "action": "transfer"},
        {"title": "Get paid", "icon": "angle-down", "action": "deposit"},
        {"title": "Invoices", "icon": "receipt", "action": "/invoices"},
      ]
    },
    {
      "title": "Others",
      "items": [
        {"title": "Limits", "icon": "limit-speedometer", "action": "limits"},
        {
          "title": "Account\nStatement",
          "icon": "portrait",
          "action": "/account-statement"
        },
        {
          "title": "Event\nticket",
          "icon": "ticket-alt",
          "action": "/event-tickets"
        },
        {"title": "Vacation", "icon": "suitcase-alt", "action": "/vacation"},
        {"title": "Expenses", "icon": "expense-bill", "action": "/expenses"},
        {
          "title": "Transactions",
          "icon": "time-past",
          "action": "/transactions"
        },
        {"title": "Donate", "icon": "receipt", "action": "/donations"},
      ]
    },
    {
      "title": "Coming soon",
      "items": [
        {
          "title": "Betting",
          "icon": "dice-alt",
          "action": "",
          "isDisabled": true
        },
        {
          "title": "Education",
          "icon": "graduation-cap",
          "action": "",
          "isDisabled": true
        },
        {"title": "Loan", "icon": "loan", "action": "", "isDisabled": true},
        {"title": "Pay links", "icon": "link", "action": "/payment-link"},
      ]
    },
  ];
  static const businesses = [
    "hotel",
    "event",
    "automobile",
    "shortlet",
    "boat",
    "property",
    "attraction",
  ];
  static const List<Map<String, dynamic>> fabMenu = [
    {
      "title": "Bookings & Rentals",
      "items": [
        {"title": "Hotel", "icon": "bed", "action": "hotel"},
        {"title": "Short-let", "icon": "house-building", "action": "shortlet"},
        {"title": "Events", "icon": "calendar-day", "action": "event"},
        {"title": "Auto", "icon": "car-alt", "action": "automobile"},
        {"title": "Boat", "icon": "ship", "action": "boat"},
        {"title": "Buy/Sell", "icon": "shop", "action": "property"},
        {"title": "Attraction", "icon": "shop", "action": "attraction"},
      ]
    },
    {
      "title": "Bills payment",
      "items": [
        {"title": "Electricity", "icon": "lightbulb-on", "action": "power"},
        {"title": "Airtime", "icon": "signal-bars-good", "action": "airtime"},
        {"title": "Data", "icon": "mobile-button", "action": "data"},
        {"title": "Cable", "icon": "tv-retro", "action": "cable"},
      ]
    },
    {
      "title": "Payment",
      "items": [
        {"title": "Wallet", "icon": "wallet", "action": "/wallet"},
        {"title": "Invoice", "icon": "receipt", "action": "/invoice"},
        {"title": "Referral", "icon": "refer-arrow", "action": "/referrals"},
        {"title": "Pay links", "icon": "link", "action": "/payment-link"},
      ]
    }
  ];
  static const eventsCategories = [
    {
      "name": "Music",
      "value": "music",
      "icon": "music-alt",
      "subcategories": [
        "Concerts",
        "Festivals",
        "Live Bands",
        "DJ Events",
        "Open Mic Nights",
      ],
    },
    {
      "name": "Sports",
      "value": "sports",
      "icon": "volleyball",
      "subcategories": [
        "Matches and Games (e.g., Football, Basketball)",
        "Marathons and Races",
        "Fitness Classes",
        "Yoga Sessions",
        "Extreme Sports",
      ],
    },
    {
      "name": "Arts",
      "value": "arts-culture",
      "icon": "palette",
      "subcategories": [
        "Art Exhibitions",
        "Theatre and Plays",
        "Museums and Galleries",
        "Cultural Festivals",
        "Dance Performances",
      ],
    },
    {
      "name": "Food",
      "value": "food-drink",
      "icon": "plate-utensils",
      "subcategories": [
        "Food Festivals",
        "Wine Tastings",
        "Cooking Classes",
        "Brewery Tours",
        "Food Truck Rallies",
      ],
    },
    {
      "name": "Technology",
      "value": "technology",
      "icon": "artificial-intelligence",
      "subcategories": [
        "Tech Conferences",
        "Hackathons",
        "Startup Pitches",
        "Coding Bootcamps",
        "Product Launches",
      ],
    },
    {
      "name": "Education",
      "value": "education",
      "icon": "graduation-cap",
      "subcategories": [
        "Workshops",
        "Seminars",
        "Webinars",
        "Lectures",
        "Training Programs",
      ],
    },
    {
      "name": "Networking",
      "value": "networking",
      "icon": "network-user",
      "subcategories": [
        "Business Meetups",
        "Industry Conferences",
        "Career Fairs",
        "Professional Development",
        "Alumni Events",
      ],
    },
    {
      "name": "Family",
      "nameFull": "Family & Kids",
      "value": "family-kids",
      "icon": "users",
      "subcategories": [
        "Family Festivals",
        "Kids' Workshops",
        "Storytelling Sessions",
        "Amusement Park Events",
        "Family Movie Nights",
      ],
    },
    {
      "name": "Health",
      "value": "health-wellness",
      "icon": "doctor",
      "subcategories": [
        "Health Fairs",
        "Meditation Sessions",
        "Fitness Expos",
        "Wellness Retreats",
        "Nutritional Workshops",
      ],
    },
    {
      "name": "Film",
      "value": "film-media",
      "icon": "camera-movie",
      "subcategories": [
        "Film Screenings",
        "Film Festivals",
        "Media Conferences",
        "Photography Exhibitions",
        "Book Readings",
      ],
    },
    {
      "name": "Charity",
      "nameFull": "Charity & Causes",
      "value": "charity-causes",
      "icon": "hand-holding-heart",
      "subcategories": [
        "Fundraisers",
        "Charity Walks/Runs",
        "Benefit Concerts",
        "Volunteer Opportunities",
        "Awareness Campaigns",
      ],
    },
    {
      "name": "Hobbies",
      "nameFull": "Hobbies & Interests",
      "value": "hobbies-interests",
      "icon": "game",
      "subcategories": [
        "Craft Fairs",
        "Hobby Clubs (e.g., knitting, model building)",
        "Gaming Tournaments",
        "Book Clubs",
        "Gardening Workshops",
      ],
    },
    {
      "name": "Fashion",
      "value": "fashion",
      "icon": "clothes-hanger",
      "subcategories": [
        "Fashion Shows",
        "Designer Showcases",
        "Clothing Swap Meets",
        "Beauty Workshops",
        "Fashion Expos",
      ],
    },
    {
      "name": "Travel",
      "value": "travel-outdoor",
      "icon": "person-luggage",
      "subcategories": [
        "Adventure Trips",
        "Hiking Expeditions",
        "Camping Events",
        "City Tours",
        "Wildlife Safaris",
      ],
    },
    {
      "name": "Religion",
      "value": "religion-spirituality",
      "icon": "bible",
      "subcategories": [
        "Spiritual Retreats",
        "Religious Festivals",
        "Faith-Based Conferences",
        "Prayer Meetings",
        "Meditation Workshops",
      ],
    },
    {
      "name": "Government",
      "value": "government-politics",
      "icon": "auction",
      "subcategories": [
        "Political Rallies",
        "Town Hall Meetings",
        "Public Debates",
        "Policy Workshops",
        "Advocacy Events",
      ],
    },
    {
      "name": "Science",
      "value": "science-nature",
      "icon": "flask",
      "subcategories": [
        "Science Fairs",
        "Nature Walks",
        "Astronomy Nights",
        "Environmental Workshops",
        "Botanical Garden Tours",
      ],
    },
    {
      "name": "Shopping",
      "value": "shopping-markets",
      "icon": "shopping-cart",
      "subcategories": [
        "Flea Markets",
        "Farmers' Markets",
        "Craft Markets",
        "Pop-Up Shops",
        "Antique Fairs",
      ],
    },
    {
      "name": "Holiday",
      "value": "holiday-seasonal",
      "icon": "umbrella-beach",
      "subcategories": [
        "Christmas Markets",
        "Halloween Parties",
        "New Year's Eve Events",
        "Summer Festivals",
        "Easter Egg Hunts",
      ],
    },
    {
      "name": "Virtual Events",
      "value": "virtual-events",
      "icon": "live",
      "subcategories": [
        "Online Conferences",
        "Virtual Workshops",
        "Webinars",
        "Virtual Meetups",
        "Online Concerts",
      ],
    },
  ];
  static const automobileTypes = [
    {"label": "Saloon", "value": "saloon", "icon": "mdi:car-saloon"},
    {
      "label": "Hatchback",
      "value": "hatchback",
      "icon": "mdi:car-hatchback",
    },
    {
      "label": "Estate",
      "value": "estate",
      "icon": "mdi:car-estate",
    },
    {"label": "4x4", "value": "4x4", "icon": "healthicons:4x4-outline"},
    {
      "label": "MPV",
      "value": "mpv",
      "icon": "fluent:vehicle-car-profile-ltr-20-regular",
    },
    {
      "label": "Convertible",
      "value": "convertible",
      "icon": "mdi:car-convertible",
    },
    {
      "label": "Coupe",
      "value": "coupe",
      "icon": "hugeicons:car-03",
    },
    {
      "label": "City-car",
      "value": "citycar",
      "icon": "game-icons:city-car",
    },
    {
      "label": "Van or bus",
      "value": "van",
      "icon": "ph:van",
    },
    {
      "label": "Off-road",
      "value": "offroad",
      "icon": "mdi:truck-off-road",
    },
  ];
  static const automobileModels = [
    "Audi",
    "BMW",
    "Ford",
    "Jaguar",
    "Land Rover",
    "Mercedes-Benz",
    "Nissan",
    "Toyota",
    "Vauxhall",
    "Volkswagen",
    "Volvo",
    "Abarth",
    "Aixam",
    "Alfa Romeo",
    "Alpine",
    "Aston Martin",
    "Austin",
    "Bentley",
    "BMW",
    "BYD",
    "Cadillac",
    "Caterham",
    "Chevrolet",
    "Chrysler",
    "Citroen",
    "Coleman Milne",
    "Corvette",
    "Cupra",
    "Dacia",
    "Daewoo",
    "Daihatsu",
    "Dodge",
    "DS",
    "Eagle",
    "Ferrari",
    "Fiat",
    "Fisker",
    "Genesis",
    "Gwm Ora",
    "Honda",
    "Hummer",
    "Hyundai",
    "Ineos",
    "Infiniti",
    "Jaguar",
    "Jeep",
    "KGM",
    "KIA",
    "Lamborghini",
    "Land Rover",
    "Levc",
    "Lexus",
    "Lotus",
    "Marlin",
    "Maserati",
    "Mazda",
  ];
  static const automobileAmenities = [
    {
      "label": "Air conditioning",
      "value": "air-conditioning",
      "icon": "mdi:air-conditioner",
    },
    {
      "label": "GPS navigation",
      "value": "gps",
      "icon": "tdesign:gps",
    },
    {
      "label": "BT/Audio System",
      "value": "audio_systm",
      "icon": "mdi:bluetooth-audio",
    },
    {
      "label": "Child seat",
      "value": "child_seat",
      "icon": "mdi:car-child-seat"
    },
    {
      "label": "Backup camera",
      "value": "backup_camera",
      "icon": "ph:webcam-duotone",
    },
    {
      "label": "Sunroof",
      "value": "sunroof",
      "icon": "material-symbols-light:solar-power-outline",
    },
  ];
  static const automobileFuelTypes = [
    "Hybrid",
    "Full Electric",
    "Diesel",
    "Gasoline",
  ];
  static const automobileMileages = [
    "Limited",
    "Unlimited",
  ];
  static const automobileTransmission = ["Manual", "Automatic"];
  static const automobileCapacities = [
    {"label": "Two", "value": "2"},
    {"label": "Four", "value": "4"},
    {"label": "Five", "value": "5"},
    {"label": "Six", "value": "6"},
    {"label": "Eight", "value": "8"},
  ];
  static const eventTypes = [
    {
      "name": "Free Events",
      "value": "free",
    },
    {
      "name": "Paid Events",
      "value": "paid",
    },
    {
      "name": "Online Events",
      "value": "online",
    },
    {
      "name": "Offline Events",
      "value": "offline",
    },
  ];
  static const timeofDay = [
    {
      "name": "Morning",
      "value": "morning",
    },
    {
      "name": "Afternoon",
      "value": "afternoon",
    },
    {
      "name": "Evening & Night",
      "value": "night",
    },
  ];
  static const attractionCategories = [
    {
      "name": "Museum",
      "value": "museum",
      "icon": "lion-head",
      "subcategories": [],
    },
    {
      "name": "Parks",
      "value": "park",
      "icon": "castle",
      "subcategories": [],
    },
    {
      "name": "Cultural Sites",
      "value": "cultural_site",
      "icon": "landmark-alt",
      "subcategories": [],
    },
    {
      "name": "Historical Sites",
      "value": "historical_site",
      "icon": "pisa-tower",
      "subcategories": [],
    },
    {
      "name": "Amusement Parks",
      "value": "amusement_park",
      "icon": "roller-coaster",
      "subcategories": [],
    },
    {
      "name": "Wildlife",
      "value": "wildlife",
      "icon": "lion-head",
      "subcategories": [],
    },
    {
      "name": "Arts and Cultures",
      "value": "arts-culture",
      "icon": "palette",
      "subcategories": [],
    },
    {
      "name": "Food and drinks",
      "value": "food-drink",
      "icon": "plate-utensils",
      "subcategories": [],
    },
    {
      "name": "Fashion",
      "value": "fashion",
      "icon": "clothes-hanger",
      "subcategories": [],
    },
    {
      "name": "Travel & Outdoors",
      "value": "travel",
      "icon": "person-luggage",
      "subcategories": [],
    },
    {
      "name": "Science & Nature",
      "value": "science-nature",
      "icon": "microscope",
      "subcategories": [],
    },
    {
      "name": "Holiday & Seasonal",
      "value": "holiday-seasonal",
      "icon": "umbrella-beach",
      "subcategories": [],
    },
    {
      "name": "Tour",
      "value": "tour",
      "icon": "tour-guide-people",
      "subcategories": [],
    },
    {
      "name": "Music & Entertainment",
      "value": "music-entertainment",
      "icon": "music-alt",
      "subcategories": [],
    },
  ];
  static const countries = [
    {
      "name": "Nigeria",
      "dial_code": "+234",
      "code": "NG",
    },
    {
      "name": "Afghanistan",
      "dial_code": "+93",
      "code": "AF",
    },
    {
      "name": "Aland Islands",
      "dial_code": "+358",
      "code": "AX",
    },
    {
      "name": "Albania",
      "dial_code": "+355",
      "code": "AL",
    },
    {
      "name": "Algeria",
      "dial_code": "+213",
      "code": "DZ",
    },
    {
      "name": "AmericanSamoa",
      "dial_code": "+1684",
      "code": "AS",
    },
    {
      "name": "Andorra",
      "dial_code": "+376",
      "code": "AD",
    },
    {
      "name": "Angola",
      "dial_code": "+244",
      "code": "AO",
    },
    {
      "name": "Anguilla",
      "dial_code": "+1264",
      "code": "AI",
    },
    {
      "name": "Antarctica",
      "dial_code": "+672",
      "code": "AQ",
    },
    {
      "name": "Antigua and Barbuda",
      "dial_code": "+1268",
      "code": "AG",
    },
    {
      "name": "Argentina",
      "dial_code": "+54",
      "code": "AR",
    },
    {
      "name": "Armenia",
      "dial_code": "+374",
      "code": "AM",
    },
    {
      "name": "Aruba",
      "dial_code": "+297",
      "code": "AW",
    },
    {
      "name": "Australia",
      "dial_code": "+61",
      "code": "AU",
    },
    {
      "name": "Austria",
      "dial_code": "+43",
      "code": "AT",
    },
    {
      "name": "Azerbaijan",
      "dial_code": "+994",
      "code": "AZ",
    },
    {
      "name": "Bahamas",
      "dial_code": "+1242",
      "code": "BS",
    },
    {
      "name": "Bahrain",
      "dial_code": "+973",
      "code": "BH",
    },
    {
      "name": "Bangladesh",
      "dial_code": "+880",
      "code": "BD",
    },
    {
      "name": "Barbados",
      "dial_code": "+1246",
      "code": "BB",
    },
    {
      "name": "Belarus",
      "dial_code": "+375",
      "code": "BY",
    },
    {
      "name": "Belgium",
      "dial_code": "+32",
      "code": "BE",
    },
    {
      "name": "Belize",
      "dial_code": "+501",
      "code": "BZ",
    },
    {
      "name": "Benin",
      "dial_code": "+229",
      "code": "BJ",
    },
    {
      "name": "Bermuda",
      "dial_code": "+1441",
      "code": "BM",
    },
    {
      "name": "Bhutan",
      "dial_code": "+975",
      "code": "BT",
    },
    {
      "name": "Bolivia, Plurinational State of",
      "dial_code": "+591",
      "code": "BO",
    },
    {
      "name": "Bosnia and Herzegovina",
      "dial_code": "+387",
      "code": "BA",
    },
    {
      "name": "Botswana",
      "dial_code": "+267",
      "code": "BW",
    },
    {
      "name": "Brazil",
      "dial_code": "+55",
      "code": "BR",
    },
    {
      "name": "British Indian Ocean Territory",
      "dial_code": "+246",
      "code": "IO",
    },
    {
      "name": "Brunei Darussalam",
      "dial_code": "+673",
      "code": "BN",
    },
    {
      "name": "Bulgaria",
      "dial_code": "+359",
      "code": "BG",
    },
    {
      "name": "Burkina Faso",
      "dial_code": "+226",
      "code": "BF",
    },
    {
      "name": "Burundi",
      "dial_code": "+257",
      "code": "BI",
    },
    {
      "name": "Cambodia",
      "dial_code": "+855",
      "code": "KH",
    },
    {
      "name": "Cameroon",
      "dial_code": "+237",
      "code": "CM",
    },
    {
      "name": "Canada",
      "dial_code": "+1",
      "code": "CA",
    },
    {
      "name": "Cape Verde",
      "dial_code": "+238",
      "code": "CV",
    },
    {
      "name": "Cayman Islands",
      "dial_code": "+ 345",
      "code": "KY",
    },
    {
      "name": "Central African Republic",
      "dial_code": "+236",
      "code": "CF",
    },
    {
      "name": "Chad",
      "dial_code": "+235",
      "code": "TD",
    },
    {
      "name": "Chile",
      "dial_code": "+56",
      "code": "CL",
    },
    {
      "name": "China",
      "dial_code": "+86",
      "code": "CN",
    },
    {
      "name": "Christmas Island",
      "dial_code": "+61",
      "code": "CX",
    },
    {
      "name": "Cocos (Keeling) Islands",
      "dial_code": "+61",
      "code": "CC",
    },
    {
      "name": "Colombia",
      "dial_code": "+57",
      "code": "CO",
    },
    {
      "name": "Comoros",
      "dial_code": "+269",
      "code": "KM",
    },
    {
      "name": "Congo",
      "dial_code": "+242",
      "code": "CG",
    },
    {
      "name": "Congo, The Democratic Republic of the Congo",
      "dial_code": "+243",
      "code": "CD",
    },
    {
      "name": "Cook Islands",
      "dial_code": "+682",
      "code": "CK",
    },
    {
      "name": "Costa Rica",
      "dial_code": "+506",
      "code": "CR",
    },
    {
      "name": "Cote d'Ivoire",
      "dial_code": "+225",
      "code": "CI",
    },
    {
      "name": "Croatia",
      "dial_code": "+385",
      "code": "HR",
    },
    {
      "name": "Cuba",
      "dial_code": "+53",
      "code": "CU",
    },
    {
      "name": "Cyprus",
      "dial_code": "+357",
      "code": "CY",
    },
    {
      "name": "Czech Republic",
      "dial_code": "+420",
      "code": "CZ",
    },
    {
      "name": "Denmark",
      "dial_code": "+45",
      "code": "DK",
    },
    {
      "name": "Djibouti",
      "dial_code": "+253",
      "code": "DJ",
    },
    {
      "name": "Dominica",
      "dial_code": "+1767",
      "code": "DM",
    },
    {
      "name": "Dominican Republic",
      "dial_code": "+1849",
      "code": "DO",
    },
    {
      "name": "Ecuador",
      "dial_code": "+593",
      "code": "EC",
    },
    {
      "name": "Egypt",
      "dial_code": "+20",
      "code": "EG",
    },
    {
      "name": "El Salvador",
      "dial_code": "+503",
      "code": "SV",
    },
    {
      "name": "Equatorial Guinea",
      "dial_code": "+240",
      "code": "GQ",
    },
    {
      "name": "Eritrea",
      "dial_code": "+291",
      "code": "ER",
    },
    {
      "name": "Estonia",
      "dial_code": "+372",
      "code": "EE",
    },
    {
      "name": "Ethiopia",
      "dial_code": "+251",
      "code": "ET",
    },
    {
      "name": "Falkland Islands (Malvinas)",
      "dial_code": "+500",
      "code": "FK",
    },
    {
      "name": "Faroe Islands",
      "dial_code": "+298",
      "code": "FO",
    },
    {
      "name": "Fiji",
      "dial_code": "+679",
      "code": "FJ",
    },
    {
      "name": "Finland",
      "dial_code": "+358",
      "code": "FI",
    },
    {
      "name": "France",
      "dial_code": "+33",
      "code": "FR",
    },
    {
      "name": "French Guiana",
      "dial_code": "+594",
      "code": "GF",
    },
    {
      "name": "French Polynesia",
      "dial_code": "+689",
      "code": "PF",
    },
    {
      "name": "Gabon",
      "dial_code": "+241",
      "code": "GA",
    },
    {
      "name": "Gambia",
      "dial_code": "+220",
      "code": "GM",
    },
    {
      "name": "Georgia",
      "dial_code": "+995",
      "code": "GE",
    },
    {
      "name": "Germany",
      "dial_code": "+49",
      "code": "DE",
    },
    {
      "name": "Ghana",
      "dial_code": "+233",
      "code": "GH",
    },
    {
      "name": "Gibraltar",
      "dial_code": "+350",
      "code": "GI",
    },
    {
      "name": "Greece",
      "dial_code": "+30",
      "code": "GR",
    },
    {
      "name": "Greenland",
      "dial_code": "+299",
      "code": "GL",
    },
    {
      "name": "Grenada",
      "dial_code": "+1473",
      "code": "GD",
    },
    {
      "name": "Guadeloupe",
      "dial_code": "+590",
      "code": "GP",
    },
    {
      "name": "Guam",
      "dial_code": "+1671",
      "code": "GU",
    },
    {
      "name": "Guatemala",
      "dial_code": "+502",
      "code": "GT",
    },
    {
      "name": "Guernsey",
      "dial_code": "+44",
      "code": "GG",
    },
    {
      "name": "Guinea",
      "dial_code": "+224",
      "code": "GN",
    },
    {
      "name": "Guinea-Bissau",
      "dial_code": "+245",
      "code": "GW",
    },
    {
      "name": "Guyana",
      "dial_code": "+595",
      "code": "GY",
    },
    {
      "name": "Haiti",
      "dial_code": "+509",
      "code": "HT",
    },
    {
      "name": "Holy See (Vatican City State)",
      "dial_code": "+379",
      "code": "VA",
    },
    {
      "name": "Honduras",
      "dial_code": "+504",
      "code": "HN",
    },
    {
      "name": "Hong Kong",
      "dial_code": "+852",
      "code": "HK",
    },
    {
      "name": "Hungary",
      "dial_code": "+36",
      "code": "HU",
    },
    {
      "name": "Iceland",
      "dial_code": "+354",
      "code": "IS",
    },
    {
      "name": "India",
      "dial_code": "+91",
      "code": "IN",
    },
    {
      "name": "Indonesia",
      "dial_code": "+62",
      "code": "ID",
    },
    {
      "name": "Iran, Islamic Republic of Persian Gulf",
      "dial_code": "+98",
      "code": "IR",
    },
    {
      "name": "Iraq",
      "dial_code": "+964",
      "code": "IQ",
    },
    {
      "name": "Ireland",
      "dial_code": "+353",
      "code": "IE",
    },
    {
      "name": "Isle of Man",
      "dial_code": "+44",
      "code": "IM",
    },
    {
      "name": "Israel",
      "dial_code": "+972",
      "code": "IL",
    },
    {
      "name": "Italy",
      "dial_code": "+39",
      "code": "IT",
    },
    {
      "name": "Jamaica",
      "dial_code": "+1876",
      "code": "JM",
    },
    {
      "name": "Japan",
      "dial_code": "+81",
      "code": "JP",
    },
    {
      "name": "Jersey",
      "dial_code": "+44",
      "code": "JE",
    },
    {
      "name": "Jordan",
      "dial_code": "+962",
      "code": "JO",
    },
    {
      "name": "Kazakhstan",
      "dial_code": "+77",
      "code": "KZ",
    },
    {
      "name": "Kenya",
      "dial_code": "+254",
      "code": "KE",
    },
    {
      "name": "Kiribati",
      "dial_code": "+686",
      "code": "KI",
    },
    {
      "name": "Korea, Democratic People's Republic of Korea",
      "dial_code": "+850",
      "code": "KP",
    },
    {
      "name": "Korea, Republic of South Korea",
      "dial_code": "+82",
      "code": "KR",
    },
    {
      "name": "Kuwait",
      "dial_code": "+965",
      "code": "KW",
    },
    {
      "name": "Kyrgyzstan",
      "dial_code": "+996",
      "code": "KG",
    },
    {
      "name": "Laos",
      "dial_code": "+856",
      "code": "LA",
    },
    {
      "name": "Latvia",
      "dial_code": "+371",
      "code": "LV",
    },
    {
      "name": "Lebanon",
      "dial_code": "+961",
      "code": "LB",
    },
    {
      "name": "Lesotho",
      "dial_code": "+266",
      "code": "LS",
    },
    {
      "name": "Liberia",
      "dial_code": "+231",
      "code": "LR",
    },
    {
      "name": "Libyan Arab Jamahiriya",
      "dial_code": "+218",
      "code": "LY",
    },
    {
      "name": "Liechtenstein",
      "dial_code": "+423",
      "code": "LI",
    },
    {
      "name": "Lithuania",
      "dial_code": "+370",
      "code": "LT",
    },
    {
      "name": "Luxembourg",
      "dial_code": "+352",
      "code": "LU",
    },
    {
      "name": "Macao",
      "dial_code": "+853",
      "code": "MO",
    },
    {
      "name": "Macedonia",
      "dial_code": "+389",
      "code": "MK",
    },
    {
      "name": "Madagascar",
      "dial_code": "+261",
      "code": "MG",
    },
    {
      "name": "Malawi",
      "dial_code": "+265",
      "code": "MW",
    },
    {
      "name": "Malaysia",
      "dial_code": "+60",
      "code": "MY",
    },
    {
      "name": "Maldives",
      "dial_code": "+960",
      "code": "MV",
    },
    {
      "name": "Mali",
      "dial_code": "+223",
      "code": "ML",
    },
    {
      "name": "Malta",
      "dial_code": "+356",
      "code": "MT",
    },
    {
      "name": "Marshall Islands",
      "dial_code": "+692",
      "code": "MH",
    },
    {
      "name": "Martinique",
      "dial_code": "+596",
      "code": "MQ",
    },
    {
      "name": "Mauritania",
      "dial_code": "+222",
      "code": "MR",
    },
    {
      "name": "Mauritius",
      "dial_code": "+230",
      "code": "MU",
    },
    {
      "name": "Mayotte",
      "dial_code": "+262",
      "code": "YT",
    },
    {
      "name": "Mexico",
      "dial_code": "+52",
      "code": "MX",
    },
    {
      "name": "Micronesia, Federated States of Micronesia",
      "dial_code": "+691",
      "code": "FM",
    },
    {
      "name": "Moldova",
      "dial_code": "+373",
      "code": "MD",
    },
    {
      "name": "Monaco",
      "dial_code": "+377",
      "code": "MC",
    },
    {
      "name": "Mongolia",
      "dial_code": "+976",
      "code": "MN",
    },
    {
      "name": "Montenegro",
      "dial_code": "+382",
      "code": "ME",
    },
    {
      "name": "Montserrat",
      "dial_code": "+1664",
      "code": "MS",
    },
    {
      "name": "Morocco",
      "dial_code": "+212",
      "code": "MA",
    },
    {
      "name": "Mozambique",
      "dial_code": "+258",
      "code": "MZ",
    },
    {
      "name": "Myanmar",
      "dial_code": "+95",
      "code": "MM",
    },
    {
      "name": "Namibia",
      "dial_code": "+264",
      "code": "NA",
    },
    {
      "name": "Nauru",
      "dial_code": "+674",
      "code": "NR",
    },
    {
      "name": "Nepal",
      "dial_code": "+977",
      "code": "NP",
    },
    {
      "name": "Netherlands",
      "dial_code": "+31",
      "code": "NL",
    },
    {
      "name": "Netherlands Antilles",
      "dial_code": "+599",
      "code": "AN",
    },
    {
      "name": "New Caledonia",
      "dial_code": "+687",
      "code": "NC",
    },
    {
      "name": "New Zealand",
      "dial_code": "+64",
      "code": "NZ",
    },
    {
      "name": "Nicaragua",
      "dial_code": "+505",
      "code": "NI",
    },
    {
      "name": "Niger",
      "dial_code": "+227",
      "code": "NE",
    },
    {
      "name": "Niue",
      "dial_code": "+683",
      "code": "NU",
    },
    {
      "name": "Norfolk Island",
      "dial_code": "+672",
      "code": "NF",
    },
    {
      "name": "Northern Mariana Islands",
      "dial_code": "+1670",
      "code": "MP",
    },
    {
      "name": "Norway",
      "dial_code": "+47",
      "code": "NO",
    },
    {
      "name": "Oman",
      "dial_code": "+968",
      "code": "OM",
    },
    {
      "name": "Pakistan",
      "dial_code": "+92",
      "code": "PK",
    },
    {
      "name": "Palau",
      "dial_code": "+680",
      "code": "PW",
    },
    {
      "name": "Palestinian Territory, Occupied",
      "dial_code": "+970",
      "code": "PS",
    },
    {
      "name": "Panama",
      "dial_code": "+507",
      "code": "PA",
    },
    {
      "name": "Papua New Guinea",
      "dial_code": "+675",
      "code": "PG",
    },
    {
      "name": "Paraguay",
      "dial_code": "+595",
      "code": "PY",
    },
    {
      "name": "Peru",
      "dial_code": "+51",
      "code": "PE",
    },
    {
      "name": "Philippines",
      "dial_code": "+63",
      "code": "PH",
    },
    {
      "name": "Pitcairn",
      "dial_code": "+872",
      "code": "PN",
    },
    {
      "name": "Poland",
      "dial_code": "+48",
      "code": "PL",
    },
    {
      "name": "Portugal",
      "dial_code": "+351",
      "code": "PT",
    },
    {
      "name": "Puerto Rico",
      "dial_code": "+1939",
      "code": "PR",
    },
    {
      "name": "Qatar",
      "dial_code": "+974",
      "code": "QA",
    },
    {
      "name": "Romania",
      "dial_code": "+40",
      "code": "RO",
    },
    {
      "name": "Russia",
      "dial_code": "+7",
      "code": "RU",
    },
    {
      "name": "Rwanda",
      "dial_code": "+250",
      "code": "RW",
    },
    {
      "name": "Reunion",
      "dial_code": "+262",
      "code": "RE",
    },
    {
      "name": "Saint Barthelemy",
      "dial_code": "+590",
      "code": "BL",
    },
    {
      "name": "Saint Helena, Ascension and Tristan Da Cunha",
      "dial_code": "+290",
      "code": "SH",
    },
    {
      "name": "Saint Kitts and Nevis",
      "dial_code": "+1869",
      "code": "KN",
    },
    {
      "name": "Saint Lucia",
      "dial_code": "+1758",
      "code": "LC",
    },
    {
      "name": "Saint Martin",
      "dial_code": "+590",
      "code": "MF",
    },
    {
      "name": "Saint Pierre and Miquelon",
      "dial_code": "+508",
      "code": "PM",
    },
    {
      "name": "Saint Vincent and the Grenadines",
      "dial_code": "+1784",
      "code": "VC",
    },
    {
      "name": "Samoa",
      "dial_code": "+685",
      "code": "WS",
    },
    {
      "name": "San Marino",
      "dial_code": "+378",
      "code": "SM",
    },
    {
      "name": "Sao Tome and Principe",
      "dial_code": "+239",
      "code": "ST",
    },
    {
      "name": "Saudi Arabia",
      "dial_code": "+966",
      "code": "SA",
    },
    {
      "name": "Senegal",
      "dial_code": "+221",
      "code": "SN",
    },
    {
      "name": "Serbia",
      "dial_code": "+381",
      "code": "RS",
    },
    {
      "name": "Seychelles",
      "dial_code": "+248",
      "code": "SC",
    },
    {
      "name": "Sierra Leone",
      "dial_code": "+232",
      "code": "SL",
    },
    {
      "name": "Singapore",
      "dial_code": "+65",
      "code": "SG",
    },
    {
      "name": "Slovakia",
      "dial_code": "+421",
      "code": "SK",
    },
    {
      "name": "Slovenia",
      "dial_code": "+386",
      "code": "SI",
    },
    {
      "name": "Solomon Islands",
      "dial_code": "+677",
      "code": "SB",
    },
    {
      "name": "Somalia",
      "dial_code": "+252",
      "code": "SO",
    },
    {
      "name": "South Africa",
      "dial_code": "+27",
      "code": "ZA",
    },
    {
      "name": "South Sudan",
      "dial_code": "+211",
      "code": "SS",
    },
    {
      "name": "South Georgia and the South Sandwich Islands",
      "dial_code": "+500",
      "code": "GS",
    },
    {
      "name": "Spain",
      "dial_code": "+34",
      "code": "ES",
    },
    {
      "name": "Sri Lanka",
      "dial_code": "+94",
      "code": "LK",
    },
    {
      "name": "Sudan",
      "dial_code": "+249",
      "code": "SD",
    },
    {
      "name": "Suriname",
      "dial_code": "+597",
      "code": "SR",
    },
    {
      "name": "Svalbard and Jan Mayen",
      "dial_code": "+47",
      "code": "SJ",
    },
    {
      "name": "Swaziland",
      "dial_code": "+268",
      "code": "SZ",
    },
    {
      "name": "Sweden",
      "dial_code": "+46",
      "code": "SE",
    },
    {
      "name": "Switzerland",
      "dial_code": "+41",
      "code": "CH",
    },
    {
      "name": "Syrian Arab Republic",
      "dial_code": "+963",
      "code": "SY",
    },
    {
      "name": "Taiwan",
      "dial_code": "+886",
      "code": "TW",
    },
    {
      "name": "Tajikistan",
      "dial_code": "+992",
      "code": "TJ",
    },
    {
      "name": "Tanzania, United Republic of Tanzania",
      "dial_code": "+255",
      "code": "TZ",
    },
    {
      "name": "Thailand",
      "dial_code": "+66",
      "code": "TH",
    },
    {
      "name": "Timor-Leste",
      "dial_code": "+670",
      "code": "TL",
    },
    {
      "name": "Togo",
      "dial_code": "+228",
      "code": "TG",
    },
    {
      "name": "Tokelau",
      "dial_code": "+690",
      "code": "TK",
    },
    {
      "name": "Tonga",
      "dial_code": "+676",
      "code": "TO",
    },
    {
      "name": "Trinidad and Tobago",
      "dial_code": "+1868",
      "code": "TT",
    },
    {
      "name": "Tunisia",
      "dial_code": "+216",
      "code": "TN",
    },
    {
      "name": "Turkey",
      "dial_code": "+90",
      "code": "TR",
    },
    {
      "name": "Turkmenistan",
      "dial_code": "+993",
      "code": "TM",
    },
    {
      "name": "Turks and Caicos Islands",
      "dial_code": "+1649",
      "code": "TC",
    },
    {
      "name": "Tuvalu",
      "dial_code": "+688",
      "code": "TV",
    },
    {
      "name": "Uganda",
      "dial_code": "+256",
      "code": "UG",
    },
    {
      "name": "Ukraine",
      "dial_code": "+380",
      "code": "UA",
    },
    {
      "name": "United Arab Emirates",
      "dial_code": "+971",
      "code": "AE",
    },
    {
      "name": "United Kingdom",
      "dial_code": "+44",
      "code": "GB",
    },
    {
      "name": "United States",
      "dial_code": "+1",
      "code": "US",
    },
    {
      "name": "Uruguay",
      "dial_code": "+598",
      "code": "UY",
    },
    {
      "name": "Uzbekistan",
      "dial_code": "+998",
      "code": "UZ",
    },
    {
      "name": "Vanuatu",
      "dial_code": "+678",
      "code": "VU",
    },
    {
      "name": "Venezuela, Bolivarian Republic of Venezuela",
      "dial_code": "+58",
      "code": "VE",
    },
    {
      "name": "Vietnam",
      "dial_code": "+84",
      "code": "VN",
    },
    {
      "name": "Virgin Islands, British",
      "dial_code": "+1284",
      "code": "VG",
    },
    {
      "name": "Virgin Islands, U.S.",
      "dial_code": "+1340",
      "code": "VI",
    },
    {
      "name": "Wallis and Futuna",
      "dial_code": "+681",
      "code": "WF",
    },
    {
      "name": "Yemen",
      "dial_code": "+967",
      "code": "YE",
    },
    {
      "name": "Zambia",
      "dial_code": "+260",
      "code": "ZM",
    },
    {
      "name": "Zimbabwe",
      "dial_code": "+263",
      "code": "ZW",
    },
  ];
  static const boatTypes = [
    {"label": "Yacht", "value": "yacht", "icon": "sailboat"},
    {
      "label": "Sailboat",
      "value": "sailboat",
      "icon": "sailboat",
    },
    {
      "label": "Catamaran",
      "value": "catamaran",
      "icon": "sailboat",
    },
    {
      "label": "Motorboat",
      "value": "motorboat",
      "icon": "sailboat",
    },
    {
      "label": "House boat",
      "value": "houseboat",
      "icon": "sailboat",
    },
    {
      "label": "Ship",
      "value": "ship",
      "icon": "sailboat",
    },
  ];
  static const boatCategories = [
    {"label": "Birthday ", "value": "birthday"},
    {
      "label": "Corporation Events",
      "value": "corporation",
    },
    {
      "label": "Proposal",
      "value": "proposal",
    },
    {
      "label": "Live BBQ",
      "value": "bbq",
    },
    {
      "label": "Fishing",
      "value": "fishing",
    },
    {
      "label": "Luxury",
      "value": "luxury",
    },
    {
      "label": "New Year Eve",
      "value": "new-year-eve",
    },
    {
      "label": "Anniversary",
      "value": "anniversary",
    },
  ];
  static const boatUsages = [
    "Private parties",
    "Fishing trips",
    "Water skiing",
    "Weekend gateaways",
    "Events",
    "Fishing",
    "Unique experience",
    "Water-based activities",
    "Weak boat & water skis"
  ];
  static const boatEquiments = [
    "Jacuzzi",
    "Swimming Platform",
    "Water Sports Gear",
    "Fishing Equipment",
    "BBQ Grill",
    "Wakeboard",
    "Towable tube",
    "Watermark",
    "Generator",
    "Air conditioning",
    "External Speakers"
  ];
  static const states = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
  ];
  static const boatAmenities = [
    {
      "label": "One-way",
      "value": "One-way",
      "icon": "career-path",
    },
    {
      "label": "Tourist tax",
      "value": "tax",
      "icon": "tax",
    },
    {
      "label": "Starter pack",
      "value": "pack",
      "icon": "route",
    },
    {
      "label": "Sun Deck",
      "value": "sun-deck",
      "icon": "sun",
    },
    {
      "label": "Lounge Area",
      "value": "lounge",
      "icon": "carbon:drink-01",
    },
    {
      "label": "Kitchen/Galley",
      "value": "kitchen",
      "icon": "kitchen-set",
    },
    {
      "label": "Bathroom",
      "value": "bathroom",
      "icon": "bath",
    },
    {
      "label": "Entertainment",
      "value": "entertainment",
      "icon": "theater-masks",
    },
  ];
  static const propertyCategories = [
    {"name": "All Properties", "value": "", "icon": "house-key"},
    {
      "name": "Buy House",
      "value": "buy",
      "icon": "assets/images/category-buy.png"
    },
    {
      "name": "Rent House",
      "value": "rent",
      "icon": "assets/images/category-rent.png"
    },
    {
      "name": "Buy Land",
      "value": "land",
      "icon": "assets/images/category-land.png"
    }
  ];
  static const propertyTypes = [
    {"label": "House", "value": "house", "icon": "mingcute:house-2-line"},
    {
      "label": "Flat/Apartment",
      "value": "apartment",
      "icon": "material-symbols-light:apartment",
    },
    {"label": "Boathouse", "value": "boathouse", "icon": "map:boat-tour"},
    {"label": "Penthouse", "value": "penthouse", "icon": "ph:building"},
    {
      "label": "Villa",
      "value": "villa",
      "icon": "material-symbols:villa-outline"
    },
    {
      "label": "Townhouse",
      "value": "townhouse",
      "icon": "fluent:building-townhouse-32-regular",
    },
    {
      "label": "Guest house",
      "value": "guesthouse",
      "icon": "hugeicons:guest-house",
    },
    {"label": "Cabin", "value": "cabin", "icon": "material-symbols:cabin"},
    {
      "label": "Bungalow",
      "value": "bungalow",
      "icon": "material-symbols:bungalow-outline",
    },
    {"label": "Condo", "value": "condo", "icon": "bi:buildings"},
    {
      "label": "Farm house",
      "value": "farmhouse",
      "icon": "mdi:farm-home-outline"
    },
    {
      "label": "Chalet",
      "value": "chalet",
      "icon": "material-symbols:chalet-outline",
    },
    {
      "label": "Cottage",
      "value": "cottage",
      "icon": "material-symbols:cottage-outline",
    },
    {"label": "Resort", "value": "resort", "icon": "fluent-mdl2:ski-resorts"},
  ];
  static const propertyAges = [
    {
      "label": "New Build",
      "value": "new",
    },
    {
      "label": "1 - 3yr+",
      "value": "1 - 3yr+",
    },
    {
      "label": "3 - 6yr+",
      "value": "3 - 6yr+",
    },
    {
      "label": "9 - 13yr+",
      "value": "9 - 13yr+",
    },
    {
      "label": "14 - 17yr+",
      "value": "14 - 17yr+",
    },
    {
      "label": "18 - 21yr+",
      "value": "18 - 21yr+",
    },
  ];
  static const propertyRadius = [
    {
      "name": "This area only",
      "value": "0",
    },
    {
      "name": "+0.25 mile",
      "value": "0.25",
    },
    {
      "name": "+0.5 mile",
      "value": "0.5",
    },
    {
      "name": "+1 mile",
      "value": "1",
    },
    {
      "name": "+3 miles",
      "value": "3",
    },
    {
      "name": "+5 miles",
      "value": "5",
    },
    {
      "name": "+10 miles",
      "value": "10",
    },
    {
      "name": "+20 miles",
      "value": "20",
    },
    {
      "name": "+30 miles",
      "value": "30",
    },
    {
      "name": "+40 miles",
      "value": "40",
    },
    {
      "name": "+50 miles",
      "value": "50",
    },
    {
      "name": "+100 miles",
      "value": "100",
    },
  ];
  static const propertyDates = [
    {
      "name": "Anytime",
      "value": "",
    },
    {
      "name": "Last 24hrs",
      "value": "24hours",
    },
    {
      "name": "Last 3 days",
      "value": "3days",
    },
    {
      "name": "Last 7 days",
      "value": "7days",
    },
    {
      "name": "Last 14 days",
      "value": "14days",
    },
    {
      "name": "Last 30 days",
      "value": "30days",
    },
  ];
}
