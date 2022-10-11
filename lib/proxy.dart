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

    if (path == "favicon.ico") {
      request.response.statusCode = 200;
      request.response.close();
    } else if (path == "") {
      request.response.statusCode = 200;
      request.response.write('该服务用于简单的跨域请求，自定义请求头请加入“x-proxy-”前缀，使用方式"http://127.0.0.1:3001/http://www.baidu.com"');
      request.response.close();
    } else {
      String host = Uri.parse(path).origin;
      var header = <String, String>{};
      request.headers.forEach((name, values) {
        if (name.startsWith("x-proxy-")) {
          header[name.replaceFirst("x-proxy-", "")] = values.first;
        }
      });
      header["referer"] = host;
      header["origin"] = host;

      HttpClientResponse resp;

      if (request.method == "GET" || request.method == "OPTIONS") {
        params = request.uri.queryParameters;
        resp = await Http.get(path, params: params, headers: header);
      } else {
        final stringData = await request.single.then(utf8.decode);
        params = paramsToMap(Uri.decodeQueryComponent(stringData));

        ///   final stringData = await response.transform(utf8.decoder).join();
        resp = await Http.post(path, params: params, headers: header);
      }

      if (kDebugMode) {
        print(resp);
      }

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
