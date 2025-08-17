import 'package:nobleassets/utils/helpers.dart';
import 'package:nobleassets/utils/palette.dart';
import 'package:nobleassets/utils/widget.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key,
      required this.searchPage,
      this.hint = "Search location",
      this.profile = const {}});

  final String searchPage;
  final String hint;
  final Map<String, dynamic> profile;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      if (profile.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 50.0,
          children: [
            Expanded(
              child: Row(
                children: [
                  Helpers.getProfilePhoto(context,
                      height: 50.0, profile: profile),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText(profile["name"].toString(), context,
                            color: "text.white", isMedium: true),
                        Widgets.buildText(
                            profile["address"].toString(), context,
                            color: "text.white"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor:
                    Palette.getColor(context, "background", "button"),
                radius: 20.0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Helpers.fetchIcons(
                        "bell-notification-social-media",
                        "solid",
                        color: "text.white",
                        size: 20.0,
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 22.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.getColor(context, "error", "main"),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: SizedBox(
                          width: 8,
                          height: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      const SizedBox(height: 40.0),
      Align(
        alignment: Alignment.bottomCenter,
        child: TextField(
          readOnly: true,
          decoration: Widgets.inputDecoration("",
              isOutline: true,
              color: Palette.getColor(context, "background", "paper"),
              borderColor: Palette.getColor(context, "background", "paper"),
              hint: hint,
              prefixIcon: UnconstrainedBox(
                child: Helpers.fetchIcons(
                  "search",
                  "regular",
                  color: "main.primary",
                  size: 20.0,
                ),
              ),
              hintColor: Palette.getColor(context, "text", "secondary"),
              radius: 40.0,
              isFilled: true,
              isFloating: true),
          style: TextStyle(
              color: Palette.getColor(context, "text", "secondary"),
              decoration: TextDecoration.none,
              decorationThickness: 0),
          onTap: () {
            Navigator.pushNamed(context, searchPage);
          },
        ),
      ),
    ]);
  }
}
