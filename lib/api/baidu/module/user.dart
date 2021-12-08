part of '../baidu.dart';

/*
 * 签到
 */
Future<Answer> _userSignIn(Map params, List<Cookie> cookie) {
  return _post(
    "https://api-qianqian.taihe.com/v1/user/points/signin",
    params: {},
    cookie: cookie,
  );
}
