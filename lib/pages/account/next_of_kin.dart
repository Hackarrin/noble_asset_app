import 'package:nobleassets/utils/alert.dart';
import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/jwt.dart';
import 'package:nobleassets/utils/modals.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class NextOfKin extends StatefulWidget {
  const NextOfKin({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<NextOfKin>
    with SingleTickerProviderStateMixin {
  var isVisible = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final relationController = TextEditingController();
  var relation = "";
  List<Map<String, String>> relationships = [
    {"name": "Husband", "code": "Husband"},
    {"name": "Wife", "code": "Wife"},
    {"name": "Sister", "code": "Sister"},
    {"name": "Brother", "code": "Brother"},
    {"name": "Father", "code": "Father"},
    {"name": "Mother", "code": "Mother"},
    {"name": "Nephew", "code": "Nephew"},
    {"name": "Niece", "code": "Niece"},
    {"name": "Cousin", "code": "Cousin"},
    {"name": "Friend", "code": "Friend"},
    {"name": "Daughter", "code": "Daughter"},
    {"name": "Son", "code": "Son"},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Map<String, dynamic> dataNOK = await Helpers.getNOK();
      nameController.text = dataNOK["name"].toString();
      emailController.text = dataNOK["email"].toString();
      phoneController.text = dataNOK["phone"].toString();
      addressController.text = dataNOK["address"].toString();
      relationController.text = dataNOK["relationship"].toString();
      relation = dataNOK["relationship"].toString().toLowerCase();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleSubmit() async {
    try {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          addressController.text.isEmpty ||
          relation.isEmpty) {
        Alert.show(context, "", "Please fill all required fields to proceed");
        return;
      }
      Alert.showLoading(context, "Updating...");
      await JWT.updateNextOfKin({
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "relationship": relation
      });
      Alert.hideLoading(context);
      Alert.show(context, "",
          "Your next of kin details has been updated successfully!",
          type: "success");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.getColor(context, "background", "default"),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Widgets.buildText("Next of Kin", context, isMedium: true),
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = {};
                  switch (index) {
                    case 0:
                      item = {"label": "Name", "controller": nameController};
                      break;
                    case 1:
                      item = {
                        "label": "Email address",
                        "controller": emailController
                      };
                      break;
                    case 2:
                      item = {
                        "label": "Phone number",
                        "controller": phoneController
                      };
                      break;
                    case 3:
                      item = {
                        "label": "Address",
                        "controller": addressController
                      };
                      break;
                    case 4:
                      item = {
                        "label": "How is this person related to you?",
                        "controller": relationController
                      };
                      break;
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(item["label"].toString(), context,
                            color: 'text.primary', size: 13.0),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: item["controller"],
                          keyboardType: item["label"] == "Phone number"
                              ? TextInputType.phone
                              : TextInputType.text,
                          readOnly: item["label"] ==
                              "How is this person related to you?",
                          decoration: Widgets.inputDecoration("",
                              color: Palette.get("background.neutral"),
                              borderColor: Palette.get("background.neutral"),
                              isFilled: true,
                              isOutline: true,
                              suffixIcon: item["label"] ==
                                      "How is this person related to you?"
                                  ? UnconstrainedBox(
                                      child: Helpers.fetchIcons(
                                          "caret-down", "regular",
                                          size: 18.0))
                                  : null),
                          style: GoogleFonts.nunito(
                              color: Palette.get("text.secondary"),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                          onTap: () async {
                            if (item["label"] !=
                                "How is this person related to you?") {
                              return;
                            }
                            final type = await Sheets.showSortBy(
                                relationController.text,
                                title: "Select relationship",
                                items: relationships);
                            if (type.isNotEmpty) {
                              final selectedType = relationships[
                                  num.tryParse(type)?.toInt() ?? 0];
                              relationController.text =
                                  selectedType["name"].toString();
                              setState(() {
                                relation = selectedType["code"].toString();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 5,
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
    );
  }
}
