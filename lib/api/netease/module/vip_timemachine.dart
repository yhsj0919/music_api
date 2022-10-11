part of '../netease.dart';

// 黑胶时光机
Future<Answer> _vipTimemachine(Map params, List<Cookie> cookie) {
  var data = {};
  if (params["startTime"] != null && params["endTime"] != null) {
    data["startTime"] = params["startTime"];
    data["endTime"] = params["endTime"];
    data["type"] =1;
    data["limit"] =params["limit"]??60;
  }

  return request(
    'POST',
    'https://music.163.com/weapi/vipmusic/newrecord/weekflow',
    {"id": params["id"]},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
