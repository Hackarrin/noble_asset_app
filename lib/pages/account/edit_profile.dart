import 'package:afritas/utils/helpers.dart';
import 'package:afritas/utils/widget.dart';
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
  final profile = {
    "fname": "Olamide",
    "lname": "Owoeye",
    "email": "info@useafritas.com",
    "phone": "091833383",
    "dateAdded": "2025-01-01",
    "isVerified": "1",
    "status": "1",
    "photo": "",
    "gender": "M",
    "dob": "1995-01-02",
    "address": "ibeju Lekki Lagos Nigeria"
  };
  var isEditing = -1;
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fNameController.text = profile["fname"].toString();
      lNameController.text = profile["lname"].toString();
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
                          "label": "First Name",
                          "controller": fNameController
                        };
                        break;
                      case 1:
                        item = {
                          "label": "Last Name",
                          "controller": lNameController
                        };
                        break;
                      case 2:
                        item = {
                          "label": "Mobile Number",
                          "controller": phoneController
                        };
                        break;
                      case 3:
                        item = {
                          "label": "Email",
                          "controller": emailController
                        };
                        break;
                      case 4:
                        item = {
                          "label": "Address",
                          "controller": addressController
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
                            readOnly: isEditing == index,
                            decoration: Widgets.inputDecoration("",
                                color: Color(0xFFF4F4F4),
                                isFilled: true,
                                isOutline: true,
                                suffixIcon: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditing = index;
                                      });
                                    },
                                    child: Widgets.buildText("Edit", context,
                                        size: 13.0,
                                        weight: 400,
                                        color: "main.primary"))),
                            style: GoogleFonts.poppins(
                                color: Color(0xCC757575),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
