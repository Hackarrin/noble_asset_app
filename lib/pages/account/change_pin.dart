import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../utils/palette.dart';

class ChangeTransactionPin extends StatefulWidget {
  const ChangeTransactionPin({Key? key}) : super(key: key);

  @override
  _ChangeTransactionPinState createState() => _ChangeTransactionPinState();
}

class _ChangeTransactionPinState extends State<ChangeTransactionPin>
    with SingleTickerProviderStateMixin {
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        title: Widgets.buildText("Manage PIN", context, isMedium: true),
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
              Widgets.buildText("Enter your old PIN", context,
                  size: 24.0, weight: 500),
              const SizedBox(
                height: 10.0,
              ),
              Widgets.buildText(
                  "Please enter your current transaction PIN", context,
                  color: "text.secondary"),
              const SizedBox(
                height: 80.0,
              ),
              PinCodeTextField(
                  autofocus: true,
                  highlight: true,
                  pinBoxColor:
                      Palette.getColor(context, "background", "default"),
                  pinBoxRadius: 10.0,
                  controller: pinController,
                  defaultBorderColor: Colors.transparent,
                  hasTextBorderColor:
                      Palette.getColor(context, "main", "primary"),
                  highlightColor: Palette.getColor(context, "main", "primary"),
                  maxLength: 4,
                  pinBoxWidth: 50,
                  pinBoxHeight: 50,
                  wrapAlignment: WrapAlignment.center,
                  pinTextStyle: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Palette.getColor(context, "text", "secondary"))),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {},
                    child: Widgets.buildText("Forgot your PIN?", context,
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
