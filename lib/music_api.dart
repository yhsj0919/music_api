import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:music_api/api/baidu/baidu.dart';
import 'package:music_api/api/kugou/kugou.dart';
import 'package:music_api/api/kuwo/kuwo.dart';
import 'package:music_api/api/migu/migu.dart';
import 'package:music_api/api/my_free_mp3/my_free_mp3.dart';
import 'package:music_api/api/qq/qq.dart';
import 'package:music_api/api/utils/answer.dart';

class MusicApi {
  MusicApi._();

  static HttpServer? _server;

  static Future startServer({address = "0.0.0.0", int port = 3000}) {
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
    Answer? answer;

    String path = request.uri.path;

    Future<Answer> Function(String path, {Map? params, List<Cookie> cookie})? api;
    String? url;

    // if (path.startsWith("/netease")) {
    //   answer = await cloudMusicApi(path.replaceAll("/netease", ""), parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
    //     print(e.toString());
    //     print(s.toString());
    //     return const Answer();
    //   });
    // } else
    if (path.startsWith("/baidu")) {
      api = Baidu.api;
      url = path.replaceAll("/baidu", "");
    } else if (path.startsWith("/kugou")) {
      api = KuGou.api;
      url = path.replaceAll("/kugou", "");
    } else if (path.startsWith("/kuwo")) {
      api = KuWo.api;
      url = path.replaceAll("/kuwo", "");
    } else if (path.startsWith("/migu")) {
      api = MiGu.api;
      url = path.replaceAll("/migu", "");
    } else if (path.startsWith("/qq")) {
      api = QQ.api;
      url = path.replaceAll("/qq", "");
    } else if (path.startsWith("/mfm")) {
      api = MyFreeMp3.api;
      url = path.replaceAll("/mfm", "");
    }

    answer = await api?.call(url ?? "", params: request.uri.queryParameters, cookie: request.cookies).catchError(_error) ??
        const Answer().copy(body: {'code': 500, 'msg': '仅支持“/baidu”、“/kugou”、“/kuwo”、“/migu”、“/qq”、“/mpm”开头的接口'});
    request.response.statusCode = 200;
    request.response.cookies.addAll(answer.cookie);
    request.response.write(json.encode(answer.body));
    request.response.close();
    if (kDebugMode) {
      print("request[${answer.status}] : ${request.uri}");
    }
  }

  static Future<Answer> _error(e, s) {
    if (kDebugMode) {
      print(e.toString());
      print(s.toString());
    }
    return Future.value(const Answer().copy(body: {"code": 500, "msg": e.toString()}));
  }
}
