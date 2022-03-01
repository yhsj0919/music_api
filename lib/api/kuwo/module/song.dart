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
  return _get(
    "http://antiserver.kuwo.cn/anti.s",
    params: {
      "rid": params["rid"],
      "format": params["format"],
      "response": "url",
      "type": "convert_url3",
      "br": "320kmp3",
    },
    cookie: cookie,
  );
}

///备用，不支持收费音乐
Future<Answer> _playUrl2(Map params, List<Cookie> cookie) {
  //http://antiserver.kuwo.cn/anti.s?format=mp3&rid=228908&response=url&type=convert_url3
  return _get(
    "http://www.kuwo.cn/api/v1/www/music/playUrl",
    params: {
      "mid": params["mid"],
      "type": params["type"] ?? "music",
    },
    cookie: cookie,
  );
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
