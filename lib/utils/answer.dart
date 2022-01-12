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
}
