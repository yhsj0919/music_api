part of '../kuwo.dart';

Future<Answer> _songNew(Map params, List<Cookie> cookie) {
  return _get(
    "http://mobi.kuwo.cn/mobiweb.s",
    params: {
      "prod": "kwplayer_ar_10.0.7.0",
      "type": "zuixinyinyue",
    },
    cookie: cookie,
  );
}

///播放地址
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  //http://antiserver.kuwo.cn/anti.s?format=mp3&rid=228908&response=url&type=convert_url3&br=320kmp3
  //https://antiserver.kuwo.cn/anti.s?type=convert_url&format=mp3&response=url&rid=157767
  return _get(
    "http://antiserver.kuwo.cn/anti.s",
    params: {
      "rid": params["rid"],
      "format": params["format"] ?? "mp3",
      "response": "url",
      "type": "convert_url",
      "br": "320kmp3",
    },
    cookie: cookie,
  );
}

///备用，不支持收费音乐
Future<Answer> _playUrl2(Map params, List<Cookie> cookie) {
  return _get(
    "http://www.kuwo.cn/api/v1/www/music/playUrl",
    params: {
      "mid": params["mid"],
      "type": params["type"] ?? "music",
    },
    cookie: cookie,
  );
}

Future<Answer> _playUrl3(Map params, List<Cookie> cookie) {
  //http://antiserver.kuwo.cn/anti.s?type=convert_url&format=mp3&response=url&rid=MUSIC_
  return _get(
    "http://antiserver.kuwo.cn/anti.s",
    params: {
      "mid": "MUSIC_${params["mid"]}",
      "type": "convert_url3",
      "format": "mp3",
      "response": "url",
    },
    cookie: cookie,
  );
}

Future<Answer> _playUrl4(Map params, List<Cookie> cookie) {
  //https://m.kuwo.cn/newh5app/api/mobile/v2/music/src/261439967?httpsStatus=1&reqId=ca9e5ee5fef657bed3a5c75e0c487471
  return _get(
    "https://m.kuwo.cn/newh5app/api/mobile/v2/music/src/${params["mid"]}",
    params: {
      "httpsStatus": 1,
    },
    cookie: cookie,
  );
}

Future<Answer> _playUrl5(Map params, List<Cookie> cookie) async {
  //code from https://github.com/59799517/flutter_sqmusic
  //    String s = "user=e3cc098fd4c59ce2&android_id=e3cc098fd4c59ce2&prod=kwplayer_ar_9.3.1.3&corp=kuwo&newver=2&vipver=9.3.1.3&source=kwplayer_ar_9.3.1.3_qq.apk&p2p=1&notrace=0&type=convert_url2&br=${brvalue}&format=flac|mp3|aac&sig=0&rid=${musicId}&priority=bitrate&loginUid=435947810&network=WIFI&loginSid=1694167478&mode=download&uid=658048466";
  //  br属性
  //  static String KuWo_mp3_128="128kmp3";
  //  static String KuWo_mp3_192="192kmp3";
  //  static String KuWo_mp3_320="320kmp3";
  //  static String KuWo_ape_1000="1000kape";
  //  static String KuWo_flac_2000="2000kflac";
  String s = "corp=kuwo&p2p=1&type=convert_url2&br=320kmp3&format=flac|mp3|aac&sig=0&rid=${params["mid"]}&priority=bitrate";
  // String s = "user=e3cc098fd4c59ce2&android_id=e3cc098fd4c59ce2&prod=kwplayer_ar_9.3.1.3&corp=kuwo&newver=2&vipver=9.3.1.3&source=kwplayer_ar_9.3.1.3_qq.apk&p2p=1&notrace=0&type=convert_url2&br=2000kflac&format=flac|mp3|aac&sig=0&rid=${params["mid"]}&priority=bitrate&loginUid=435947810&network=WIFI&loginSid=1694167478&mode=download&uid=658048466";
  var encode = utf8.encode(s);
  var encrypt2 = KuwoDES.encrypt2(encode, encode.length, KuwoDES.SECRET_KEY, KuwoDES.SECRET_KEY.length);
  var data = const Base64Codec().encode(encrypt2);

  return _get(
    "http://nmobi.kuwo.cn/mobi.s?f=kuwo&q=$data",
    // params: {
    //   "f": "kuwo",
    //   "q": outstr,
    // },
    cookie: cookie,
  ).then((value) {
    try {
      var data = value.data.toString();
      var ss = data.split("\r\n").map((e) {
        var kv = e.split("=");
        return MapEntry(kv[0], kv[1]);
      }).toList();
      var resp = Map.fromEntries(ss);
      return value.copy(data: resp);
    } catch (e) {
      return value;
    }
  });
}

///歌词
Future<Answer> _songLrc(Map params, List<Cookie> cookie) {
  //https://m.kuwo.cn/newh5/singles/songinfoandlrc?musicId=207668534
  return _get(
    "https://m.kuwo.cn/newh5/singles/songinfoandlrc",
    params: {
      "musicId": params["rid"],
    },
    cookie: cookie,
  ).then((value) {
    var lyric = value.data["data"]?["lrclist"] as List?;

    return value.copy(data: lyric?.map((e) => "[${_formatTime(e["time"])}]${e["lineLyric"]}").join("\n"));
  });
}

String _formatTime(String time) {
  double value = double.parse(time);
  var data = value.toStringAsFixed(2);

  var totalSecond = data.split(".")[0];
  var mill = data.split(".")[1];

  var minute = int.parse(totalSecond) ~/ 60;
  var second = int.parse(totalSecond) % 60;

  return "${_prefixInt(minute)}:${_prefixInt(second)}.$mill";
}

String _prefixInt(int num) {
  if (num < 10) {
    return "0$num";
  } else {
    return "$num";
  }
}
