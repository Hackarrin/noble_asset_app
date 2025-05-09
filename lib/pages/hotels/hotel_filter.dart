import 'dart:convert';

import 'package:afritas/globals/hotel_item.dart';
import 'package:afritas/utils/bookings/hotel.dart';
import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/markers.dart';
import 'package:afritas/utils/modals.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Map<String, dynamic> filter = {
    "location": "",
    "startDate": "",
    "endDate": "",
    "adults": "0",
    "children": "0",
    "rooms": "1",
    "duration": "0",
    "categories": [],
    "facilities": [],
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
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    },
    {
      "title": "Stanza Aragona",
      "image": "assets/images/hotels.jpeg",
      "location": "Osapa Lagos",
      "price": 39500,
      "rating": 4.9,
      "room": "Deluxe Room",
      "hotelId": "123456"
    }
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
      "title": "Stanza Aragona",
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
      "title": "Stanza Aragona",
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
      "title": "Stanza Aragona",
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
      "title": "Stanza Aragona",
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
      "title": "Stanza Aragona",
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
                  Sheets.showItem(item, type: "hotel");
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
            final res = await HotelModals.filters(
                filter, recentSearches, neighbourhoods, brands, total);
            setState(() {
              filter = res;
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
                            filter["categories"]!.isEmpty
                                ? filter["location"]!
                                : filter["categories"]!
                                    .map((category) =>
                                        category["label"].toString())
                                    .toList()
                                    .reduce(
                                        (value, element) => "$value, $element"),
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
                  filter, neighbourhoods, brands, total);
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
                            child: HotelItem(item: _data[index]),
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
