part of '../netease.dart';

//手机登录
Future<Answer> _loginCellphone(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '2.9.7'));
  final data = {
    'phone': params['phone'],
    'countrycode': params['countrycode'] ?? 86,
    'rememberLogin': 'true',
    'captcha': params['captcha'],
    params['captcha'] == null ? 'password' : 'captcha': params['captcha'] ?? Encrypted(Uint8List.fromList(md5.convert(utf8.encode(params['password'])).bytes)).base16,
  };

  return request(
    'POST',
    'https://music.163.com/api/login/cellphone',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
    ua: 'pc',
  );
}

// 二维码登录检测（轮询）
Future<Answer> _loginQrCheck(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/client/login',
    {
      'key': params['key'],
      'type': 1,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//返回二维码信息，自己去生成二维码
Future<Answer> _loginQrCreate(Map params, List<Cookie> cookie) {
  final url = 'https://music.163.com/login?codekey=${params["key"]}';
  return Future.value(
    Answer(
      site: MusicSite.Netease,
      code: 200,
      data: {'qrurl': url},
    ),
  );
}

// 二维码Key
Future<Answer> _loginQrKey(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/qrcode/unikey',
    {
      'type': 1,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 登录刷新
Future<Answer> _loginRefresh(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/login/token/refresh',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
    ua: 'pc',
  );
}

// 登录状态
Future<Answer> _loginStatus(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/weapi/w/nuser/account/get',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
    ua: 'pc',
  );
}

// 邮箱登录
Future<Answer> _login(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'pc'));
  cookie.add(Cookie('appver', '2.9.7'));
  final data = {'username': params['email'], 'password': Encrypted(Uint8List.fromList(md5.convert(utf8.encode(params['password'])).bytes)).base16, 'rememberLogin': 'true'};

  return request(
    'POST',
    'https://music.163.com/api/login',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
    ua: 'pc',
  );
}

// 退出登录
Future<Answer> _logout(Map params, List<Cookie> cookie) {
  return request('POST', 'https://music.163.com/weapi/logout', {}, crypto: Crypto.weApi, cookies: cookie, ua: 'pc');
}

// 检测手机号码是否已经注册
Future<Answer> _cellphoneExistenceCheck(Map params, List<Cookie> cookie) {
  final data = {'cellphone': params['phone'], 'countrycode': params['countrycode']};
  return eApiRequest(
    url: 'http://music.163.com/eapi/cellphone/existence/check',
    optionUrl: '/api/cellphone/existence/check',
    data: data,
    cookies: cookie,
  );
}

// 检测用户名是否已经注册
Future<Answer> _activateInitProfile(Map params, List<Cookie> cookie) {
  final data = {'nickname': params['nickname']};
  return eApiRequest(
    url: 'http://music.163.com/eapi/activate/initProfile',
    optionUrl: '/api/activate/initProfile',
    data: data,
    cookies: cookie,
  );
}
