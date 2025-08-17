import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/palette.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String _chatId = "";
  Map<String, dynamic> _message = {};
  Map<String, dynamic> groupedMessage = {};
  Map<String, List> filteredMessage = {};
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  var loading = false;
  String userId = "";
  var error = "";
  Map<String, dynamic> _userDetails = {};

  void getMessages() async {
    try {
      final resp = database.ref("/chats/$_chatId");
      final Map<String, dynamic> chats = {};
      resp.onValue.listen((event) {
        try {
          if (event.snapshot.exists) {
            final data = event.snapshot.children;
            for (var item in data) {
              final key = item.key;
              final value = (item.value ?? {}) as Map;
              final message = {...value, "key": key};
              final date = (message["date"] ?? "").toString();
              if (date.isNotEmpty && date.contains(" ")) {
                final dateOnly = date.split(" ")[0];
                if (chats.containsKey(dateOnly)) {
                  final first = chats[dateOnly]
                      .where((item) => item["key"].toString() == key);
                  if (first.length > 0) {
                    // update
                    chats[dateOnly] = chats[dateOnly]!
                        .map((i) => i["key"].toString() == key ? message : i)
                        .toList();
                  } else {
                    chats[dateOnly]!.add(message);
                  }
                } else {
                  chats[dateOnly] = [message];
                }
              }
            }
          }
          setState(() {
            groupedMessage = chats;
          });
          database.ref("unreads/${userId}_1/$_chatId").set(0);
          Future.delayed(Duration(milliseconds: 500), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        } catch (err) {
          debugPrint(err.toString());
        }
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void handleSave({PlatformFile? file}) {
    try {
      final text = messageController.text;
      if ((text.isNotEmpty || file != null) && _chatId.isNotEmpty) {
        // mark as unread
        final ids = _chatId.split("_");
        final receivedId = ids[0] == userId ? ids[1] : ids[0];
        final dateTime = Helpers.formatDateObject(DateTime.now(),
            formatString: "yyyy-MM-dd HH:mm:ss");
        final lastMessage = jsonEncode({
          "text": text.isEmpty ? "Sent file attachment" : text,
          "dateTime": dateTime
        });
        database.ref("/unreads/${receivedId}_0/$_chatId").set(1);
        database.ref("/lastmessages/${receivedId}_0/$_chatId").set(lastMessage);
        database.ref("/lastmessages/${userId}_1/$_chatId").set(lastMessage);
        final newData = database.ref("chats/$_chatId").push();
        newData.set({
          "message": file != null && file.name.isNotEmpty
              ? file.name
              : text.replaceAll('\n', "<br>"),
          "type": file != null ? "file" : "text",
          "date": dateTime,
          "sender": userId,
          "senderType": 0,
          "file": "",
          "fileSize": file != null && file.size > 0 ? file.size : "",
          "fileType": file != null && file.xFile.mimeType != null
              ? file.xFile.mimeType
              : "",
        });
        messageController.text = "";
      } else if (file == null) {
        Alert.show(context, "", "Enter your message before sending....");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  void handleFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );
      if (result != null) {
        final results = result.files;
        List<String> uploadedFiles = [];
        for (PlatformFile file in results) {
          if (file.path != null) {
            handleSave(file: file);
            uploadedFiles.add(file.path!);
          }
        }
        final files = await JWT.uploadFiles("chat_upload[]", uploadedFiles);
        for (var i = 0; i < files.length; i += 1) {
          final file = files[i];
          final actualFileName = results[i].name;

          final dates = groupedMessage.keys.toList();
          for (var date in dates) {
            final chats = groupedMessage[date];
            final messages = chats
                .where((message) =>
                    message["type"].toString() == "file" &&
                    message["file"].toString() == "" &&
                    message["message"] == actualFileName)
                .toList();
            print("dates $messages");
            if (messages.length > 0) {
              final Map<String, dynamic> message = {
                ...messages[messages.length - 1],
                "file": file
              };
              print("dates $message");
              FirebaseDatabase.instance
                  .ref("/chats/$_chatId/${message["key"]}")
                  .update(message);
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null) {
        try {
          final profile = await Helpers.getProfile();
          final userDetails = profile["user"];
          final data = jsonDecode(arguments.toString());
          setState(() {
            _message = data;
            _userDetails = userDetails;
            _chatId = _message["chatId"].toString();
            userId = userDetails["uid"].toString();
          });
          getMessages();
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: Palette.getColor(context, "background", "default"),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Palette.getColor(context, "background", "paper"),
          foregroundColor: Palette.getColor(context, "text", "disabled"),
          title: Row(
            spacing: 5.0,
            children: [
              Helpers.getPhoto(
                  _message.containsKey("person")
                      ? _message["person"]["photo"].toString()
                      : "",
                  width: 35.0,
                  height: 35.0,
                  text: (_message.containsKey("person")
                      ? _message["person"]["name"].toString()
                      : ""),
                  radius: 35.0,
                  isInitials: true,
                  type: "host"),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Widgets.buildText(
                        _message.containsKey("person")
                            ? _message["person"]["name"].toString()
                            : "",
                        context,
                        size: 14.0,
                        isMedium: true),
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
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Palette.get(_message
                                                  .containsKey("booking") &&
                                              (_message["booking"]["status"]
                                                          .toString() ==
                                                      "1" ||
                                                  _message["booking"]["status"]
                                                          .toString() ==
                                                      "4")
                                          ? "success.main"
                                          : "error.main"))),
                              Widgets.buildText(
                                  Defaults.bookingStatus[num.tryParse(_message
                                                      .containsKey("booking")
                                                  ? _message["booking"]
                                                          ["status"]
                                                      .toString()
                                                  : "4")
                                              ?.toInt() ??
                                          0]["label"]
                                      .toString(),
                                  context,
                                  size: 12.0)
                            ],
                          ),
                          Widgets.buildText("•", context,
                              color: "text.disabled"),
                          Widgets.buildText(
                              _message.containsKey("booking")
                                  ? "${Helpers.formatDate(_message["booking"]["checkin"].toString(), formatString: "MMM dd")} - ${Helpers.formatDate(_message["booking"]["checkout"].toString(), formatString: "MMM dd")}"
                                  : "",
                              context,
                              size: 12.0),
                          Widgets.buildText("•", context,
                              color: "text.disabled"),
                          Widgets.buildText(
                              _message.containsKey("booking") &&
                                      _message["booking"]
                                          .toString()
                                          .isNotEmpty &&
                                      _message["booking"]
                                          .containsKey("roomType")
                                  ? (_message["booking"]["roomType"] is List
                                      ? "${_message["booking"]["roomType"].length} room${_message["booking"]["roomType"].length > 1 ? "s" : ""}"
                                      : (_message["booking"]["roomType"]
                                              is String
                                          ? _message["booking"]["roomType"]
                                              .toString()
                                          : _message["booking"]["roomType"]
                                                  ["title"]
                                              .toString()))
                                  : "",
                              context,
                              size: 12.0)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/booking",
                      arguments: jsonEncode(_message["booking"]));
                },
                child: Widgets.buildText("Details", context,
                    isMedium: true, color: "text.secondary", size: 14.0))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, left: 15.0, right: 15.0, bottom: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: loading
                      ? Shimmer.fromColors(
                          baseColor: Palette.get("background.neutral"),
                          highlightColor: Palette.get("background.default"),
                          loop: 1,
                          child:
                              AbsorbPointer(child: buildContent(screenWidth)))
                      : (error.isNotEmpty
                          ? Alert.showErrorMessage(context, "", message: error)
                          : buildContent(screenWidth)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: Widgets.inputDecoration("",
                            color: Palette.get("background.neutral"),
                            isFilled: true,
                            isOutline: true,
                            hintColor: Palette.get("text.disabled"),
                            hint: "Type your message..."),
                        maxLines: 5,
                        minLines: 1,
                        style: GoogleFonts.nunito(
                            color: Palette.get("text.primary"),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                        onSubmitted: (v) {},
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          handleFileUpload();
                        },
                        icon: Helpers.fetchIcons("clip", "solid", size: 20.0)),
                    TextButton(
                        onPressed: () {
                          handleSave();
                        },
                        style: Widgets.buildButton(context,
                            background: Palette.get("main.primary")),
                        child: Widgets.buildText("Send", context,
                            color: "text.white"))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget buildContent(double screenWidth) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final date = groupedMessage.keys.toList()[index];
          final messages = groupedMessage[date] ?? [];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Widgets.buildText(
                    Helpers.formatDate(date, formatString: "MMM d, yyyy"),
                    context,
                    color: "text.secondary",
                    weight: 500),
                const SizedBox(
                  height: 20.0,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = messages[index];
                      final widgets = [
                        Helpers.getPhoto(
                            item["sender"].toString() == userId
                                ? (_userDetails.containsKey("photo")
                                    ? _userDetails["photo"].toString()
                                    : "")
                                : (_message.containsKey("person")
                                    ? _message["person"]["photo"].toString()
                                    : ""),
                            isInitials: true,
                            type: item["sender"].toString() == userId
                                ? "customer"
                                : "host",
                            width: 40.0,
                            height: 40.0,
                            radius: 40.0,
                            text: item["sender"].toString() == userId
                                ? (_userDetails.containsKey("name")
                                    ? _userDetails["name"].toString()
                                    : "")
                                : (_message.containsKey("person")
                                    ? _message["person"]["name"].toString()
                                    : "")),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 50.0,
                            maxWidth: screenWidth - 200.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Palette.get("background.neutral"),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight:
                                      item["sender"].toString() == userId
                                          ? Radius.circular(1.0)
                                          : Radius.circular(10.0),
                                  bottomLeft:
                                      item["sender"].toString() == userId
                                          ? Radius.circular(10.0)
                                          : Radius.circular(1.0),
                                )),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: IntrinsicWidth(
                              child: Row(
                                spacing: 5.0,
                                children: [
                                  if (item["type"].toString() == "file" &&
                                      item["file"].toString().isEmpty)
                                    SizedBox(
                                        height: 15.0,
                                        width: 15.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Palette.get("main.primary")),
                                        )),
                                  if (item["type"].toString() == "file" &&
                                      item["file"].toString().isNotEmpty &&
                                      !Helpers.isImage(item["file"].toString()))
                                    Helpers.fetchIcons("document", "solid",
                                        color: "success.main", size: 24.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (item["type"].toString() == "file" &&
                                            item["file"]
                                                .toString()
                                                .isNotEmpty &&
                                            Helpers.isImage(
                                                item["file"].toString()))
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                      5.0),
                                              child: CachedNetworkImage(
                                                  height: 100.0,
                                                  width: 400,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "${API.login}${item["file"].toString()}"),
                                            ),
                                          ),
                                        if (!Helpers.isImage(
                                            item["file"].toString()))
                                          Widgets.buildText(
                                              item["message"].toString(),
                                              context,
                                              color: "text.disabled",
                                              size: 13.0),
                                        if (item["type"].toString() == "file")
                                          Widgets.buildText(
                                              "${Helpers.humanFileSize(item["fileSize"], 2)} • ${item["message"].toString().split(".").last.toUpperCase()}",
                                              context,
                                              size: 11.0,
                                              color: "text.disabled")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Widgets.buildText(
                            Helpers.formatDate(item["date"].toString(),
                                formatString: "hh:mm aaa"),
                            context,
                            color: "text.disabled",
                            size: 10.0),
                      ];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index + 1 == messages.length ? 0 : 30.0),
                        child: GestureDetector(
                          onTap: () {
                            if (item["type"].toString() == "file" &&
                                item["file"].toString().isNotEmpty) {
                              if (Helpers.isImage(item["file"].toString())) {
                                Sheets.showImagePreview([
                                  item["file"].toString(),
                                ], "View Image", type: "chat");
                              } else {
                                Helpers.openLink(
                                    "${API.login}${item["file"].toString()}",
                                    "Download file");
                              }
                            }
                            if (item["type"].toString() == "file" &&
                                item["file"].toString().isEmpty) {
                              Alert.show(context, "",
                                  "Please wait while the file downloads...");
                            }
                          },
                          child: Row(
                            spacing: 10.0,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment:
                                item["sender"].toString() == userId
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: item["sender"].toString() == userId
                                ? widgets.reversed.toList()
                                : widgets,
                          ),
                        ),
                      );
                    },
                    itemCount: messages.length)
              ],
            ),
          );
        },
        itemCount: groupedMessage.length);
  }
}
