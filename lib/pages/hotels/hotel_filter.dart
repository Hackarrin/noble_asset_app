import 'dart:convert';

import 'package:cribsfinder/globals/automobile_item.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/globals/shortlet_item.dart';
import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/bookings/hotel.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/markers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class HotelFilter extends StatefulWidget {
  const HotelFilter({Key? key}) : super(key: key);

  @override
  _HotelFilterState createState() => _HotelFilterState();
}

class _HotelFilterState extends State<HotelFilter> {
  late GoogleMapController mapController;

  var selected = 0;
  var page = 1;
  var perPage = 10;

  Map<String, dynamic> filter = {
    "location": {},
    "checkin": "",
    "checkout": "",
    "adults": 1,
    "children": 0,
    "rooms": 1,
  };
  Map<String, dynamic> selectedFilters = {
    "categories": [],
    "price": {"min": 0, "max": 0},
    "facilities": [],
    "brands": [],
    "neighbourhood": [],
    "property_rating": [],
    "bedroom_bathroom": {"bedroom": 0, "bathroom": 0},
  };
  Map<String, dynamic> filters = {
    "categories": [],
    "price": [
      {"minPrice": 0, "maxPrice": 0}
    ],
    "facilities": [
      {"name": "Free Breakfast", "value": "breakfast"},
      {"name": "Air conditioning", "value": "ac"},
      {"name": "Pet-friendly", "value": "pet"},
    ],
    "property_rating": [
      {"name": "5 stars", "value": "5"},
      {"name": "4 stars", "value": "4"},
      {"name": "3 stars", "value": "3"},
      {"name": "2 stars", "value": "2"},
    ],
    "neighbourhood": [
      {"name": "Lagos", "value": "lagos"},
      {"name": "Abuja", "value": "abuja"},
      {"name": "Ekiti", "value": "ekiti"},
    ],
    "bedroom_bathroom": [
      {"name": "Bedroom", "value": "bedroom"},
      {"name": "Bathroom", "value": "bathroom"},
    ],
    "brands": [],
  };
  var sortBy = "relevance";
  var priceSort = "price_lh";
  var isRental = 0;
  var filterType = "hotel";

