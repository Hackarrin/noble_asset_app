import 'dart:async';
import 'dart:convert';

import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String _filter = "all";
  List _messages = [
    {
      "type": 0,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 1,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 2,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 3,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 0,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "NGN",
    },
    {
      "type": 1,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "USD",
    },
    {
      "type": 2,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
    {
      "type": 3,
      "amount": 940343,
      "title": "Tayo Oladele",
      "date": "2025-02-04",
      "currency": "GBP",
    },
  ];
  Map<String, int> _unreads = {};
  Map<String, String> _lastMessages = {};
  Map<String, List> groupedMessages = {};
  Map<String, List> filteredMessages = {};

  StreamSubscription? _unreadStreams;
  StreamSubscription? _lastStreams;

  var loading = false;
  String userId = "";
  var error = "";

  void groupMessages() {
    try {
      Map<String, List> messages = {};
      String today = Helpers.formatDateObject(DateTime.now(),
          formatString: "yyyy-MM-dd HH:mm:ss");

      // reorder messages by date
      _messages.sort((m1, m2) {
        return Helpers.parseDate(m2["date"],
                formatString: "yyyy-MM-dd HH:mm:ss")
            .millisecondsSinceEpoch
            .compareTo(Helpers.parseDate(m1["date"],
                    formatString: "yyyy-MM-dd HH:mm:ss")
                .millisecondsSinceEpoch);
      });
      for (var i = 0; i < _messages.length; i += 1) {
        final pass = (_filter == "unread" &&
                _unreads.containsKey(_messages[i]["chatId"].toString()) &&
                _unreads[_messages[i]["chatId"].toString()] == 1) ||
            (_filter == "new" &&
                Helpers.dateDiff(_messages[i]["date"].toString(), today) ==
                    0) ||
            _filter == "all";
        if (!pass) {
          // prevent filters.
          continue;
        }
        final date = _messages[i]["date"].toString().split(" ")[0];
        if (messages.containsKey(date)) {
          messages[date]!.add(_messages[i]);
        } else {
          messages[date] = [_messages[i]];
        }
      }
      setState(() {
        groupedMessages = messages;
        if (groupedMessages.isEmpty) {
          error =
              "You do have any ${_filter.toLowerCase()} message at the moment! Don't worry. They'll show up here when you add some.";
        } else {
          error = "";
        }
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getMessages("");
      setState(() {
        _messages = res["data"];
        loading = false;
        error = "";
      });
      groupMessages();
      getLastMessageAndUnreads();

      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final data = jsonDecode(arguments.toString());
          final chatId = data["messageId"].toString();
          print("filtered $chatId");
          final filtered =
              _messages.where((i) => i["chatId"].toString() == chatId);
          print("filtered ${filtered}");
          if (filtered.isNotEmpty) {
            Navigator.pushNamed(context, "/message",
                    arguments: jsonEncode(filtered.first))
                .then((v) {
              getLastMessageAndUnreads();
            });
          }
        } catch (err) {
          print("dante - $err");
        }
      }
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  void getLastMessageAndUnreads() async {
    try {
      print("dante $userId");
      final resp = database.ref("/lastmessages/${userId}_1");
      _lastStreams = resp.onValue.listen((event) {
        try {
          if (event.snapshot.exists) {
            final data = (event.snapshot.value ?? {}) as Map;
            final values = data.values.toList();
            final keys = data.keys.toList();
            for (var i = 0; i < values.length; i += 1) {
              final key = keys[i];
              final content = values[i].toString().contains("dateTime")
                  ? jsonDecode(values[i])
                  : values[i];
              if (content is Map) {
                final dateTime = content["dateTime"].toString();
                print("dante ${_messages[i]}");
                final newMessages = _messages
                    .map((message) => message["chatId"].toString() == key
                        ? {...message, "date": dateTime}
                        : message)
                    .toList();
                setState(() {
                  _messages = newMessages;
                });
                groupMessages();
              }
              setState(() {
                _lastMessages[key] =
                    content is Map ? content["text"].toString() : content;
              });
              print("dante $_lastMessages");
            }
          }
        } catch (err) {
          debugPrint(err.toString());
        }
      });

      final resr = database.ref("/unreads/${userId}_1");
      _unreadStreams = resr.onValue.listen((event) {
        try {
          if (event.snapshot.exists) {
            final data =
                jsonDecode(jsonEncode(event.snapshot.value ?? {})) as Map;
            final values = data.values.toList();
            final keys = data.keys.toList();
            for (var i = 0; i < values.length; i += 1) {
              final key = keys[i];
              setState(() {
                _unreads[key] = values[i];
              });
            }
          }
        } catch (err) {
          debugPrint(err.toString());
        }
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final profile = await Helpers.getProfile();
      final userDetails = profile["user"];
      setState(() {
        userId = userDetails["uid"].toString();
      });
      groupMessages();
      fetch();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        print("dante - popped");
        _lastStreams?.cancel();
        _unreadStreams?.cancel();
      },
      child: Scaffold(
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
            elevation: 0,
            backgroundColor: Palette.getColor(context, "background", "paper"),
            foregroundColor: Palette.getColor(context, "text", "disabled"),
            title: Widgets.buildText("My Messages", context, isMedium: true),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      for (var item in ["All", "New", "Unread"])
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _filter = item.toLowerCase();
                            });
                            groupMessages();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Palette.get(
                                        _filter == item.toLowerCase()
                                            ? "main.secondary"
                                            : "background.neutral")),
                                child: Center(
                                  child: Widgets.buildText(item, context,
                                      color: item.toLowerCase() == _filter
                                          ? "text.white"
                                          : "text.primary",
                                      isMedium: true,
                                      size: 14.0),
                                )),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: loading
                        ? Shimmer.fromColors(
                            baseColor: Palette.get("background.neutral"),
                            highlightColor: Palette.get("background.default"),
                            loop: 1,
                            child:
                                AbsorbPointer(child: buildContent(screenWidth)))
                        : (error.isNotEmpty
                            ? Alert.showErrorMessage(context, "",
                                message: error,
                                buttonText: "Retry", action: () {
                                setState(() {
                                  _filter = "all";
                                });
                                fetch();
                              })
                            : buildContent(screenWidth)),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildContent(double screenWidth) {
    print("unreads $_unreads");
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final date = groupedMessages.keys.toList()[index];
          final messages = groupedMessages[date] ?? [];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.buildText(
                    Helpers.formatDate(date, formatString: "MMM d, yyyy"),
                    context,
                    color: "text.secondary",
                    weight: 500),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Palette.get("background.paper"),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Color(0x0D000000))),
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = messages[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/message",
                                    arguments: jsonEncode(item))
                                .then((v) {
                              getLastMessageAndUnreads();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    index + 1 == messages.length ? 0 : 20.0),
                            child: Row(
                              spacing: 10.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Helpers.getPhoto(
                                    item.containsKey("person")
                                        ? item["person"]["photo"].toString()
                                        : "",
                                    isInitials: true,
                                    type: "host",
                                    width: 50.0,
                                    height: 50.0,
                                    radius: 50.0,
                                    text: item.containsKey("person")
                                        ? item["person"]["name"].toString()
                                        : ""),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Widgets.buildText(
                                              item.containsKey("person")
                                                  ? item["person"]["name"]
                                                      .toString()
                                                  : "",
                                              isMedium: true,
                                              isBold: _unreads.containsKey(
                                                      item["chatId"]
                                                          .toString()) &&
                                                  _unreads[item["chatId"]
                                                          .toString()] ==
                                                      1,
                                              size: 14.0,
                                              context),
                                          Widgets.buildText(
                                              Helpers.formatDate(
                                                  item["date"].toString(),
                                                  formatString: "hh:mm aaa"),
                                              context,
                                              size: 12.0,
                                              isBold: _unreads.containsKey(
                                                      item["chatId"]
                                                          .toString()) &&
                                                  _unreads[item["chatId"]
                                                          .toString()] ==
                                                      1,
                                              color: "text.secondary")
                                        ],
                                      ),
                                      FittedBox(
                                        child: Row(
                                          spacing: 3,
                                          children: [
                                            Row(
                                              spacing: 2.0,
                                              children: [
                                                Container(
                                                    width: 5.0,
                                                    height: 5.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: Palette.get(item
                                                                    .containsKey(
                                                                        "booking") &&
                                                                (item["booking"]["status"]
                                                                            .toString() ==
                                                                        "1" ||
                                                                    item["booking"]["status"]
                                                                            .toString() ==
                                                                        "4")
                                                            ? "success.main"
                                                            : "error.main"))),
                                                Widgets.buildText(
                                                    Defaults.bookingStatus[
                                                            num.tryParse(item.containsKey(
                                                                            "booking")
                                                                        ? item["booking"]["status"]
                                                                            .toString()
                                                                        : "4")
                                                                    ?.toInt() ??
                                                                0]["label"]
                                                        .toString(),
                                                    context,
                                                    isBold: _unreads.containsKey(
                                                            item["chatId"]
                                                                .toString()) &&
                                                        _unreads[item["chatId"]
                                                                .toString()] ==
                                                            1,
                                                    size: 12.0)
                                              ],
                                            ),
                                            Widgets.buildText("•", context,
                                                color: "text.disabled"),
                                            Widgets.buildText(
                                                item.containsKey("booking")
                                                    ? "${Helpers.formatDate(item["booking"]["checkin"].toString(), formatString: "MMM dd")} - ${Helpers.formatDate(item["booking"]["checkout"].toString(), formatString: "MMM dd")}"
                                                    : "",
                                                context,
                                                isBold: _unreads.containsKey(
                                                        item["chatId"]
                                                            .toString()) &&
                                                    _unreads[item["chatId"]
                                                            .toString()] ==
                                                        1,
                                                size: 12.0),
                                            Widgets.buildText("•", context,
                                                color: "text.disabled"),
                                            Widgets.buildText(
                                                item.containsKey("booking") &&
                                                        item["booking"]
                                                            .toString()
                                                            .isNotEmpty &&
                                                        item["booking"].containsKey(
                                                            "roomType")
                                                    ? (item["booking"]["roomType"] is List
                                                        ? "${item["booking"]["roomType"].length} room${item["booking"]["roomType"].length > 1 ? "s" : ""}"
                                                        : (item["booking"]["roomType"] is String
                                                            ? item["booking"]
                                                                    ["roomType"]
                                                                .toString()
                                                            : item["booking"]
                                                                        ["roomType"]
                                                                    ["title"]
                                                                .toString()))
                                                    : "",
                                                context,
                                                isBold: _unreads.containsKey(
                                                        item["chatId"].toString()) &&
                                                    _unreads[item["chatId"].toString()] == 1,
                                                size: 12.0)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Widgets.buildText(
                                          _lastMessages.containsKey(
                                                  item["chatId"].toString())
                                              ? _lastMessages[item["chatId"].toString()]
                                                  .toString()
                                                  .replaceAll('\n', "")
                                              : "",
                                          context,
                                          isBold: _unreads.containsKey(
                                                  item["chatId"].toString()) &&
                                              _unreads[item["chatId"].toString()] ==
                                                  1,
                                          color: _unreads.containsKey(
                                                      item["chatId"]
                                                          .toString()) &&
                                                  _unreads[item["chatId"].toString()] == 1
                                              ? "text.secondary"
                                              : "text.disabled",
                                          size: 13.0)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: messages.length),
                )
              ],
            ),
          );
        },
        itemCount: groupedMessages.length);
  }
}
