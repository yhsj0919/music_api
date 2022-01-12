import 'dart:convert';

import 'package:music_api/api/baidu/baidu.dart';
import 'package:music_api/utils/answer.dart';

class MusicApi {
  MusicApi._();

  static Future<Answer> banner() async {
    Answer baidu = await Baidu.banner();
    var baiduBanner = baidu.data["data"]?["result"];
    print(json.encode(baiduBanner));

    return Answer(data: baiduBanner);
  }
}
