import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:music_api/utils/utils.dart';
import 'package:universal_io/io.dart';

class Http {
  static Future<HttpClientResponse> get(String url, {Map<String, dynamic>? params, Map<String, String>? headers, bool followRedirects = true, int timeout = 5}) async {
    if (kIsWeb) {
      var tmp = <String, String>{};
      url = "http://localhost:3001/$url";
      headers?.forEach((key, value) {
        tmp["x-proxy-$key"] = value;
      });
      headers = tmp;
    }
    url += "${params?.isNotEmpty == true ? "?" : ""}${toParamsString(LinkedHashMap.from(params ?? {}))}";
    if (kDebugMode) {
      print(url);
    }

    final http = HttpClient();
    http.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    var uri = Uri.parse(url);
    var request = await http.getUrl(uri);
    request.followRedirects = false;
    headers?.forEach(request.headers.add);
    (headers?[HttpHeaders.cookieHeader]?.split(";"))?.where((element) => element.contains("=")).map((e) => Cookie.fromSetCookieValue(e)).forEach(request.cookies.add);
    var response = await request.close();
    if (followRedirects) {
      while (response.isRedirect) {
        response.drain();
        final location = response.headers.value(HttpHeaders.locationHeader);
        if (location != null) {
          uri = uri.resolve(location);
          request = await http.getUrl(uri);
          // Set the body or headers as desired.
          headers?.forEach(request.headers.add);
          (headers?[HttpHeaders.cookieHeader]?.split(";"))?.where((element) => element.contains("=")).map((e) => Cookie.fromSetCookieValue(e)).forEach(request.cookies.add);
          request.followRedirects = false;
          response = await request.close();
        }
      }
    }

    return Future.value(response);
  }

  static Future<HttpClientResponse> post(String url, {Map<String, dynamic>? params, Map<String, String>? headers, bool followRedirects = true, int timeout = 5}) async {
    if (kIsWeb) {
      url = "http://localhost:3001/" + url;
      var tmp = <String, String>{};
      url = "http://localhost:3001/" + url;
      headers?.forEach((key, value) {
        tmp["x-proxy-$key"] = value;
      });
      headers = tmp;
    }
    var http = HttpClient();
    http.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    return http.postUrl(Uri.parse(url)).then((request) {
      request.followRedirects = followRedirects;
      headers?.forEach(request.headers.add);
      request.headers.add('Content-Type', 'application/x-www-form-urlencoded');
      request.write(Uri(queryParameters: (params ?? {}).map((key, value) => MapEntry(key, value.toString())).cast()).query);
      return request.close().timeout(Duration(seconds: timeout));
    });
  }

  static Future<HttpClientResponse> request(String url, {required String method, Map<String, dynamic>? params, Map<String, String>? headers}) async {
    if (method == "POST") {
      return post(url, headers: headers, params: params);
    } else {
      return get(url, headers: headers, params: params);
    }
  }
}
