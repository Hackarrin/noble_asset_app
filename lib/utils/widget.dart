import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

class Widgets {
  static Widget buildText(String text, BuildContext context,
      {size,
      color = "text.primary",
      isMedium = false,
      isBold = false,
      isCenter = false,
      isRight = false,
      isUnderlined = false,
      weight = 400,
      fontFamily,
      lines = 0}) {
    final colorSplit = color.toString().split(".");
    var palette = Palette.getColor(context, "text", "primary");
    if (colorSplit.length == 2) {
      palette = Palette.getColor(context, colorSplit[0], colorSplit[1]);
    }
    return Text(
      text,
      style: GoogleFonts.nunito(
          fontSize: size ?? (isBold ? 24.0 : (isMedium ? 16.0 : 13.0)),
          fontWeight: isBold
              ? FontWeight.w700
              : (isMedium
                  ? FontWeight.w600
                  : (weight == 500 ? FontWeight.w500 : FontWeight.w400)),
          decoration: isUnderlined ? TextDecoration.underline : null,
          decorationColor: isUnderlined ? palette : null,
          color: palette),
      maxLines: lines > 0 ? lines : null,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: isCenter
          ? TextAlign.center
          : (isRight ? TextAlign.end : TextAlign.start),
    );
  }

  static ButtonStyle buildButton(BuildContext context,
      {radius = 15.0,
      background,
      color,
      horizontal = 0.0,
      sideColor,
      vertical = 0.0}) {
    return ElevatedButton.styleFrom(
      foregroundColor: color ?? Colors.white,
      backgroundColor: background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: sideColor ?? Colors.transparent)),
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    );
  }

  static InputDecoration inputDecoration(text,
      {color = Colors.white,
      borderColor = Colors.white,
      hintColor = Colors.white,
      icon,
      prefixIcon,
      isOutline = false,
      radius = 10.0,
      hint,
      isFloating = false,
      isFilled = false,
      suffixIcon}) {
    return InputDecoration(
        icon: icon,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: isOutline
            ? OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: borderColor),
                borderRadius: BorderRadius.circular(radius))
            : UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
        focusedBorder: isOutline
            ? OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: borderColor),
                borderRadius: BorderRadius.circular(radius))
            : UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
        border: isOutline
            ? OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: borderColor),
                borderRadius: BorderRadius.circular(radius),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
        labelStyle: TextStyle(
          color: borderColor,
        ),
        hintStyle: TextStyle(
          color: hintColor,
        ),
        hintText: hint,
        labelText: text.isEmpty ? null : text,
        filled: isFilled,
        hoverColor: color,
        focusColor: color,
        fillColor: color,
        floatingLabelBehavior: isFloating
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto);
  }

  static CustomLayoutOption customLayout(length, double width, {offset = 0.0}) {
    return CustomLayoutOption(startIndex: -1, stateCount: length)
      ..addTranslate(List.generate(length, (i) {
        return Offset((i - 1) * (width - offset), 0);
      }));
  }
}

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
