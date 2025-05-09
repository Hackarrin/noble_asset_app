import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'palette.dart';

class WebAccess extends StatefulWidget {
  final String url;
  final String title;
  bool isEmbedded = false;

  WebAccess(
      {super.key, this.title = "", required this.url, this.isEmbedded = false});

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebAccess> {
  var shop = {};
  var title = "";
  var isLoading = true;
  var progress = 0.0;

  Future<void> check() async {
    setState(() {
      title = widget.title;
    });
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.get("background.paper"),
        appBar: widget.isEmbedded
            ? null
            : AppBar(
                leading: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    radius: 20,
                    foregroundColor: Palette.get("background.paper"),
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          "assets/images/icon.png",
                          height: 40.0,
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                toolbarHeight: 70,
                title: (title.isNotEmpty
                    ? Widgets.buildText(
                        title,
                        context,
                        color: 'text.secondary',
                        isBold: true,
                        size: 16.0,
                      )
                    : const SizedBox(height: 0.0)),
                elevation: 0,
                backgroundColor:
                    Palette.getColor(context, "background", "default"),
                foregroundColor: Palette.getColor(context, "text", "disabled"),
                actions: [
                  Tooltip(
                    message: 'Close Browser',
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,
                          size: 25.0,
                          color: Palette.getColor(context, "main", "primary")),
                    ),
                  ),
                ],
              ),
        body: Column(
          children: [
            if (isLoading)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Palette.getColor(context, "text", "disabled"),
                valueColor: AlwaysStoppedAnimation<Color>(
                    Palette.getColor(context, "main", "primary")),
              ),
            Expanded(
              child: InAppWebView(
                onTitleChanged: (view, value) {
                  setState(() {
                    title = value ?? "";
                  });
                },
                onLoadStart: (view, uri) {
                  setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (view, uri) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onProgressChanged: (view, value) {
                  setState(() {
                    progress = value / 100;
                  });
                },
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              ),
            )
          ],
        ));
  }
}
