part of '../baidu.dart';

//精选视频
Future<Answer> _videoList(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/video/list",
    params: LinkedHashMap.of({
      "pageNo": params['page'] ?? 1,
      "pageSize": params['size'] ?? 20,
    }),
    cookie: cookie,
  );
}

//视频详情
Future<Answer> _videoInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/video/info",
    params: LinkedHashMap.of({
      "assetCode": params['assetCode'],
      "rate": params['rate'] ?? '720',
    }),
    cookie: cookie,
  );
}

//热门视频、视频推荐
Future<Answer> _videoRecommend(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/video/recommend",
    params: LinkedHashMap.of({}),
    cookie: cookie,
  );
}

//视频下载
Future<Answer> _videoDownload(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/video/download",
    params: LinkedHashMap.of({
      "assetCode": params['assetCode'],
      "rate": params['rate'] ?? '720',
    }),
    cookie: cookie,
  );
}
