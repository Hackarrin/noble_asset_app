import 'package:nobleassets/utils/defaults.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Compliance extends StatefulWidget {
  const Compliance({Key? key}) : super(key: key);

  @override
  _ComplianceState createState() => _ComplianceState();
}

class _ComplianceState extends State<Compliance>
    with SingleTickerProviderStateMixin {
  final menus = [
    {"name": "BVN", "page": "/bvn"},
    {"name": "Identification", "page": "/identification"},
    {"name": "Facial Verification", "page": "pin-enable"},
    {"name": "Proof of Address", "page": "proof-of-address"},
  ];
  var enablePin = true;

  Map<String, dynamic> bvnStatus = {"text": "Pending", "label": "warning"};
  Map<String, dynamic> idStatus = {"text": "Pending", "label": "warning"};
  Map<String, dynamic> selfieStatus = {"text": "Pending", "label": "warning"};
  String selfie = "";
  int intBvnStatus = 0;
  int intIdStatus = 0;
  int intSelfieStatus = 0;
  int accountType = 0;

  Future<void> fetch() async {
    Map<String, dynamic> data = await Helpers.getProfile();
    Map<String, dynamic> dataVerification = await Helpers.getVerifications();
    print("response $dataVerification");
    setState(() {
      accountType = num.tryParse(data["type"].toString())?.toInt() ?? 0;
      if (dataVerification.containsKey("bvn_status")) {
        bvnStatus = dataVerification["bvn_status"];
        intBvnStatus = num.tryParse(dataVerification["intBvnStatus"].toString())
                ?.toInt() ??
            0;
      }
      if (dataVerification.containsKey("selfie_status")) {
        selfieStatus = dataVerification["selfie_status"];
        intSelfieStatus =
            num.tryParse(dataVerification["intSelfieStatus"].toString())
                    ?.toInt() ??
                0;
      }
      if (dataVerification.containsKey("status")) {
        idStatus = dataVerification["status"];
        setState(() {
          selfie = dataVerification["selfie"];
        });
        intIdStatus =
            num.tryParse(dataVerification["intStatus"].toString())?.toInt() ??
                0;
        if (intIdStatus == 1 && dataVerification["lga"].toString().isEmpty) {
          intIdStatus = 0;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await fetch();
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
        title: Widgets.buildText("Compliance", context, isMedium: true),
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
                Padding(
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
                          final item = menus[index];
                          Map status = {};
                          if (index == 0) {
                            status = bvnStatus;
                          } else if (index == 1) {
                            status = idStatus;
                          } else if (index == 2) {
                            status = selfieStatus;
                          }
                          return GestureDetector(
                            onTap: () async {
                              if (index == 2) {
                                await Sheets.showSelfie(selfie);
                                fetch();
                              } else if (index == 3) {
                                Sheets.showProofAddress();
                              } else {
                                Navigator.pushNamed(
                                        context, item["page"].toString())
                                    .then((value) {
                                  fetch();
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: index == 0
                                          ? BorderSide.none
                                          : BorderSide(
                                              color: Color(0x1A000000)))),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Widgets.buildText(
                                            item["name"].toString(), context,
                                            size: 14.0,
                                            weight: 400,
                                            color: "text.primary"),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                      ]),
                                  Row(
                                    children: [
                                      if (status.isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Palette.get(
                                                  "${status["label"]}.main"),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          padding: const EdgeInsets.all(5.0),
                                          child: Widgets.buildText(
                                              status["text"].toString(),
                                              context,
                                              size: 12.0,
                                              weight: 500,
                                              color: "text.white"),
                                        ),
                                      Helpers.fetchIcons(
                                          "caret-right", "regular",
                                          size: 16.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: menus.length,
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