  List recentSearches = [
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    }
  ];
  var total = 0;
  var isMapView = false;
  final LatLng _center = const LatLng(6.5244, 3.3792);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<dynamic> _data = [
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "lat": 6.4429,
      "lon": 3.5148
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "lat": 6.4460,
      "lon": 3.5148
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "lat": 6.4429,
      "lon": 3.5170
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "lat": 6.4422,
      "lon": 3.5159
    },
    {
      "title": "Urban hotels",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456",
      "lat": 6.4429,
      "lon": 3.5148
    }
  ];
  Set<Marker> _markers = {};

  var loading = false;
  var error = "";

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      print(
          "dante- filter = $filter, selectedFilters = $selectedFilters, page = $page, perPage = $perPage, sortBy = $sortBy, priceSort = $priceSort, isRental = $isRental");
      final res = await JWT.filterHotels(
          filter, selectedFilters, page, perPage, sortBy, priceSort, isRental);
      print("dante - res - res");
      setState(() {
        _data = res["items"] ?? [];
        total = num.tryParse(res["total"].toString())?.toInt() ?? 0;
        error = _data.isEmpty
            ? "No ${isRental == 1 ? "rentals" : "properties"} found for your filters."
            : "";
        selectedFilters = {
          ...selectedFilters,
          "price": {
            "min": 0,
            "max": num.tryParse(res["minPrice"].toString())?.toDouble() ?? 0
          },
        };
        filters = {
          ...filters,
          "categories": res["categories"] ?? [],
          "facilities": res["facilities"] ?? [],
          "price": [
            {
              "minPrice":
                  num.tryParse(res["minPrice"].toString())?.toDouble() ?? 0,
              "maxPrice":
                  num.tryParse(res["maxPrice"].toString())?.toDouble() ?? 0,
            },
          ],
          "property_rating": res["ratings"] ?? [],
          "neighbourhood": res["neighbourhood"] ?? [],
          "brands": res["brands"] ?? [],
        };
        loading = false;
      });

      // markers
      List<Marker> markers = [];
      for (var item in _data) {
        final icon = await HotelMarker(
                text: Helpers.formatCurrency(item["price"].toString(),
                    isCompact: true))
            .toBitmapDescriptor(
                logicalSize: const Size(250, 250),
                imageSize: const Size(250, 250));
        Marker marker = Marker(
            markerId: MarkerId(item["listingId"].toString()),
            icon: icon,
            position: LatLng(
                num.tryParse(item["lat"].toString())?.toDouble() ??
                    _center.latitude,
                num.tryParse(item["lon"].toString())?.toDouble() ??
                    _center.longitude),
            onTap: () {
              Sheets.showItem(item, type: filterType);
            });
        markers.add(marker);
      }
      setState(() {
        _markers = markers.toSet();
      });
    } catch (err) {
      print(err);
      setState(() {
        error = err.toString();
        loading = false;
        total = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final data = jsonDecode(arguments.toString());
          final defaultDate = DateTime.now();
          final defaultEndDate = DateTime.now().add(Duration(days: 1));
          setState(() {
            filter["location"] = data["location"] ?? "";
            filter["startDate"] = data["startDate"] == null ||
                    data["startDate"].toString().isEmpty
                ? "${defaultDate.year}-${defaultDate.month}-${defaultDate.day}"
                : data["startDate"].toString();
            filter["endDate"] = data["endDate"] == null ||
                    data["endDate"].toString().isEmpty
                ? "${defaultEndDate.year}-${defaultEndDate.month}-${defaultEndDate.day}"
                : data["endDate"].toString();
            filter["duration"] =
                Helpers.dateDiff(filter["startDate"], filter["endDate"])
                    .toString();
            filter["adults"] = data["guests"] ?? "1";

            selectedFilters["categories"] = data.containsKey("category") &&
                    data["category"].toString().isNotEmpty
                ? [data["category"]]
                : [];
            filterType = data["type"] ?? "hotel";
            isRental =
                data.containsKey("type") && data["type"].toString() == "car"
                    ? 1
                    : 0;
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
        title: GestureDetector(
          onTap: () async {
            final res = await HotelModals.filters(
                selectedFilters, filters, total, isRental == 1);
            setState(() {
              // selectedFilters = res;
              // filter = res;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Palette.getColor(context, "background", "textfield"),
                borderRadius: BorderRadius.circular(40.0)),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: FittedBox(
              child: Row(
                children: [
                  Helpers.fetchIcons("search", "regular",
                      color: "main.primary", size: 20),
                  const SizedBox(
                    width: 10.0,
                  ),
                  FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(
                            selectedFilters["categories"].isEmpty
                                ? filter["location"]!
                                : (filters["categories"]?.length > 0
                                    ? filters["categories"]!
                                        .where((category) =>
                                            selectedFilters["categories"]!
                                                    .contains(category["value"]
                                                        .toString())
                                                ? true
                                                : false)
                                        .map((category) =>
                                            category["name"].toString())
                                        .toList()
                                        .join(", ")
                                    : ""),
                            context),
                        FittedBox(
                          child: Widgets.buildText(
                              "${Helpers.formatDistanceDate(filter["startDate"]!, filter["endDate"]!)} (${filter["duration"]} night${(num.tryParse(filter["duration"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}). ${filter["adults"]} adult${(num.tryParse(filter["adults"].toString())?.toInt() ?? 0) > 1 ? "s" : ""}",
                              context,
                              color: "text.secondary"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final res = await HotelModals.filterOther(
                  selectedFilters, filters, total, isRental == 1);
              setState(() {
                selectedFilters = res;
                sortBy = res["sortBy"] ?? "relevance";
              });
              fetch();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Palette.getColor(context, "main", "primary"),
                  borderRadius: BorderRadius.circular(25.0)),
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.only(right: 15.0),
              child: Helpers.fetchIcons("bars-filter", "regular",
                  size: 15.0, color: "background.paper"),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
        toolbarHeight: 100.0,
      ),
      body: SafeArea(
          child: loading
              ? Shimmer.fromColors(
                  baseColor: Palette.get("background.neutral"),
                  highlightColor: Palette.get("background.default"),
                  loop: 1,
                  child: AbsorbPointer(child: buildContent()))
              : (error.isNotEmpty
                  ? Alert.showErrorMessage(context, "",
                      message: error, buttonText: "Retry", action: fetch)
                  : buildContent())),
    );
  }

  Widget buildContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(bottom: 20.0, left: 0.0, right: 0.0, top: 0),
      child: Stack(
        children: [
          if (!isMapView)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Widgets.buildText(
                      "${Helpers.formatNumber(total.toString())} ${isRental == 1 ? "Rental${total > 1 ? "s" : ""}" : "Propert${total > 1 ? "ies" : "y"}"} Found",
                      context,
                      isMedium: true),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: isRental == 1
                            ? AutomobileItem(
                                item: _data[index],
                                wishlistAction: (item) {
                                  setState(() {
                                    _data = _data
                                        .map((i) => {
                                              ...i,
                                              "favourite": i["listingId"] ==
                                                      item["listingId"]
                                                  ? i["favourite"].toString() ==
                                                          "1"
                                                      ? 0
                                                      : 1
                                                  : i["favourite"]
                                            })
                                        .toList();
                                  });
                                })
                            : (filterType == "hotel"
                                ? HotelItem(
                                    item: _data[index],
                                    wishlistAction: (item) {
                                      setState(() {
                                        _data = _data
                                            .map((i) => {
                                                  ...i,
                                                  "favourite": i["listingId"] ==
                                                          item["listingId"]
                                                      ? i["favourite"]
                                                                  .toString() ==
                                                              "1"
                                                          ? 0
                                                          : 1
                                                      : i["favourite"]
                                                })
                                            .toList();
                                      });
                                    })
                                : ShortletItem(
                                    item: _data[index],
                                    wishlistAction: (item) {
                                      setState(() {
                                        _data = _data
                                            .map((i) => {
                                                  ...i,
                                                  "favourite": i["listingId"] ==
                                                          item["listingId"]
                                                      ? i["favourite"]
                                                                  .toString() ==
                                                              "1"
                                                          ? 0
                                                          : 1
                                                      : i["favourite"]
                                                })
                                            .toList();
                                      });
                                    })),
                      );
                    },
                    itemCount: _data.length,
                  ),
                ),
              ],
            ),
          if (isMapView)
            GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: _markers),
          Align(
            alignment: Alignment.bottomCenter,
            child: UnconstrainedBox(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMapView = !isMapView;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Palette.getColor(context, "main", "primary"),
                        borderRadius: BorderRadius.circular(30.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 90.0),
                    child: Row(
                      children: [
                        Widgets.buildText(isMapView ? "List" : "Map", context,
                            color: "text.white", isMedium: true),
                        const SizedBox(width: 10.0),
                        Helpers.fetchIcons(
                            isMapView ? "list-timeline" : "map-marker", "solid",
                            size: 24, color: "text.white")
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
