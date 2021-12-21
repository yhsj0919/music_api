part of '../migu.dart';

/*
* Mv资源信息
 */
Future<Answer> _mvInfo(Map params, List<Cookie> cookie) {
  final data = {
    "resourceId": params['mvId'],
    "resourceType": 'D',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/resourceinfo.do",
    params: data,
    cookie: cookie,
  );
}

/*
* MV播放地址
* 先在上面的资源接口拿到播放地址,然后在这里获取真实的播放地址
 */
Future<Answer> _mvPlayUrl(Map params, List<Cookie> cookie) {
  final data = {
    "concertId": params['contentId'],
    "mvContentId": params['contentId'],
    "mvCopyrightId": params['mvCopyrightId'],
    "format": params['format'],
    "size": params['size'],
    "type": params['type'] ?? '01',
    "url": params['url']
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v1.0/content/mvplayinfo.do",
    params: data,
    cookie: cookie,
  );
}

/*
* MV推荐
 */
Future<Answer> _mvRec(Map params, List<Cookie> cookie) {
  final data = {
    "pageNumber": params['page'] ?? '1',
    "resourceId": params['mvId'],
    "resourceType": params['resourceType'] ?? 'D',
  };
  return _get(
    "https://app.c.nf.migu.cn/MIGUM2.0/v3.0/content/recommend-mv",
    params: data,
    cookie: cookie,
  );
}
