part of '../netease.dart';

// 发送验证码
Future<Answer> _captchaSend(Map params, List<Cookie> cookie) {
  final data = {
    'ctcode': params['ctcode'] ?? '86',
    'cellphone': params['phone'],
  };
  return request(
    'POST',
    'https://music.163.com/api/sms/captcha/sent',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//校验验证码
Future<Answer> _captchaVerify(Map params, List<Cookie> cookie) {
  final data = {
    'ctcode': params['ctcode'] ?? '86',
    'cellphone': params['phone'],
    'captcha': params['captcha']
  };
  return request(
    'POST',
    'https://music.163.com/weapi/sms/captcha/verify',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
