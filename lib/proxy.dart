import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:music_api/http/http.dart';
import 'package:music_api/utils/utils.dart';
import 'package:universal_io/io.dart';

class Proxy {
  Proxy._();

  static HttpServer? _server;

  static Future startServer({address = "localhost", int port = 3000}) {
    return HttpServer.bind(address, port, shared: true).then((tmpServer) {
      if (kDebugMode) {
        print("start listen at: http://$address:$port");
      }
      tmpServer.listen((request) {
        _handleRequest(request);
      });
      _server = tmpServer;
      return;
    });
  }

  static Future? stopServer() {
    return _server?.close().then((value) {
      _server = null;
    });
  }

  static String ip() {
    return _server?.address.host ?? "0.0.0.0";
  }

  static String port() {
    return '${_server?.port ?? "NA"}';
  }

  static void _handleRequest(HttpRequest request) async {
    request.response.headers.add("Access-Control-Allow-Origin", "*");
    request.response.headers.add("Access-Control-Allow-Headers", "*");
    request.response.headers.add("Access-Control-Allow-Credentials", true);
    request.response.headers.add("withCredentials", true);

    String path = request.uri.path;
    Map<String, String> params;

    if (path.startsWith("/")) {
      path = path.replaceFirst("/", "");
    }
    var header = <String, String>{};
    request.headers.forEach((name, values) {
      if (name == "http_token") {
        header["cookie"] = values.first;
      } else {
        header[name] = values.first;
      }
    });

    var cookie = header["http_token"];

    if (cookie != null) {
      var cookies = Cookie.fromSetCookieValue(cookie);
      print(cookies);
    }
    if (path == "favicon.ico") {
      request.response.statusCode = 200;
      request.response.close();
    } else {
      header.remove("host");
      header.remove("connection");
      header.remove("cache-control");
      header.remove("accept-language");
      // header.remove("content-length");
      // header.remove("sec-fetch-dest");
      // header.remove("sec-ch-ua-mobile");
      // header.remove("sec-fetch-mode");
      // header.remove("origin");
      // header.remove("sec-ch-ua-platform");
      // header.remove("referer");
      // header.remove("sec-fetch-site");
      // header.remove("sec-ch-ua");
      // header.remove("accept-encoding");
      // header.remove("accept");


      print(header);

      HttpClientResponse resp;
      print(">>>>>>>>${request.method}>>>>>>>");
      if (request.method == "GET") {
        params = request.uri.queryParameters;
        resp = await Http.get(path, params: params, headers: header);
      } else {
        final stringData = await request.single.then(utf8.decode);
        params = paramsToMap(Uri.decodeQueryComponent(stringData));

        ///   final stringData = await response.transform(utf8.decoder).join();
        resp = await Http.post(path, params: params, headers: header);
      }

      print(resp);

      String content = await resp.transform(utf8.decoder).join();
      request.response.statusCode = 200;
      request.response.cookies.addAll(resp.cookies);
      request.response.write(content);
      request.response.close();
      if (kDebugMode) {
        print("request[${200}] : ${request.uri}");
      }
    }
  }
}
