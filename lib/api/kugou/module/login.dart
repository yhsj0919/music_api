part of '../kugou.dart';

///QR
Future<Answer> _qrcode(Map params, List<Cookie> cookie) {
  var data = {
    "appid": 1014,
    "clientver": 8131,
    "clienttime": DateTime.now().millisecondsSinceEpoch,
    "mid": DateTime.now().millisecondsSinceEpoch,
    "uuid": DateTime.now().millisecondsSinceEpoch,
    "dfid": "08wyqk0MiPFi4Dwedb1siTvH",
    "type": 1,
    "plat": 4,
    "qrcode_txt": "https://h5.kugou.com/apps/loginQRCode/html/index.html?appid=1014&",
    "srcappid": 2919,
  };

  var signature = signatureParams(data);

  data["signature"] = signature;
  // print(signature);
  return _get(
    "https://login-user.kugou.com/v2/qrcode",
    params: data,
    cookie: cookie,
  );
}

Future<Answer> _getUserinfoQrcode(Map params, List<Cookie> cookie) {
  var data = {
    "appid": 1014,
    "clientver": 8131,
    "clienttime": DateTime.now().millisecondsSinceEpoch,
    "mid": DateTime.now().millisecondsSinceEpoch,
    "uuid": DateTime.now().millisecondsSinceEpoch,
    "dfid": "08wyqk0MiPFi4Dwedb1siTvH",
    "plat": 4,
    "qrcode": params["qrcode"],
    "srcappid": 2919,
  };

  var signature = signatureParams(data);

  data["signature"] = signature;
  // print(signature);
  return _get(
    "https://login-user.kugou.com/v2/get_userinfo_qrcode",
    params: data,
    cookie: cookie,
  );
}
