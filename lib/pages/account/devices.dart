import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/defaults.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> with SingleTickerProviderStateMixin {
  List devices = [];
  var enableBiometric = false;

  bool loading = true;
  String error = "";
  void fetch() async {
    try {
      setState(() {
        error = "";
        loading = true;
      });
      final res = await JWT.getDevices();
      setState(() {
        devices = res;
        loading = false;
      });
      if (devices.isEmpty) {
        setState(() {
          error = "You don't have any devices yet!";
        });
      }
    } catch (err) {
      setState(() {
        error = err.toString();
        loading = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, fetch);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleLogout(item) async {
    try {
      final res = await Sheets.showConfirmation();
      if (res) {
        Alert.showLoading(context, "Logging out...");
        await JWT.logoutDevice(item);
        Alert.hideLoading(context);
        Alert.show(context, "", "Device has been logged out!", type: "success");
        fetch();
      }
    } catch (err) {
      print(err);
    }
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
        title: Widgets.buildText("Device History", context, isMedium: true),
        elevation: 0,
        backgroundColor: Palette.getColor(context, "background", "paper"),
        foregroundColor: Palette.getColor(context, "text", "disabled"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                error.isNotEmpty
                    ? Alert.showErrorMessage(context, "",
                        message: error, buttonText: "Retry", action: fetch)
                    : Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.get("background.paper"),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Color(0x1A000000))),
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = devices[index];
                              return GestureDetector(
                                onTap: () {
                                  if (item["status"].toString() == "1") {
                                    handleLogout(item);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: index == 0
                                              ? BorderSide.none
                                              : BorderSide(
                                                  color: Color(0x1A000000)))),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Helpers.fetchIcons(
                                                      Defaults.deviceIcons[
                                                          num.tryParse(item[
                                                                          "type"]
                                                                      .toString())
                                                                  ?.toInt() ??
                                                              0],
                                                      "regular",
                                                      size: 16.0),
                                                  const SizedBox(width: 5.0),
                                                  Expanded(
                                                    child: Widgets.buildText(
                                                        "${item["os"].toString()} · ${item["name"].toString()}",
                                                        context,
                                                        size: 14.0,
                                                        weight: 400,
                                                        lines: 2,
                                                        color: "text.primary"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Palette.get(item[
                                                                      "status"]
                                                                  .toString() ==
                                                              "0"
                                                          ? "error.main"
                                                          : "main.primary"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Widgets.buildText(
                                                      item["status"]
                                                                  .toString() ==
                                                              "0"
                                                          ? "Logged-out"
                                                          : "Logged-in",
                                                      context,
                                                      size: 11.0,
                                                      weight: 500,
                                                      color: "text.white"),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      FittedBox(
                                        child: Widgets.buildText(
                                            "${item["location"].toString()} · ${Helpers.formatDate(item["lastLogin"].toString(), formatString: "dd MMM yyyy hh:mma")}",
                                            context,
                                            size: 12.0,
                                            weight: 400,
                                            color: "text.primary"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: devices.length,
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
