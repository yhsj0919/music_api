part of '../audiomack.dart';

///播放地址
Future<Answer> _playUrl(Map params, List<Cookie> cookie) {
  return _get(
    "https://api.audiomack.com/v1/music/play/${params["id"]}",
    params: {
      "environment": "desktop-web",
      "hq": "true",
      "oauth_consumer_key": "audiomack-js",
      "oauth_nonce": nonce(32),
      "oauth_signature_method": "HMAC-SHA1",
      "oauth_timestamp": DateTime.now().millisecondsSinceEpoch~/1000,

      "oauth_version": "1.0",
      "section": "/search",
    },
    cookie: cookie,
  );
}
