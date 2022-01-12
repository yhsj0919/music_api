part of '../netease.dart';

//歌曲可用性
Future<Answer> _checkMusic(Map params, List<Cookie> cookie) {
  final data = {
    'ids': '[${params['id']}]',
    'br': int.parse(params['br'] ?? 999000),
  };
  return request(
    'POST',
    'https://music.163.com/weapi/song/enhance/player/url',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  ).then((response) {
    var playable = false;
    if (response.data['code'] == 200) {
      if (response.data['data'][0].code == 200) {
        playable = true;
      }
    }
    if (playable) {
      response = response.copy(data: {'success': true, 'message': 'ok'});
      return response;
    } else {
      return response
          .copy(code: 404, data: {'success': false, 'message': '亲爱的,暂无版权'});
    }
  });
}
