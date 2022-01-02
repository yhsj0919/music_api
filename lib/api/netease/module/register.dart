part of '../netease.dart';

//注册账号
Future<Answer> _registerCellphone(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  final data = {
    'captcha': params['captcha'],
    'phone': params['phone'],
    'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(params['password'])).bytes)).base16,
    'nickname': params['nickname'],
    'countrycode': params['countrycode'] ?? '86'
  };
  return request(
    'POST',
    'https://music.163.com/weapi/register/cellphone',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
