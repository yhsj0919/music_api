import 'dart:convert';

import 'package:universal_io/io.dart';

class Answer {
  final int code;
  final dynamic data;
  final String msg;
  final List<Cookie> cookie;

  const Answer({this.code = 200, this.data = const {'code': 500, 'msg': 'server error'}, this.msg = "操作成功", this.cookie = const []});

  Answer copy({int? code, dynamic data, String? msg, List<Cookie>? cookie}) {
    return Answer(code: code ?? this.code, data: data ?? this.data, msg: msg ?? this.msg, cookie: cookie ?? this.cookie);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = data;
    map['cookie'] = cookie;
    return map;
  }

  @override
  String toString() {
    return json.encode({
      "code": code,
      "msg": msg,
      "data": data,
    });
  }
}
