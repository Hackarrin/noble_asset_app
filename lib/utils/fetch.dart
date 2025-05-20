import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:http/retry.dart';
import 'helpers.dart';
import 'defaults.dart';
import 'package:mime/mime.dart';

class Fetch {
  late Uri uri;
  Map params;
  String method = "post";
  bool isFormData = false;
  bool noToken = false;
  String? file = "";
  List<String>? files = [];

  Fetch(String url, this.params,
      {this.method = "post",
      this.isFormData = false,
      this.noToken = false,
      this.file,
      this.files}) {
    uri = Uri.parse(url);
  }

  Future<Map> load() async {
    http.Response response;
    final client = RetryClient(http.Client());
    String userKey = await Helpers.readPref(Defaults.userid);
    Map<String, String> headers = {};
    if (!isFormData) {
      headers["Content-type"] = 'application/json; charset=UTF-8';
    }
    if (userKey.isNotEmpty && !noToken) {
      headers["Authorization"] = "Bearer $userKey";
    }
    try {
      switch (method) {
        case "post":
          {
            response = await client.post(uri,
                body: jsonEncode(params), headers: headers);
            break;
          }
        case "file":
          {
            final request = http.MultipartRequest("POST", uri);
            request.headers.addAll({"Authorization": "Bearer $userKey"});
            if (params.isNotEmpty) {
              request.fields.addAll(params.map(
                  (key, value) => MapEntry(key.toString(), value!.toString())));
            }
            final mimeTypeData =
                lookupMimeType(file!, headerBytes: [0xFF, 0xD8])?.split('/');
            request.files.add(await http.MultipartFile.fromPath(
                "customer_photo", file!,
                contentType: MediaType(mimeTypeData![0], mimeTypeData[1])));
            final res = await request.send();
            response = await http.Response.fromStream(res);
            break;
          }
        case "files":
          {
            final request = http.MultipartRequest("POST", uri);
            request.headers.addAll({"Authorization": "Bearer $userKey"});
            if (params.isNotEmpty) {
              request.fields.addAll(params.map(
                  (key, value) => MapEntry(key.toString(), value!.toString())));
            }

            for (final file in files!) {
              final mimeTypeData =
                  lookupMimeType(file, headerBytes: [0xFF, 0xD8])?.split('/');
              request.files.add(await http.MultipartFile.fromPath(
                  "product_photos[]", file,
                  contentType: MediaType(mimeTypeData![0], mimeTypeData[1])));
            }
            final res = await request.send();
            response = await http.Response.fromStream(res);
            break;
          }
        default:
          response = await client.get(uri, headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': "Bearer $userKey"
          });
      }
      var body = jsonDecode(response.body);
      if (body.containsKey("status")) {
        if (body["status"] == "invalid_token" ||
            body["status"] == "userid_expired" ||
            body["status"] == "userid_error") {
          //logout
          //Helpers.logoutAccount();
        }
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }
}
