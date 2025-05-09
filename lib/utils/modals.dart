import 'package:cribsfinder/globals/automobile_item.dart';
import 'package:cribsfinder/globals/cruise_item.dart';
import 'package:cribsfinder/globals/event_item.dart';
import 'package:cribsfinder/globals/hotel_item.dart';
import 'package:cribsfinder/globals/shortlet_item.dart';
import 'package:cribsfinder/main.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/platform_date_picker.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shimmer/shimmer.dart';

class Sheets {
  static Future<String> selectDate(String selectedDate,
      {bool disablePast = false,
      title = "Select date",
      bool isRange = false}) async {
    if (navigatorKey.currentContext == null) {
      return "";
    }
    DateRangePickerController controller = DateRangePickerController();
    String ret = selectedDate;
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Palette.getColor(context, "background", "paper"),
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: kToolbarHeight, bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: Widgets.buildButton(context,
                                    sideColor: Palette.get("text.disabled"),
                                    radius: 60.0),
                                icon: Helpers.fetchIcons(
                                  "arrow-small-left",
                                  "regular",
                                  color: "text.disabled",
                                  size: 16.0,
                                )),
                            Expanded(
                              child: Widgets.buildText(title, context,
                                  isMedium: true, isCenter: true),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          color: Palette.get("main.primary"),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: SfDateRangePicker(
                                      backgroundColor:
                                          Palette.get("background.paper"),
                                      enablePastDates: !disablePast,
                                      initialSelectedDate: isRange
                                          ? null
                                          : ret.isNotEmpty
                                              ? Helpers.parseDate(ret)
                                              : DateTime.now(),
                                      initialSelectedDates: isRange
                                          ? ret.isNotEmpty
                                              ? ret
                                                  .toString()
                                                  .split("_")
                                                  .map((date) =>
                                                      Helpers.parseDate(date))
                                                  .toList()
                                              : [DateTime.now()]
                                          : null,
                                      selectionMode: isRange
                                          ? DateRangePickerSelectionMode.range
                                          : DateRangePickerSelectionMode.single,
                                      selectionShape:
                                          DateRangePickerSelectionShape
                                              .rectangle,
                                      enableMultiView: true,
                                      navigationDirection:
                                          DateRangePickerNavigationDirection
                                              .vertical,
                                      headerHeight: 60,
                                      controller: controller,
                                      selectionColor:
                                          Palette.get("main.primary"),
                                      todayHighlightColor: Colors.transparent,
                                      headerStyle: DateRangePickerHeaderStyle(
                                          backgroundColor:
                                              Palette.get("background.paper"),
                                          textStyle: GoogleFonts.nunito(
                                              color: Palette.get("text.black"),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      onSelectionChanged: (args) {
                                        setState(() => ret = isRange
                                            ? "${args.value.startDate.toString().split(" ")[0]}_${args.value.endDate.toString().split(" ")[0]}"
                                            : args.value
                                                .toString()
                                                .split(" ")[0]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.get("background.paper"),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x08000000),
                                          offset: Offset(1, -5),
                                          blurRadius: 4,
                                          spreadRadius: 0)
                                    ]),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                child: Row(
                                  spacing: 40.0,
                                  children: [
                                    Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: Widgets.buildButton(context,
                                                background:
                                                    Palette.get("main.primary"),
                                                vertical: 15.0,
                                                radius: 90.0,
                                                horizontal: 20.0),
                                            child: Widgets.buildText(
                                                "Continue", context,
                                                isMedium: true,
                                                color: "text.white"))),
                                    TextButton(
                                        onPressed: () {
                                          controller.selectedDate = null;
                                          setState(() => ret = "");
                                        },
                                        child: Widgets.buildText(
                                            "Clear Selection", context,
                                            isMedium: true,
                                            color: "main.primary"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
    return ret;
  }

  static Future<String> selectTime(String selectedTime,
      {bool disablePast = false,
      String title = "Select times",
      String subtitle = ""}) async {
    if (navigatorKey.currentContext == null) {
      return "";
    }
    String ret = selectedTime;
    final times = selectedTime.split("_");
    DateTime pickupTime = Helpers.parseDate("2020-01-01 ${times[0]}",
        formatString: "yyyy-MM-dd HH:mm:ss");
    DateTime dropoffTime = Helpers.parseDate(
        "2020-01-01 ${times.length > 1 ? times[1] : times[0]}",
        formatString: "yyyy-MM-dd hh:mm:ss");
    List<double> values = [
      ((pickupTime.hour * 60) + pickupTime.minute).toDouble(),
      ((dropoffTime.hour * 60) + dropoffTime.minute).toDouble()
    ];
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.get("background.paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    spacing: 5.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                              color: Color(0x66000000),
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Widgets.buildText(title, context, isMedium: true),
                      Widgets.buildText(
                          subtitle, lines: 4, color: "text.secondary", context),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        spacing: 15.0,
                        children: [
                          Widgets.buildText("Pick-up", context,
                              isMedium: true, size: 13.0),
                          Expanded(
                              child: FlutterSlider(
                            values: [values[0]],
                            max: 1440,
                            min: 0,
                            onDragging: (handlerIndex, lowerValue, upperValue) {
                              setState(() {
                                values[0] = lowerValue;
                              });
                            },
                            selectByTap: true,
                            handlerWidth: 35.0,
                            handlerHeight: 35.0,
                            step: FlutterSliderStep(step: 30),
                            handler: FlutterSliderHandler(
                                child: const SizedBox(),
                                decoration: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        color:
                                            Palette.get("background.paper")))),
                            tooltip: FlutterSliderTooltip(
                                direction: FlutterSliderTooltipDirection.top,
                                positionOffset:
                                    FlutterSliderTooltipPositionOffset(
                                        top: -20),
                                custom: (content) {
                                  return Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Palette.get(
                                                    "background.paper"),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 4),
                                                      color: Color(0x1A000000),
                                                      blurRadius: 4,
                                                      spreadRadius: 4)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 1.0),
                                            child: Column(
                                              spacing: 0.0,
                                              children: [
                                                Widgets.buildText(
                                                    Helpers.formatDateObject(
                                                        DateTime(2020, 01, 01,
                                                                0, 0, 0)
                                                            .add(Duration(
                                                                minutes: (num.tryParse(
                                                                            content.toString())
                                                                        ?.toInt() ??
                                                                    0))),
                                                        formatString: "hh:mma"),
                                                    context,
                                                    isMedium: true,
                                                    size: 14.0),
                                                Widgets.buildText(
                                                    "Pickup Time", context,
                                                    color: "text.disabeld",
                                                    size: 11.0),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 22.0,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          size: 40.0,
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Color(0x66000000),
                                                blurRadius: 5.0)
                                          ],
                                          color:
                                              Palette.get("background.paper"),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                alwaysShowTooltip: true),
                            trackBar: FlutterSliderTrackBar(
                                activeTrackBarHeight: 20.0,
                                inactiveTrackBarHeight: 20.0,
                                activeTrackBar: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(20.0)),
                                inactiveTrackBar: BoxDecoration(
                                    color: Palette.get("background.default"),
                                    borderRadius: BorderRadius.circular(20.0))),
                          ))
                        ],
                      ),
                      Row(
                        spacing: 15.0,
                        children: [
                          Widgets.buildText("Drop-off", context,
                              isMedium: true, size: 13.0),
                          Expanded(
                              child: FlutterSlider(
                            values: [values[1]],
                            max: 1440,
                            min: 0,
                            onDragging: (handlerIndex, lowerValue, upperValue) {
                              setState(() {
                                values[1] = lowerValue;
                              });
                            },
                            selectByTap: true,
                            handlerWidth: 35.0,
                            handlerHeight: 35.0,
                            step: FlutterSliderStep(step: 30),
                            handler: FlutterSliderHandler(
                                child: const SizedBox(),
                                decoration: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        color:
                                            Palette.get("background.paper")))),
                            tooltip: FlutterSliderTooltip(
                                direction: FlutterSliderTooltipDirection.top,
                                positionOffset:
                                    FlutterSliderTooltipPositionOffset(top: 43),
                                custom: (content) {
                                  return Stack(
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 22.0,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Palette.get(
                                                    "background.paper"),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 4),
                                                      color: Color(0x1A000000),
                                                      blurRadius: 4,
                                                      spreadRadius: 4)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 1.0),
                                            child: Column(
                                              spacing: 0.0,
                                              children: [
                                                Widgets.buildText(
                                                    Helpers.formatDateObject(
                                                        DateTime(2020, 01, 01,
                                                                0, 0, 0)
                                                            .add(Duration(
                                                                minutes: (num.tryParse(
                                                                            content.toString())
                                                                        ?.toInt() ??
                                                                    0))),
                                                        formatString: "hh:mma"),
                                                    context,
                                                    isMedium: true,
                                                    size: 14.0),
                                                Widgets.buildText(
                                                    "Dropoff Time", context,
                                                    color: "text.disabeld",
                                                    size: 11.0),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Icon(
                                          Icons.arrow_drop_up_rounded,
                                          size: 40.0,
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Color(0x66000000),
                                                blurRadius: 5.0)
                                          ],
                                          color:
                                              Palette.get("background.paper"),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                alwaysShowTooltip: true),
                            trackBar: FlutterSliderTrackBar(
                                activeTrackBarHeight: 20.0,
                                inactiveTrackBarHeight: 20.0,
                                activeTrackBar: BoxDecoration(
                                    color: Palette.get("main.primary"),
                                    borderRadius: BorderRadius.circular(20.0)),
                                inactiveTrackBar: BoxDecoration(
                                    color: Palette.get("background.default"),
                                    borderRadius: BorderRadius.circular(20.0))),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              final startTime = DateTime(2020, 1, 1)
                                  .add(Duration(minutes: values[0].toInt()));
                              final endTime = DateTime(2020, 1, 1)
                                  .add(Duration(minutes: values[1].toInt()));
                              ret =
                                  "${Helpers.formatDateObject(startTime, formatString: "HH:mm:ss")}_${Helpers.formatDateObject(endTime, formatString: "HH:mm:ss")}";
                              Navigator.pop(context);
                            },
                            style: Widgets.buildButton(context,
                                background: Palette.get("main.primary"),
                                vertical: 20.0,
                                radius: 50.0),
                            child: Widgets.buildText("Select time", context,
                                isMedium: true, color: "text.white")),
                      )
                    ],
                  ),
                )
              ],
            );
          });
        });
    return ret;
  }

  static Future<dynamic> showItem(item, {type = "hotel"}) async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                if (type == "hotel")
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: HotelItem(
                        item: item,
                        close: () {
                          Navigator.pop(context);
                        }),
                  ),
                if (type == "shortlet")
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: ShortletItem(
                        item: item,
                        close: () {
                          Navigator.pop(context);
                        }),
                  ),
                if (type == "event")
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 50.0),
                    child: EventItem(item: item, direction: "horizontal"),
                  ),
                if (type == "automobile")
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 30.0),
                    child: AutomobileItem(
                        item: item,
                        close: () {
                          Navigator.pop(context);
                        }),
                  ),
                if (type == "cruise")
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 30.0),
                    child: CruiseItem(
                        item: item,
                        close: () {
                          Navigator.pop(context);
                        }),
                  )
              ],
            );
          });
        });
  }

  static Future<String> showSortBy(String item,
      {List items = Defaults.sorts,
      String title = "Sort by",
      bool isShowClear = true,
      bool isShowIcon = false,
      bool isCurrency = false}) async {
    var res = item;
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText(title, context, isMedium: true),
                      if (isCurrency)
                        Widgets.buildText(
                            "Choose the currency you would like to view transaction details for",
                            context,
                            lines: 4,
                            size: 12.0),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (!isCurrency) const Divider(color: Color(0x14000000)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                isShowIcon || isCurrency ? 300.0 : 200.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final sort = items[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    res = sort.containsKey("value")
                                        ? sort["value"].toString()
                                        : index.toString();
                                  });
                                  if (isCurrency) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  decoration: isShowIcon || isCurrency
                                      ? BoxDecoration(
                                          color:
                                              Palette.get("background.paper"),
                                          borderRadius:
                                              BorderRadius.circular(10.0))
                                      : null,
                                  padding: EdgeInsets.symmetric(
                                      vertical: isShowIcon || isCurrency
                                          ? 20.0
                                          : 10.0,
                                      horizontal: isShowIcon || isCurrency
                                          ? 15.0
                                          : 0.0),
                                  margin: isShowIcon || isCurrency
                                      ? const EdgeInsets.only(bottom: 10.0)
                                      : null,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          if (isShowIcon)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Helpers.fetchIcons(
                                                  sort["icon"].toString(),
                                                  "regular",
                                                  color: "main.primary",
                                                  size: 16.0),
                                            ),
                                          if (isCurrency)
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ClipOval(
                                                    child: Image.asset(
                                                  "assets/images/${sort["icon"]}",
                                                  height: 40.0,
                                                  width: 40.0,
                                                  fit: BoxFit.cover,
                                                ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  sort["name"].toString(),
                                                  context,
                                                  weight: 500,
                                                  color: isCurrency
                                                      ? "text.primary"
                                                      : "text.secondary"),
                                              if (isCurrency)
                                                Widgets.buildText(
                                                    sort["value"].toString(),
                                                    context,
                                                    weight: 500,
                                                    size: 10.0,
                                                    color: "text.disabled"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (isCurrency)
                                        Widgets.buildText(
                                            Helpers.formatCurrency(
                                                sort["balance"].toString(),
                                                currency:
                                                    sort["value"].toString()),
                                            context,
                                            isMedium: true,
                                            size: 13.0),
                                      if (!isCurrency)
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: res ==
                                                          (sort.containsKey("value")
                                                              ? sort["value"]
                                                                  .toString()
                                                              : index
                                                                  .toString())
                                                      ? Palette.getColor(
                                                          context, "main", "primary")
                                                      : Palette.getColor(
                                                          context,
                                                          "text",
                                                          "primary")),
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              color: res ==
                                                      (sort.containsKey("value")
                                                          ? sort["value"].toString()
                                                          : index.toString())
                                                  ? Palette.getColor(context, "main", "primary")
                                                  : Colors.transparent),
                                          child: const SizedBox(
                                              width: 14, height: 14),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: items.length),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (!isCurrency) const Divider(color: Color(0x14000000)),
                      if (!isCurrency)
                        const SizedBox(
                          height: 10.0,
                        ),
                      if (!isCurrency)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 0.0),
                          child: Row(
                            children: [
                              if (isShowClear)
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          res = "";
                                        });
                                      },
                                      child: Widgets.buildText(
                                          "Clear all", context,
                                          color: "text.secondary",
                                          isMedium: true)),
                                ),
                              if (isShowClear)
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: Widgets.buildButton(context,
                                        background: Palette.getColor(
                                            context, "main", "primary"),
                                        vertical: 15.0,
                                        horizontal: 40.0,
                                        radius: 45.0),
                                    child: Widgets.buildText("Apply", context,
                                        isMedium: true, color: "text.white")),
                              if (!isShowClear)
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: Widgets.buildButton(context,
                                          background: Palette.getColor(
                                              context, "main", "primary"),
                                          vertical: 15.0,
                                          horizontal: 40.0,
                                          radius: 45.0),
                                      child: Widgets.buildText("Apply", context,
                                          isMedium: true, color: "text.white")),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                )
              ],
            );
          });
        });
    return res;
  }

  static Future<String> showWallets(List items,
      {final String title = "Send money from",
      String subtitle = "Select the currency you would like to transfer from",
      bool isShowAdd = false}) async {
    var res = "";
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 60.0,
                          height: 4.0,
                          decoration: BoxDecoration(
                              color: Color(0x66000000),
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Widgets.buildText(title, context, isMedium: true),
                      Widgets.buildText(subtitle, context,
                          lines: 4, size: 12.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (items.length == index) {
                                // add
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, "/add-wallet-account");
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10.0),
                                        color: Palette.get("main.primary"),
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0x3341B11A),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(
                                                          "background.paper"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Helpers.fetchIcons(
                                                      "plus-small", "solid",
                                                      color: "main.primary",
                                                      size: 16.0)),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Widgets.buildText(
                                                  "Tap to add account", context,
                                                  weight: 500, size: 13.0)
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              }
                              final sort = items[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    res = sort["value"].toString();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.get("background.paper"),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 15.0),
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ClipOval(
                                                  child: Image.asset(
                                                "assets/images/${sort["icon"]}",
                                                height: 40.0,
                                                width: 40.0,
                                                fit: BoxFit.cover,
                                              ))),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Widgets.buildText(
                                                  sort["name"].toString(),
                                                  context,
                                                  weight: 500,
                                                  color: "text.primary"),
                                              Widgets.buildText(
                                                  sort["value"].toString(),
                                                  context,
                                                  weight: 500,
                                                  size: 10.0,
                                                  color: "text.disabled"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Widgets.buildText(
                                          Helpers.formatCurrency(
                                              sort["balance"].toString(),
                                              currency:
                                                  sort["value"].toString()),
                                          context,
                                          isMedium: true,
                                          size: 13.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: items.length + (isShowAdd ? 1 : 0)),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
    return res;
  }

  static Future<bool> showVerifyTransfer(Map<String, dynamic> account,
      String balance, String currency, String amount, String fee) async {
    var res = false;
    final wallet = Defaults.walletTypes
        .firstWhere((type) => type["value"].toString() == currency);
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "default"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Widgets.buildText(
                            Helpers.formatCurrency(amount, currency: currency),
                            context,
                            isMedium: true,
                            isCenter: true),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Widgets.buildText("Bank", context,
                              color: "text.disabled"),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText(
                              account["bank"]["name"].toString(), context),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Widgets.buildText("Account Number", context,
                              color: "text.disabled"),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText(
                              account["accountNumber"].toString(), context),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Widgets.buildText("Name", context,
                              color: "text.disabled"),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText(
                              account["accountName"].toString(), context),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Widgets.buildText("Amount", context,
                              color: "text.disabled"),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText(
                              Helpers.formatCurrency(amount,
                                  currency: currency),
                              context),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Widgets.buildText("Transaction Fee", context,
                              color: "text.disabled"),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Widgets.buildText(
                              Helpers.formatCurrency(fee, currency: currency),
                              context),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Widgets.buildText("Payment Method", context, size: 16.0),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Palette.get("background.paper"),
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ClipOval(
                                        child: Image.asset(
                                      "assets/images/${wallet["icon"]}",
                                      height: 40.0,
                                      width: 40.0,
                                      fit: BoxFit.cover,
                                    ))),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText(
                                        wallet["name"].toString(), context,
                                        weight: 500, color: "text.primary"),
                                    Widgets.buildText(
                                        wallet["value"].toString(), context,
                                        weight: 500,
                                        size: 10.0,
                                        color: "text.disabled"),
                                  ],
                                ),
                              ],
                            ),
                            Widgets.buildText(
                                Helpers.formatCurrency(balance,
                                    currency: currency),
                                context,
                                isMedium: true,
                                size: 13.0),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                setState(() => res = true);
                                Navigator.pop(context);
                              },
                              style: Widgets.buildButton(context,
                                  background: Palette.getColor(
                                      context, "main", "primary"),
                                  vertical: 15.0,
                                  horizontal: 40.0,
                                  radius: 45.0),
                              child: Widgets.buildText("Send", context,
                                  isMedium: true, color: "text.white")),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          });
        });
    return res;
  }

  static Future<String> showPINVerify() async {
    var res = "";
    final pinController = TextEditingController();
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          final screenWidth = MediaQuery.sizeOf(context).width;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Widgets.buildText("Enter Payment PIN", context,
                            isMedium: true, isCenter: true),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      PinCodeTextField(
                          autofocus: true,
                          highlight: true,
                          pinBoxColor: Palette.getColor(
                              context, "background", "default"),
                          pinBoxRadius: 10.0,
                          controller: pinController,
                          defaultBorderColor: Colors.transparent,
                          hasTextBorderColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hideDefaultKeyboard: true,
                          keyboardType: TextInputType.none,
                          maxLength: 4,
                          pinBoxWidth: 50.0,
                          pinBoxHeight: 50.0,
                          wrapAlignment: WrapAlignment.center,
                          pinTextStyle: GoogleFonts.nunito(
                              fontSize: 14.0,
                              color: Palette.getColor(
                                  context, "text", "secondary"))),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {},
                            child: Widgets.buildText(
                                "Forgot Payment PIN?", context,
                                color: "text.secondary", isCenter: true)),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i = 0; i < 10; i += 1)
                            SizedBox(
                              width: ((screenWidth - 70.0) / 3.0) *
                                  (i + 1 == 10 ? 2 : 1),
                              child: TextButton(
                                  onPressed: () {
                                    pinController.text =
                                        "${pinController.text}${i + 1 == 10 ? 0 : i + 1}";
                                    if (pinController.text.length == 4) {
                                      res = pinController.text;
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: Widgets.buildButton(context,
                                      background:
                                          Palette.get("background.default"),
                                      radius: 10.0,
                                      vertical: 15.0),
                                  child: Widgets.buildText(
                                      "${i + 1 == 10 ? 0 : i + 1}", context,
                                      isMedium: true)),
                            ),
                          SizedBox(
                            width: ((screenWidth - 70.0) / 3.0),
                            child: TextButton(
                                onPressed: () {
                                  pinController.text = "";
                                  res = "";
                                  Navigator.pop(context);
                                },
                                style: Widgets.buildButton(context,
                                    background:
                                        Palette.get("background.default"),
                                    radius: 10.0,
                                    vertical: 15.0),
                                child: Widgets.buildText("Cancel", context,
                                    isMedium: true)),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
    return res;
  }

  static void forgotPin() async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.buildText("Forgot transaction PIN", context,
                          isMedium: true),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(color: Color(0x14000000)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Image.asset("assets/images/exclamation.png",
                            height: 100.0, fit: BoxFit.contain),
                      ),
                      const SizedBox(
                        height: 60.0,
                      ),
                      Widgets.buildText(
                          "Did you forget your PIN? We will send a one-time password (OTP) to your email to verify your identity before making this change.",
                          context,
                          lines: 10,
                          isCenter: true,
                          color: "text.secondary"),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: Widgets.buildButton(context,
                                background: Palette.getColor(
                                    context, "main", "primary"),
                                vertical: 15.0,
                                horizontal: 40.0,
                                radius: 45.0),
                            child: Widgets.buildText(
                                "Yes, send me an OTP", context,
                                isMedium: true, color: "text.white")),
                      )
                    ],
                  ),
                )
              ],
            );
          });
        });
  }

  static void showImagePreview(List images, String title) async {
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      padding: EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                          top: kToolbarHeight,
                          bottom: 90.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: Widgets.buildButton(context,
                                        sideColor: Palette.get("text.disabled"),
                                        radius: 60.0,
                                        background: Color(0x80FFFFFF)),
                                    icon: Helpers.fetchIcons(
                                      "arrow-small-left",
                                      "regular",
                                      color: "text.white",
                                      size: 16.0,
                                    )),
                                Expanded(
                                  child: Widgets.buildText(title, context,
                                      isMedium: true,
                                      isCenter: true,
                                      color: "text.white"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: Container(
                                child: PhotoViewGallery.builder(
                              scrollPhysics: const BouncingScrollPhysics(),
                              builder: (BuildContext context, int index) {
                                return PhotoViewGalleryPageOptions(
                                  imageProvider: AssetImage(images[index]),
                                  initialScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                  heroAttributes: PhotoViewHeroAttributes(
                                      tag: images[index].toString()),
                                );
                              },
                              itemCount: images.length,
                              loadingBuilder: (context, event) => Center(
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    value: event == null
                                        ? 0
                                        : (event.expectedTotalBytes == null
                                            ? 0
                                            : event.cumulativeBytesLoaded /
                                                event.expectedTotalBytes!),
                                  ),
                                ),
                              ),
                              backgroundDecoration: BoxDecoration(),
                            )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  static Future<dynamic> showOptions(String title, String subtitle, List items,
      {bool isSearch = false, bool isCustomBackground = false}) async {
    if (navigatorKey.currentContext == null) {
      return;
    }
    var search = TextEditingController();
    dynamic selected = "";

    Future<List> get() async {
      try {
        final values = items;
        if (values.isEmpty) {
          if (search.text.isNotEmpty) {
            return Future.error(
                "No ${search.text.toLowerCase()} matches your search.");
          }
        }
        return search.text.isEmpty
            ? values
            : values
                .where((item) => item["name"]
                    .toString()
                    .toLowerCase()
                    .contains(search.text.toLowerCase()))
                .toList();
      } catch (e) {
        return Future.error("Something went wrong! Please try again later.");
      }
    }

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.getColor(context, "background",
                      isCustomBackground ? "default" : "paper"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: isCustomBackground ? 15.0 : 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Widgets.buildText(title, context, isMedium: true),
                    const SizedBox(height: 8.0),
                    if (subtitle.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Widgets.buildText(subtitle, context,
                            color: "text.secondary", lines: 10),
                      ),
                    const SizedBox(height: 10.0),
                    if (!isCustomBackground)
                      const Divider(color: Color(0x14000000)),
                    if (!isCustomBackground) const SizedBox(height: 10.0),
                    (isSearch
                        ? TextFormField(
                            controller: search,
                            style: GoogleFonts.workSans(),
                            decoration: InputDecoration(
                                labelStyle: GoogleFonts.workSans(),
                                hintStyle: GoogleFonts.workSans(),
                                helperStyle: GoogleFonts.workSans(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFC2C7D6)),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFC2C7D6)),
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: "Search",
                                contentPadding: const EdgeInsets.fromLTRB(
                                    15.0, 10.0, 15.0, 10.0),
                                //hintText: hint,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (_search) => {
                              {setState(() => search.text = _search)}
                            },
                          )
                        : const SizedBox(height: 1)),
                    SizedBox(height: isSearch ? 15 : 1.0),
                    Container(
                        color: Palette.getColor(context, "background",
                            isCustomBackground ? "default" : "paper"),
                        padding: EdgeInsets.symmetric(
                            horizontal: isCustomBackground ? 0 : 5,
                            vertical: 5),
                        child: FutureBuilder<List<dynamic>>(
                          future: get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Widgets.buildText(
                                    snapshot.error.toString(), context,
                                    color: "main.error");
                              } else if (snapshot.hasData) {
                                return Container(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          isCustomBackground ? 300 : 200),
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: (snapshot.data ?? []).length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item = snapshot.data![index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: isCustomBackground
                                                    ? 15.0
                                                    : 0.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() => selected = item);
                                                Navigator.pop(context, true);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal:
                                                        isCustomBackground
                                                            ? 10.0
                                                            : 0.0),
                                                decoration: BoxDecoration(
                                                  color: Palette.getColor(
                                                      context,
                                                      "background",
                                                      "paper"),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (item.runtimeType !=
                                                            String &&
                                                        item.containsKey(
                                                            "icon"))
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10.0),
                                                        child: Helpers.fetchIcons(
                                                            item["icon"],
                                                            "regular",
                                                            size: 25.0,
                                                            color:
                                                                "main.primary"),
                                                      ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Widgets.buildText(
                                                            item.runtimeType ==
                                                                    String
                                                                ? item
                                                                : item["name"]
                                                                    .toString(),
                                                            context,
                                                            size: 15.0,
                                                            weight: 500,
                                                          ),
                                                          if (item.runtimeType !=
                                                                  String &&
                                                              item.containsKey(
                                                                  "subtitle"))
                                                            Widgets.buildText(
                                                                item["subtitle"]
                                                                    .toString(),
                                                                context,
                                                                size: 13.0,
                                                                color:
                                                                    "text.secondary"),
                                                        ],
                                                      ),
                                                    ),
                                                    if (item.runtimeType !=
                                                            String &&
                                                        item.containsKey(
                                                            "icon"))
                                                      Helpers.fetchIcons(
                                                          "caret-right",
                                                          "solid",
                                                          size: 25.0),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              } else {
                                return const Text("Error occurred!");
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                  enabled: true,
                                  highlightColor: Palette.getColor(
                                      context, "background", "skeleton"),
                                  baseColor: Palette.getColor(
                                      context, "background", "default"),
                                  period: const Duration(milliseconds: 1000),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TextButton(
                                          onPressed: () => {},
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              color: Palette.getColor(context,
                                                  "background", "paper"),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ),
                                            child: Widgets.buildText(
                                                "", context,
                                                size: 16.0, isCenter: true),
                                          ),
                                        );
                                      }));
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          },
                        )),
                    if (!isCustomBackground) const SizedBox(height: 15),
                    if (!isCustomBackground)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Widgets.buildText("Cancel", context,
                                color: "text.disabled", isMedium: true),
                          )),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          });
        });
    return selected;
  }

  static Future<String> showWalletMenu() async {
    if (navigatorKey.currentContext == null) {
      return "";
    }
    bool isEdit = false;
    String selectedPref = await Helpers.readPref(Defaults.quickAccess);
    List selected =
        (selectedPref.isEmpty ? Defaults.defaultQuickAccess : selectedPref)
            .split(",");
    final mergedList = [];
    for (var list
        in Defaults.walletMenu.map((item) => item["items"]).toList()) {
      mergedList.addAll(list.where((item) => !(item["isDisabled"] ?? false)));
    }
    Map<String, dynamic> quickAccess = {
      "title": "",
      "items": mergedList
          .where((item) => selected.contains(item["action"].toString()))
          .toList()
    };
    String res = "";

    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          final screenWidth = MediaQuery.sizeOf(context).width;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.getColor(context, "background", "paper"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Widgets.buildText("Wallet menu", context,
                            isMedium: true),
                        TextButton(
                            onPressed: () {
                              setState(() => isEdit = !isEdit);
                            },
                            child: Widgets.buildText(
                                !isEdit ? "Edit" : "Cancel", context,
                                color: "main.primary"))
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    if (isEdit)
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Widgets.buildText(
                            "Customize your Quick Access by selecting up to three options for a more convenient and efficient experience.",
                            context,
                            color: "text.secondary",
                            lines: 10),
                      ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 300.0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final section = isEdit
                              ? {}
                              : [quickAccess, ...Defaults.walletMenu][index];
                          final List items =
                              isEdit ? mergedList : section["items"] ?? [];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (section["title"].toString().isNotEmpty &&
                                    !isEdit)
                                  Widgets.buildText(
                                      section["title"].toString(), context,
                                      weight: 500, size: 14.0),
                                if (section["title"].toString().isNotEmpty &&
                                    !isEdit)
                                  const SizedBox(height: 15.0),
                                Wrap(
                                  spacing: 15.0,
                                  runSpacing: 25.0,
                                  children: [
                                    for (var i = 0; i < items.length; i += 1)
                                      SizedBox(
                                        width: (screenWidth - 110) / 4,
                                        child: Center(
                                          child: Opacity(
                                            opacity: (items[i]["isDisabled"] ??
                                                    false)
                                                ? 0.5
                                                : 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (isEdit) {
                                                  if (selected.length == 3) {
                                                    selected = [];
                                                  }
                                                  setState(() {
                                                    if (selected.contains(
                                                        items[i]["action"]
                                                            .toString())) {
                                                      selected.remove(items[i]
                                                              ["action"]
                                                          .toString());
                                                    } else {
                                                      selected = [
                                                        ...selected,
                                                        items[i]["action"]
                                                            .toString()
                                                      ];
                                                    }
                                                  });
                                                  Helpers.writePref(
                                                      Defaults.quickAccess,
                                                      selected.join(","));
                                                } else {
                                                  res = items[i]["action"]
                                                      .toString();
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          width: 55,
                                                          height: 55,
                                                          decoration: BoxDecoration(
                                                              color: Palette.get(
                                                                  "background.paper"),
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Palette
                                                                          .get(
                                                                              "main.primary"))),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                    blurRadius:
                                                                        4.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    color: Color(
                                                                        0x0D000000))
                                                              ]),
                                                          child:
                                                              UnconstrainedBox(
                                                            child: Helpers
                                                                .fetchIcons(
                                                                    items[i][
                                                                        "icon"],
                                                                    "regular",
                                                                    size: 24.0,
                                                                    color:
                                                                        "main.primary"),
                                                          )),
                                                      if (isEdit &&
                                                          selected.contains(
                                                              items[i]['action']
                                                                  .toString()))
                                                        Positioned(
                                                          top: 0.0,
                                                          right: 0.0,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Palette.get(
                                                                    "main.primary"),
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0))),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        2.0,
                                                                    horizontal:
                                                                        7.0),
                                                            child: Widgets.buildText(
                                                                (selected.indexOf(items[i]['action']
                                                                            .toString()) +
                                                                        1)
                                                                    .toString(),
                                                                context,
                                                                color:
                                                                    "text.white",
                                                                isMedium: true,
                                                                size: 11.0),
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  FittedBox(
                                                    child: Widgets.buildText(
                                                        items[i]["title"],
                                                        context,
                                                        weight: 500,
                                                        isCenter: true),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: isEdit ? 1 : Defaults.walletMenu.length + 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          });
        });
    return res;
  }

  static Future<Map<String, dynamic>> showExchangeRates(
      Map<String, dynamic> rates) async {
    final items = {"NGN": [], "USD": [], "GBP": []};
    items["NGN"] = [
      {"from": "NGN", "to": "USD", "rate": rates["NGN_USD_rate"]},
      {"from": "NGN", "to": "GBP", "rate": rates["NGN_GBP_rate"]}
    ];
    items["USD"] = [
      {"from": "USD", "to": "NGN", "rate": rates["USD_NGN_rate"]},
      {"from": "USD", "to": "GBP", "rate": rates["USD_GBP_rate"]}
    ];
    items["GBP"] = [
      {"from": "GBP", "to": "NGN", "rate": rates["GBP_NGN_rate"]},
      {"from": "GBP", "to": "USD", "rate": rates["GBP_USD_rate"]}
    ];
    Map<String, dynamic> res = {};
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Palette.getColor(context, "background", "paper"),
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.only(
                      left: 0.0, right: 0.0, top: kToolbarHeight, bottom: 90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: Widgets.buildButton(context,
                                    sideColor: Palette.get("text.disabled"),
                                    radius: 60.0),
                                icon: Helpers.fetchIcons(
                                  "arrow-small-left",
                                  "regular",
                                  color: "text.disabled",
                                  size: 16.0,
                                )),
                            Expanded(
                              child: Widgets.buildText(
                                  "Exchange Rates", context,
                                  isMedium: true, isCenter: true),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          color: Palette.get("background.paper"),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (final currency in items.keys)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Widgets.buildText(
                                            currency, context,
                                            isMedium: true),
                                      ),
                                      const SizedBox(height: 15.0),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final item =
                                                items[currency]![index];
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: index == 0
                                                      ? Color(0x0D41B11A)
                                                      : Colors.transparent),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              margin: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipOval(
                                                          child: Image.asset(
                                                              "assets/images/${Defaults.walletTypes.firstWhere((type) => type["value"] == item["from"])["icon"]}",
                                                              width: 30,
                                                              height: 30,
                                                              fit: BoxFit
                                                                  .cover)),
                                                      const SizedBox(
                                                          width: 5.0),
                                                      Widgets.buildText(
                                                          item["from"], context,
                                                          color:
                                                              "text.secondary"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Helpers.fetchIcons(
                                                          "arrow-small-right",
                                                          "solid",
                                                          size: 16.0,
                                                          color:
                                                              "text.disabled"),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      ClipOval(
                                                          child: Image.asset(
                                                              "assets/images/${Defaults.walletTypes.firstWhere((type) => type["value"] == item["to"])["icon"]}",
                                                              width: 30,
                                                              height: 30,
                                                              fit: BoxFit
                                                                  .cover)),
                                                      const SizedBox(
                                                          width: 5.0),
                                                      Widgets.buildText(
                                                          item["to"], context,
                                                          color:
                                                              "text.secondary"),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Widgets.buildText(
                                                      Helpers.formatNumber(
                                                          item["rate"]),
                                                      context,
                                                      isMedium: true,
                                                      color: "text.secondary"),
                                                  const SizedBox(width: 10.0),
                                                  TextButton(
                                                      onPressed: () {
                                                        res = item;
                                                        Navigator.pop(context);
                                                      },
                                                      style:
                                                          Widgets.buildButton(
                                                              context,
                                                              horizontal: 15.0,
                                                              vertical: 5.0,
                                                              radius: 60.0,
                                                              background: Color(
                                                                  0xFF403C3C)),
                                                      child: Widgets.buildText(
                                                          "Send ${item["to"]}",
                                                          context,
                                                          color: "text.white"))
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount:
                                              items[currency]?.length ?? 0),
                                      const SizedBox(height: 15.0),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
    return res;
  }

  static Future<String> showFabMenu({String selected = ""}) async {
    if (navigatorKey.currentContext == null) {
      return "";
    }
    String res = "";

    await showModalBottomSheet(
        elevation: 1,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (context) {
          final screenWidth = MediaQuery.sizeOf(context).width;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 42.0, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.getColor(context, "background", "paper"),
                        borderRadius: BorderRadius.circular(16.0)),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    child: SizedBox(
                      height: 500.0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final section = Defaults.fabMenu[index];
                          final List items = section["items"] ?? [];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: index + 1 == Defaults.fabMenu.length
                                    ? 0
                                    : 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (section["title"].toString().isNotEmpty)
                                  Widgets.buildText(
                                      section["title"].toString(), context,
                                      isMedium: true),
                                if (section["title"].toString().isNotEmpty)
                                  const SizedBox(height: 15.0),
                                Wrap(
                                  spacing: 15.0,
                                  runSpacing: 25.0,
                                  children: [
                                    for (var i = 0; i < items.length; i += 1)
                                      SizedBox(
                                        width: (screenWidth - 150) / 4,
                                        child: Center(
                                          child: Opacity(
                                            opacity: (items[i]["isDisabled"] ??
                                                    false)
                                                ? 0.5
                                                : 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                res = items[i]["action"]
                                                    .toString();
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              color: Palette.get(selected ==
                                                                      items[i]["action"]
                                                                          .toString()
                                                                  ? "main.primary"
                                                                  : "background.paper"),
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Palette.get(
                                                                          "main.primary"))),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            1),
                                                                    blurRadius:
                                                                        4.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    color: Color(
                                                                        0x0D000000))
                                                              ]),
                                                          child:
                                                              UnconstrainedBox(
                                                            child: Helpers.fetchIcons(
                                                                items[i]
                                                                    ["icon"],
                                                                "regular",
                                                                size: 24.0,
                                                                color: selected ==
                                                                        items[i]["action"]
                                                                            .toString()
                                                                    ? "text.white"
                                                                    : "main.primary"),
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  FittedBox(
                                                    child: Widgets.buildText(
                                                        items[i]["title"],
                                                        context,
                                                        weight: 500,
                                                        isCenter: true),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: Defaults.fabMenu.length,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: Widgets.buildButton(context,
                            background: Palette.get("background.paper"),
                            vertical: 20.0,
                            horizontal: 20.0,
                            radius: 40.0),
                        icon: Helpers.fetchIcons(
                          "cross",
                          "regular",
                          color: "text.primary",
                          size: 16.0,
                        )),
                  ),
                  const SizedBox(height: 3.0),
                ],
              ),
            );
          });
        });
    return res;
  }

  static Future<String> showCountry() async {
    final selected = await Helpers.readPref(Defaults.selectedCountry);
    var res = selected.isNotEmpty ? selected : "Nigeria";
    final countryController = TextEditingController();
    countryController.text = res;
    await showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Palette.getColor(context, "background", "paper"),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.0,
                    children: [
                      Image.asset("assets/images/icon.png",
                          height: 80.0, fit: BoxFit.cover),
                      Widgets.buildText(
                          "Your Cribsfinder app is currently set to $res",
                          context,
                          isMedium: true,
                          size: 20.0,
                          lines: 3),
                      Widgets.buildText(
                          "Cribsfinder is currently available only in Nigeria as we have not yet expanded to other countries. However, we are actively working on expanding our services to more regions in the near future. Stay tuned for updates as we grow!",
                          context,
                          lines: 10),
                      Widgets.buildText("Country:", context, size: 13.0),
                      TextFormField(
                        controller: countryController,
                        style: GoogleFonts.nunito(),
                        readOnly: true,
                        decoration: InputDecoration(
                            labelStyle: GoogleFonts.nunito(),
                            hintStyle: GoogleFonts.nunito(),
                            helperStyle: GoogleFonts.nunito(),
                            suffix: UnconstrainedBox(
                              child: Helpers.fetchIcons("caret-down", "solid",
                                  color: "text.disabled", size: 24.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Color(0x99F4F4F4),
                            labelText: "",
                            contentPadding: const EdgeInsets.fromLTRB(
                                15.0, 10.0, 15.0, 10.0),
                            //hintText: hint,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onTap: () async {
                          final country = await showOptions(
                              "Countries",
                              "",
                              Defaults.countries
                                  .map((country) =>
                                      {...country, "value": country["name"]})
                                  .toList(),
                              isSearch: true);
                          if (country.isNotEmpty) {
                            setState(() => countryController.text =
                                country["value"].toString());
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            );
          });
        });
    return res;
  }
}
