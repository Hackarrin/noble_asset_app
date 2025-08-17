import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/apis.dart';
import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class Identification extends StatefulWidget {
  const Identification({Key? key}) : super(key: key);

  @override
  _IdentificationState createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> profile = {};

  List<Map<String, String>> identifications = [
    {"name": "National Identity Number", "code": "nin"},
    {"name": "International Passport", "code": "passport"},
    {"name": "Voter's Card", "code": "voter"},
    {"name": "Driver's License", "code": "driver"}
  ];
  var idType = "";
  var isVerified = false;
  var photo = "";
  final typeController = TextEditingController();
  final numberController = TextEditingController();
  final stateController = TextEditingController();
  final lgaController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  void handleSubmit() async {
    try {
      Alert.showLoading(context, "Updating...");
      final values = {
        "idNum": numberController.text,
        "idType": idType,
        "state": stateController.text,
        "lga": lgaController.text,
        "address": addressController.text,
        "dob": dobController.text,
        "photo": photo
      };
      final unruly = values.values.every((element) => element.isNotEmpty);
      if (unruly) {
        await JWT.updateID(values);
        Alert.hideLoading(context);
        Alert.show(
            context, "", "Your KYC information has been updated successfully!",
            type: "success");
      } else {
        Alert.show(context, "", "Please fill all required fields to proceed.",
            type: "error");
      }
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  Future<void> fetch() async {
    Map<String, dynamic> dataVerification = await Helpers.getVerifications();
    setState(() {
      if (dataVerification.containsKey("status")) {
        isVerified =
            (num.tryParse(dataVerification["intStatus"].toString())?.toInt() ??
                    0) ==
                1;
        photo = dataVerification["photo"].toString();
        idType = dataVerification["idType"].toString();
        typeController.text = identifications
            .firstWhere((item) => item["code"].toString() == idType,
                orElse: () => {"name": ""})["name"]
            .toString();
        numberController.text = dataVerification["idNum"].toString();
        stateController.text = dataVerification["state"].toString();
        lgaController.text = dataVerification["lga"].toString();
        addressController.text = dataVerification["address"].toString();
        dobController.text = dataVerification["dob"].toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      fetch();
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
        title: Widgets.buildText("Identification Information", context,
            isMedium: true),
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
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 15.0, left: 15.0, right: 15.0, top: 20.0),
              child: Column(
                spacing: 10.0,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.get("background.paper"),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color(0x0D000000))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            color: Palette.getColor(
                                context, "background", "paper"),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final image = await Sheets.chooseImage(
                                      "Upload Id Image",
                                      isBase64: true);
                                  setState(() => photo = image);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  padding: const EdgeInsets.all(30.0),
                                  decoration: photo == ""
                                      ? BoxDecoration(
                                          color: Palette.getColor(
                                              context, "background", "neutral"),
                                          border: Border.all(
                                              color: Palette.getColor(context,
                                                  "background", "default")),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30.0)),
                                        )
                                      : (photo.toString().length > 20
                                          ? BoxDecoration(
                                              image: DecorationImage(
                                                image: MemoryImage(base64Decode(
                                                    photo.toString())),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${API.uRLIDPHOTO}${photo}"),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.badge,
                                          size: 30,
                                          color: Palette.getColor(
                                              context, "text", "secondary")),
                                      const SizedBox(height: 5.0),
                                      Widgets.buildText(
                                          "${photo == "" ? "Upload" : "Change"} ID Image",
                                          context,
                                          size: 15.0,
                                          color: "text.primary")
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Widgets.buildText(
                                  "Upload a valid ID Image (${identifications.map((i) => i["name"].toString()).join(", ")}).",
                                  context,
                                  lines: 10,
                                  size: 12.0,
                                  isCenter: true,
                                  isMedium: true)
                            ],
                          )),
                    ),
                  ),
                  Container(
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
                        var item = {};
                        switch (index) {
                          case 0:
                            item = {
                              "label": "Type of Identification",
                              "controller": typeController,
                              "value": "idType",
                              "values": ["idType"],
                            };
                            break;
                          case 1:
                            item = {
                              "label": "ID Number",
                              "controller": numberController,
                              "values": ["idNum"],
                              "value": "idNum",
                            };
                            break;
                          case 2:
                            item = {
                              "label": "State",
                              "controller": stateController,
                              "value": "state",
                              'values': ["state"],
                            };
                            break;
                          case 3:
                            item = {
                              "label": "Local Government Area",
                              "controller": lgaController,
                              "values": ["lga"],
                              "value": "lga",
                            };
                            break;
                          case 4:
                            item = {
                              "label": "Residential Address",
                              "controller": addressController,
                              "values": ["address"],
                              "value": "address",
                            };
                            break;
                          case 5:
                            item = {
                              "label": "Date of Birth",
                              "controller": dobController,
                              "values": ["dob"],
                              "value": "dob",
                            };
                            break;
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets.buildText(
                                  item["label"].toString(), context,
                                  color: 'text.primary', size: 13.0),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextField(
                                controller: item["controller"],
                                readOnly: isVerified ||
                                    index == 0 ||
                                    index == 2 ||
                                    index == 3 ||
                                    index == 5,
                                decoration: Widgets.inputDecoration("",
                                    color: Palette.get("background.neutral"),
                                    borderColor:
                                        Palette.get("background.neutral"),
                                    isFilled: true,
                                    isOutline: true,
                                    suffixIcon: index == 0 ||
                                            index == 2 ||
                                            index == 3 ||
                                            index == 5
                                        ? UnconstrainedBox(
                                            child: Helpers.fetchIcons(
                                                "caret-down", "regular",
                                                size: 20.0,
                                                color: "text.primary"))
                                        : null),
                                onTap: () async {
                                  if (index == 0) {
                                    // identification
                                    final type = await Sheets.showSortBy(
                                        typeController.text,
                                        title: "Select identification type",
                                        items: identifications);
                                    if (type.isNotEmpty) {
                                      final selected = identifications[
                                          num.tryParse(type)?.toInt() ?? 0];
                                      typeController.text =
                                          selected["name"].toString();
                                      setState(() {
                                        idType = selected["code"].toString();
                                      });
                                    }
                                  }
                                  if (index == 2) {
                                    // state
                                    final type = await Sheets.showSortBy(
                                        stateController.text,
                                        title: "Select State",
                                        items: Defaults.states
                                            .map((item) =>
                                                {"name": item, "value": item})
                                            .toList());
                                    if (type.isNotEmpty) {
                                      stateController.text = type;
                                      lgaController.text = "";
                                    }
                                  }
                                  if (index == 3) {
                                    // lga
                                    final lgas = stateController.text.isNotEmpty
                                        ? Defaults.lgas
                                            .firstWhere((item) =>
                                                item["state"].toString() ==
                                                stateController.text)["lgas"]
                                            .map((item) =>
                                                {"name": item, "value": item})
                                            .toList()
                                        : [];
                                    final type = await Sheets.showSortBy(
                                        lgaController.text,
                                        title: "Select Local Government Area",
                                        items: lgas);
                                    if (type.isNotEmpty) {
                                      lgaController.text = type;
                                    }
                                  }
                                  if (index == 5) {
                                    // dob
                                    final type = await Sheets.selectDate(
                                        dobController.text,
                                        title: "Select Date of birth");
                                    if (type.isNotEmpty) {
                                      dobController.text = type;
                                    }
                                  }
                                },
                                style: GoogleFonts.nunito(
                                    color: Palette.get("text.secondary"),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 6,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          handleSubmit();
                        },
                        style: Widgets.buildButton(context,
                            background: Palette.get("main.primary"),
                            radius: 50.0,
                            vertical: 15.0),
                        child: Widgets.buildText("Save Details", context,
                            isMedium: true, color: "text.white")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
