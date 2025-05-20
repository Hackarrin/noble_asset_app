import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

class LoaderDialog extends StatefulWidget {
  final Curve curve;
  final String title;
  final String subtitle;

  const LoaderDialog(
      {Key? key,
      this.curve = Curves.bounceOut,
      this.title = "",
      this.subtitle = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoaderDialogState();
  }
}

class LoaderDialogState extends State<LoaderDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation tween;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    tween = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0,
        duration: const Duration(milliseconds: 300), curve: widget.curve);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoaderDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfChildren = [
      SizedBox(
        width: double.infinity,
        height: 4.0,
        // child: new Center(
        child: LinearProgressIndicator(
          backgroundColor: Palette.getColor(context, "text", "secondary"),
          valueColor: AlwaysStoppedAnimation<Color>(
              Palette.getColor(context, "main", "secondary")),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // ),
      ),
      const SizedBox(height: 14.0)
    ];

    if (widget.title.isNotEmpty) {
      listOfChildren.add(Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Widgets.buildText(widget.title, context,
              size: 16.0,
              isBold: true,
              color: "text.white",
              isCenter: true,
              lines: 2)));
    }

    if (widget.subtitle.isNotEmpty) {
      listOfChildren.add(Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 40, right: 40),
          child: Widgets.buildText(widget.subtitle, context,
              size: 15.0,
              isBold: true,
              color: Theme.of(context).brightness == Brightness.dark
                  ? "text.secondary"
                  : "text.disabled",
              isCenter: true,
              lines: 2)));
    }

    return Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (c, w) {
              return ScaleTransition(
                scale: tween as Animation<double>,
                child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: listOfChildren,
                        ),
                      ),
                    )),
              );
            }));
  }
}

abstract class Loader {
  static Curve showCurve = Curves.bounceOut;
  static bool isLoading = false;

  static void hide(BuildContext context) {
    if (isLoading) {
      if (Navigator.canPop(context)) {
        Navigator.of(context, rootNavigator: false).pop();
      }
      isLoading = false;
    }
  }

  static void show(BuildContext context, title, subtitle) {
    isLoading = true;
    showDialog(
        barrierDismissible: false,
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.black26,
              body: LoaderDialog(
                  curve: showCurve, title: title, subtitle: subtitle));
        });
  }
}
