import 'dart:convert';

import 'package:cribsfinder/globals/property_item.dart';
import 'package:cribsfinder/main.dart';
import 'package:cribsfinder/utils/bookings/automobile.dart';
import 'package:cribsfinder/utils/bookings/hotel.dart';
import 'package:cribsfinder/utils/bookings/property.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/markers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../utils/palette.dart';

class PropertyFilter extends StatefulWidget {
  const PropertyFilter({Key? key}) : super(key: key);

  @override
  _PropertyFilterState createState() => _PropertyFilterState();
}

class _PropertyFilterState extends State<PropertyFilter> {
  late GoogleMapController mapController;

  var selected = 0;
  Map<String, dynamic> filter = {
    "location": "Lagos",
    "minBedrooms": "0",
    "maxBedrooms": "1",
    "minBathrooms": "0",
    "maxBathrooms": "1",
    "endDate": "",
    "startTime": "",
    "endTime": "",
    "adults": "0",
    "children": "0",
    "rooms": "1",
    "radius": "",
    "categories": ["rent"],
    "facilities": [],
    "fuelTypes": [],
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
      "title": "5 Plot of land",
      "image": "assets/images/land.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/buy.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/rent.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "5 Plot of land",
      "image": "assets/images/land.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/buy.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/rent.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "5 Plot of land",
      "image": "assets/images/land.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/buy.jpg",
      "price": "384837834"
    },
    {
      "location": "Lagos",
      "title": "2 Bedroom Flat",
      "image": "assets/images/rent.jpg",
      "price": "384837834"
    },
  ];

  var total = 450;
  var neighbourhoods = [
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Surulere",
      "value": "surulere",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Abijo",
      "value": "Abijo",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Egba",
      "value": "Egba",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Ibadan",
      "value": "Ibadan",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Sangotedo",
      "value": "Sangotedo",
      "total": "1"
    },
  ];
  var brands = [
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Newmark Hotel",
      "value": "newmark",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Ikoyi Hotel",
      "value": "okoyi",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Landmark Hotel",
      "value": "landmark",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Dante Aligheri",
      "value": "Ibadan",
      "total": "1"
    },
    {
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
      "name": "Raphael Santi",
      "value": "Sangotedo",
      "total": "1"
    },
  ];
  var isMapView = false;
  final LatLng _center = const LatLng(6.5244, 3.3792);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Map<String, dynamic>> _data = [
    {
      "isPremium": 1,
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
      "ref": "43748374834",
      "dateAdded": "2025-01-01",
      "dateUpdated": "2025-02-01",
      "vendor": "Ola Alli",
      "vendorPhone": "12345678",
      "vendorEmail": "mail@mailer.com",
      "vendorPhoto": "assets/images/vendor.jpg",
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
                  Sheets.showItem(item, type: "automobile");
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
    final properties = _data
        .where((item) => filter["categories"].isNotEmpty
            ? item["type"].toString() == filter["categories"][0].toString()
            : true)
        .toList();
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
            final res = await PropertyModals.filters(
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
                  child: Widgets.buildText(
                      filter["location"] ?? "Search location", context,
                      weight: 500),
                ),
              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final res = await PropertyModals.filterOther(
                  filter, neighbourhoods, total);
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2.0,
                        children: [
                          Widgets.buildText(
                              filter["categories"]!.isNotEmpty &&
                                      filter["categories"][0].toString() ==
                                          "land"
                                  ? "Land for sale ${filter["location"].toString().isNotEmpty ? "In ${filter["location"].toString()}" : ""}"
                                  : "Properties ${filter["categories"]!.isNotEmpty ? "for ${filter["categories"].join(", ").toString().capitalize() == "Buy" ? "Sale" : "Rent"}" : ""} ${filter["location"].toString().isNotEmpty ? "In ${filter["location"].toString()}" : ""}",
                              context,
                              isMedium: true),
                          Widgets.buildText(
                              "${Helpers.formatNumber(total.toString())} Result${total > 1 ? "s" : ""} found",
                              context,
                              color: "main.primary"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.0, left: 15.0, right: 15.0),
                            child: PropertyItem(
                              item: properties[index],
                              isDetailed: true,
                            ),
                          );
                        },
                        itemCount: properties.length,
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
