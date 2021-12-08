part of '../baidu.dart';

/*
 * 发送短信验证码
 * @param phone 手机号
*/
Future<Answer> _sendSms(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['phone'] = params['phone'];
  data['randstr'] = '@arV';
  return _post(
    "https://api-qianqian.taihe.com/v1/oauth/send_sms",
    params: data,
    cookie: cookie,
  );
}

/*
 * 登录
 * @param phone 手机号
 * @param code 验证码
 * NjVhNTMzM2QyZWEyZTlhOTI5OTJiMjZiNWE2YTkwMjY=
*/
Future<Answer> _login(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data['code'] = params['code'];
  data['phone'] = params['phone'];

  return _post(
    "https://api-qianqian.taihe.com/v1/oauth/login",
    params: data,
    cookie: cookie,
  );
}
