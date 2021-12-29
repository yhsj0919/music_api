import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:music_api/utils/utils.dart';
import 'package:universal_io/io.dart';

class Http {
  static Future<HttpClientResponse> get(String url, {Map<String, dynamic>? params, Map<String, String>? headers}) {
    if (kIsWeb) {
      url = "http://localhost:3001/" + url;
      if (headers?.containsKey("Cookie") == true || headers?.containsKey("cookie") == true) {
        var cookie = headers?["Cookie"] ?? headers?["cookie"];
        headers?["http_token"] = cookie ?? "";
      }
    }
    url += "${params?.isNotEmpty == true ? "?" : ""}${toParamsString(LinkedHashMap.from(params ?? {}))}";
    return HttpClient().getUrl(Uri.parse(url)).then((request) {
      headers?.forEach(request.headers.add);
      return request.close();
    });
  }

  static Future<HttpClientResponse> post(String url, {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    if (kIsWeb) {
      url = "http://localhost:3001/" + url;
      if (headers?.containsKey("Cookie") == true || headers?.containsKey("cookie") == true) {
        var cookie = headers?["Cookie"] ?? headers?["cookie"];
        headers?["http_token"] = cookie ?? "";
      }
    }
    return HttpClient().postUrl(Uri.parse(url)).then((request) {
      headers?.forEach(request.headers.add);
      request.headers.add('Content-Type', 'application/x-www-form-urlencoded');
      request.write(Uri(queryParameters: (params ?? {}).map((key, value) => MapEntry(key, value.toString())).cast()).query);
      return request.close();
    });
  }
}
