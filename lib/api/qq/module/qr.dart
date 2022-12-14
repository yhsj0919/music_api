part of '../qq.dart';

// void main() {
//   var ss = ptqrtokenStr("b2961d7e1415fa6550307d6a3b3f7fbb327b26e92d1a535cc428b35c547c5fea67877dac96ffefab034fda676d27316980ab7a9635141d34");
//
//   print(ss);
//
// }

/*
* 二维码
 */
Future<Answer> _loginQr(Map params, List<Cookie> cookie) {
  final data = {
    "appid": 716027609,
    "e": 2,
    "l": "M",
    "s": 3,
    "d": 72,
    "v": 4,
    "t": Random().nextDouble().toStringAsFixed(16),
    "daid": 383,
    "pt_3rd_aid": 100497308,
  };
  return _getImage(
    "https://ssl.ptlogin2.qq.com/ptqrshow",
    params: data,
    cookie: cookie,
  );
}

/*
* 二维码验证
*o1vId=1eb273e864b184bac42f950fe589d5de&pt_js_version=v1.38.0
 */
Future<Answer> _loginQrCheck(Map params, List<Cookie> cookie) {
  print('请求的cookie');
  print(cookie);
  print("结束");
  final data = {
    "u1": Uri.encodeComponent("https://graph.qq.com/oauth2.0/login_jump"),
    "ptqrtoken": ptqrtokenStr(params["qrsig"]),
    "ptredirect": "0",
    "h": "1",
    "t": "1",
    "g": "1",
    "from_ui": "1",
    "ptlang": "2052",
    "action": "${Random().nextInt(3)}-${Random().nextInt(3)}-${DateTime.now().millisecondsSinceEpoch.toStringAsFixed(13)}",
    "js_ver": "22112816",
    "js_type": "1",
    "login_sig": "bECjcCAc2CqPK4*X4dIGWfQjaB-odl-r*UCnq*XEkU1VzuxHE6YDrSKlVEX*giyn",
    "pt_uistyle": "40",
    "daid": "383",
    "aid": "716027609",
    "pt_3rd_aid": "100497308",
    "o1vId": "157cfed3688308c5f80c2d9880faea5e",
    "pt_js_version": "v1.38.0",
  };
  return _getString(
    "https://ssl.ptlogin2.qq.com/ptqrlogin",
    params: data,
    cookie: cookie,
  );
}

int ptqrtokenStr(String qrsig) {
  int e = 0;
  int n = qrsig.length;
  for (int j = 0; j < n; j++) {
    e = e + (e << 5);
    e = e + (qrsig.codeUnits[j]);
    e = 2147483647 & e;
  }
  return e;
}
//访问二维码，获取cookie的qrsig
//https://ssl.ptlogin2.qq.com/ptqrshow?appid=1006102&e=2&l=M&s=3&d=72&v=4&t=0.5859352323556379&daid=384&pt_3rd_aid=100497308
//https://ssl.ptlogin2.qq.com/ptqrshow?appid=716027609&e=2&l=M&s=3&d=72&v=4&t=0.7986872226000326&daid=383&pt_3rd_aid=100497308

// qrsig=a6507890388180dc6bf8b266a5ddbeb566bd95f0bb18944c2c71100b1c3db75adccd0f475fd385837ed8c7e96136d48465c8c2d7f48f71f2;Path=/;Domain=ptlogin2.qq.com;Secure;SameSite=None;

// 1739325157
//生成ptqrtoken替换action可不要

// https://ssl.ptlogin2.qq.com/ptqrlogin?u1=https%3A%2F%2Fy.qq.com%2Fportal%2Fclose.html&ptqrtoken=1558277820&ptredirect=0&h=1&t=1&g=1&from_ui=1&ptlang=2052&action=0-2-1670916044332&js_ver=22112816&js_type=1&login_sig=oWX0KqvRuz3bnQmkSAYTfeNgd7DO1Um3co0Pry0jWUhnS-dZMP4FEGX-B4mMnkIh&pt_uistyle=40&low_login_enable=1&low_login_hour=720&aid=1006102&daid=384&ptdrvs=NNhMzGorHBLbqWI-wLYnd66gUvslNyHmCHU*1rbgOyf2t05LnHfPMSYRTXCv2JTPwhZtNAkLMQI_&sid=6674369442964055633&has_onekey=1&&o1vId=1eb273e864b184bac42f950fe589d5de&pt_js_version=v1.38.0

//循环请求上面的地址，成功了就会返回下面类似的结果，访问地址就能拿到cookie
//ptuiCB('0','0','https://ptlogin2.y.qq.com/check_sig','0','登录成功！', 'XXXX')
