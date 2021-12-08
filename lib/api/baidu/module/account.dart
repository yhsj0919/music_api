part of '../baidu.dart';

/*
  * 登出
 */
Future<Answer> _logout(Map params, List<Cookie> cookie) {
  return _post("https://api-qianqian.taihe.com/v1/account/logout", params: {}, cookie: cookie);
}

/*
  * 账户信息
 */
Future<Answer> _accountInfo(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/account/info",
    params: {},
    cookie: cookie,
  );
}

/*
  * 修改账户信息
  * @param age 年龄
  * @param avatar 头像（可为空，是一个完整的图片路径，上传方式请查看说明文档）
  * @param birth 生日
  * @param nickname 昵称
  * @param sex 性别（0，保密，1，男,2女）
  * @param intro 简介
 */
Future<Answer> _changeAccountInfo(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data["nickname"] = params['nickname'];
  data["age"] = params['age'];
  if (params['avatar'] == null) {
    data["avatar"] = params['avatar'];
  }
  data["birth"] = params['birth'];
  data["sex"] = params['sex'];
  if (params['intro'] != null) {
    data["intro"] = params['intro'];
  }
  return _post(
    "https://api-qianqian.taihe.com/v1/account/info",
    params: data,
    cookie: cookie,
  );
}

/*
  *账户歌曲列表(喜欢的歌曲？)
 */
Future<Answer> _accountSongList(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data["pageNo"] = params['page'] ?? 1;
  data["pageSize"] = params['size'] ?? 20;

  return _get(
    "https://api-qianqian.taihe.com/v1/account/songlist",
    params: data,
    cookie: cookie,
  );
}

/*
  *账户收藏等信息
 */
Future<Answer> _accountAmount(Map params, List<Cookie> cookie) {
  return _get(
    "https://api-qianqian.taihe.com/v1/account/amount",
    params: {},
    cookie: cookie,
  );
}

/*
 *已购专辑
 */
Future<Answer> _accountPurchaseAlbum(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data["pageNo"] = params['page'] ?? 1;
  data["pageSize"] = params['size'] ?? 20;

  return _get(
    "https://api-qianqian.taihe.com/v1/account/purchase/album",
    params: data,
    cookie: cookie,
  );
}

/*
 *已购单曲
 */
Future<Answer> _accountPurchase(Map params, List<Cookie> cookie) {
  LinkedHashMap<String, dynamic> data = LinkedHashMap();
  data["pageNo"] = params['page'] ?? 1;
  data["pageSize"] = params['size'] ?? 20;

  return _get(
    "https://api-qianqian.taihe.com/v1/account/purchase",
    params: data,
    cookie: cookie,
  );
}
