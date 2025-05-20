import 'package:cribsfinder/utils/alert.dart';
import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/jwt.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/palette.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> profile = {};
  var isEditing = -1;
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  void handleSubmit(type, value) async {
    try {
      Alert.showLoading(context, "Updating...");
      await JWT.updateSettings(value, type);
      Alert.hideLoading(context);
      Alert.show(context, "", "Profile updated successfully!", type: "success");
    } catch (err) {
      Alert.show(context, "", err.toString(), type: "error");
    }
    Alert.hideLoading(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final details = await Helpers.getProfile();
      setState(() {
        profile = details["user"] ?? {};
      });
      fNameController.text = profile["name"].toString();
      emailController.text = profile["email"].toString();
      phoneController.text = profile["phone"].toString();
      addressController.text = profile["address"].toString();
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
        title: Widgets.buildText("Edit Profile", context, isMedium: true),
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
                    var item = {};
                    switch (index) {
                      case 0:
                        item = {
                          "label": "Full Name",
                          "controller": fNameController,
                          "value": "name",
                          "values": ["name"],
                        };
                        break;
                      case 1:
                        item = {
                          "label": "Mobile Number",
                          "controller": phoneController,
                          "values": ["phone"],
                          "value": "phone",
                        };
                        break;
                      case 2:
                        item = {
                          "label": "Email",
                          "controller": emailController,
                          "value": "email",
                          'values': ["email"],
                        };
                        break;
                      case 3:
                        item = {
                          "label": "Address",
                          "controller": addressController,
                          "values": ["address"],
                          "value": "address",
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
                            readOnly: isEditing != index,
                            autofocus: isEditing == index,
                            decoration: Widgets.inputDecoration("",
                                color: Color(0xFFF4F4F4),
                                isFilled: true,
                                isOutline: true,
                                suffixIcon: isEditing == index
                                    ? null
                                    : TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditing = index;
                                          });
                                        },
                                        child: Widgets.buildText(
                                            "Edit", context,
                                            size: 13.0,
                                            weight: 400,
                                            color: "main.primary"))),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                handleSubmit(item["value"].toString(),
                                    {item["value"].toString(): value});
                              } else {
                                Alert.show(context, "",
                                    "Pleae enter a valid ${item["value"].toString()} to proceed.");
                              }
                            },
                            style: GoogleFonts.nunito(
                                color: Color(0xCC757575),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
