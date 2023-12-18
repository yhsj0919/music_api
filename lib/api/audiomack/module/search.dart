part of '../audiomack.dart';

///搜索
Future<Answer> _search(Map params, List<Cookie> cookie) {
  return _get(
    "https://api.audiomack.com/v1/search",
    params: {
      "limit": params['size'] ?? 20,
      "oauth_consumer_key": "audiomack-js",
      "oauth_nonce": nonce(32),
      "oauth_signature_method": "HMAC-SHA1",
      "oauth_timestamp": DateTime.now().millisecondsSinceEpoch~/1000,
      "oauth_version": "1.0",
      "page": params['page'] ?? 1,
      "q": params['keyWord'],
      "show": "music",
      "sort": "popular",
    },
    cookie: cookie,
  );
}
