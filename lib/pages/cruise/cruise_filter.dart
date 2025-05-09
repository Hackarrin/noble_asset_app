import 'dart:convert';

import 'package:cribsfinder/globals/cruise_item.dart';
import 'package:cribsfinder/utils/bookings/cruise.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/markers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class CruiseFilter extends StatefulWidget {
  const CruiseFilter({Key? key}) : super(key: key);

  @override
  _CruiseFilterState createState() => _CruiseFilterState();
}

class _CruiseFilterState extends State<CruiseFilter> {
  late GoogleMapController mapController;

  var selected = 0;
  Map<String, dynamic> filter = {
    "location": "",
    "startDate": "",
    "endDate": "",
    "startTime": "",
    "endTime": "",
    "adults": "0",
    "children": "0",
    "rooms": "1",
    "duration": "0",
    "categories": [],
    "facilities": [],
    "occupants": 0,
    "berths": 0,
    "cabinets": 0,
    "mileages": [],
    "transmissions": [],
    "capacities": [],
    "minPrice": "10000",
    "maxPrice": "240000",
    "price": "15000",
    "property_rating": [],
    "neighbourhood": [],
    "policy": [],
    "brands": [],
    "bedroom_bathroom": {"bedroom": 0, "bathroom": 0},
    "sortBy": "relevance"
  };
  List recentSearches = [
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
    {
      "location": "Lagos",
      "date": "14 - 15 Jan",
      "duration": "7",
      "image": "assets/images/boat-1.jpeg"
    },
  ];

  var total = 450;
  var neighbourhoods = [
    {"name": "Surulere", "value": "surulere", "total": "1"},
    {"name": "Abijo", "value": "Abijo", "total": "1"},
    {"name": "Egba", "value": "Egba", "total": "1"},
    {"name": "Ibadan", "value": "Ibadan", "total": "1"},
    {"name": "Sangotedo", "value": "Sangotedo", "total": "1"},
  ];
  var brands = [
    {"name": "Newmark Hotel", "value": "newmark", "total": "1"},
    {"name": "Ikoyi Hotel", "value": "okoyi", "total": "1"},
    {"name": "Landmark Hotel", "value": "landmark", "total": "1"},
    {"name": "Dante Aligheri", "value": "Ibadan", "total": "1"},
    {"name": "Raphael Santi", "value": "Sangotedo", "total": "1"},
  ];
  var isMapView = false;
  final LatLng _center = const LatLng(6.5244, 3.3792);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Map<String, dynamic>> _data = [
    {
      "title": "Eye of the storm",
      "berths": "90m",
      "speed": "150 knots",
      "occupants": "10",
      "location": "Lekki, Lagos",
      "listedBy": "Pontoon Boats",
      "image": "assets/images/boat-1.jpeg",
      "type": "Sailboats",
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
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
      "images": ["assets/images/boat-1.jpeg", "assets/images/boat-2.jpeg"],
      "price": "90000",
      "rating": "4.9",
      "reviews": 250,
      "listingId": "687128",
      "isFavourite": 0,
    },
  ];
  Set<Marker> _markers = {};

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

            filter["categories"] = (data["categoryName"] ?? "").isEmpty
                ? []
                : [
                    {
                      "label": data["categoryName"] ?? "",
                      "value": data["categoryId"] ?? ""
                    }
                  ];
            filter["adults"] = data["guests"] ?? "1";
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
                  Sheets.showItem(item, type: "cruise");
                });
            markers.add(marker);
          }
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
            final res = await CruiseModals.filters(
                filter, recentSearches, brands, total);
            setState(() {
              filter = res;
            });
          },
          child: Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
                color: Palette.getColor(context, "background", "textfield"),
                borderRadius: BorderRadius.circular(40.0)),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
                          filter["categories"]!.isEmpty
                              ? filter["location"]!
                              : filter["categories"]!
                                  .map((category) =>
                                      category["label"].toString())
                                  .toList()
                                  .reduce(
                                      (value, element) => "$value, $element"),
                          context,
                          weight: 500),
                      FittedBox(
                        child: Widgets.buildText(
                            "${Helpers.formatDate(filter["startDate"], formatString: "EEE, dd MMM")} - ${Helpers.formatDate(filter["endDate"]!, formatString: "EEE, dd MMM")} ",
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
        actions: [
          GestureDetector(
            onTap: () async {
              final res =
                  await CruiseModals.filterOther(filter, neighbourhoods, total);
              setState(() {
                filter = res;
              });
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
        child: Container(
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
                          "${Helpers.formatNumber(total.toString())} Result${total > 1 ? "s" : ""} Found In ${filter["categories"]!.isEmpty ? filter["location"] : filter["categories"]!.map((category) => category["label"].toString()).toList().reduce((value, element) => "$value, $element")}",
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
                            child: CruiseItem(item: _data[index]),
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
                            Widgets.buildText(
                                isMapView ? "List" : "Map", context,
                                color: "text.white", isMedium: true),
                            const SizedBox(width: 10.0),
                            Helpers.fetchIcons(
                                isMapView ? "list-timeline" : "map-marker",
                                "solid",
                                size: 24,
                                color: "text.white")
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
