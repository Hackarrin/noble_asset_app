import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class BVN extends StatefulWidget {
  const BVN({Key? key}) : super(key: key);

  @override
  _BVNState createState() => _BVNState();
}

class _BVNState extends State<BVN> with SingleTickerProviderStateMixin {
  final pinController = TextEditingController();

  var isVerified = false;
  void handleSubmit() async {
    try {
      Alert.showLoading(context, "Updating...");
      await JWT.updateBVN(pinController.text);
      Alert.hideLoading(context);
      Alert.show(context, "", "Your BVN has been updated successfully!",
          type: "success");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  Future<void> fetch() async {
    Map<String, dynamic> dataVerification = await Helpers.getVerifications();
    setState(() {
      if (dataVerification.containsKey("bvn_status")) {
        isVerified = (num.tryParse(dataVerification["intBvnStatus"].toString())
                    ?.toInt() ??
                0) ==
            1;
        pinController.text = dataVerification["bvn"] ?? "";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("BVN", context, isMedium: true),
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Palette.get("background.paper"),
          ),
          padding: const EdgeInsets.only(
              bottom: 15.0, left: 15.0, right: 15.0, top: 20.0),
          child: Column(
            children: [
              Widgets.buildText("BVN Information", context,
                  size: 24.0, weight: 500),
              const SizedBox(
                height: 10.0,
              ),
              Widgets.buildText(
                  "Enter your 11-digit BVN below. Please note that we only use this to verify your account.",
                  context,
                  color: "text.secondary",
                  lines: 5,
                  isCenter: true),
              const SizedBox(
                height: 40.0,
              ),
              TextField(
                controller: pinController,
                readOnly: isVerified,
                decoration: Widgets.inputDecoration(
                  "",
                  color: Palette.get("background.neutral"),
                  isFilled: true,
                  isOutline: true,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty && value.length == 11) {
                    handleSubmit();
                  } else {
                    Alert.show(
                        context, "", "Provide your valid BVN to proceed.");
                  }
                },
                style: GoogleFonts.nunito(
                    color: Palette.get("text.secondary"),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      Sheets.forgotBVN();
                    },
                    child: Widgets.buildText("Forgot your BVN?", context,
                        size: 14.0,
                        weight: 400,
                        color: "text.secondary",
                        isUnderlined: true)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
