part of '../netease.dart';

// 首页-发现 block page
// 这个接口为移动端接口，首页-发现页，数据结构可以参考 https://github.com/hcanyz/flutter-netease-music-api/blob/master/lib/src/api/uncategorized/bean.dart#L259 HomeBlockPageWrap
// query.refresh 是否刷新数据
Future<Answer> _homepageBlockPage(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.7.01'));
  return request(
    'POST',
    'https://music.163.com/api/homepage/block/page',
    {'refresh': params['refresh'] ?? false, 'cursor': params['cursor']},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

// 首页-发现 dragon ball
// 这个接口为移动端接口，首页-发现页（每日推荐、歌单、排行榜 那些入口）
// 数据结构可以参考 https://github.com/hcanyz/flutter-netease-music-api/blob/master/lib/src/api/uncategorized/bean.dart#L290 HomeDragonBallWrap
// !需要登录或者匿名登录，非登录返回 []
Future<Answer> _homepageDragonBall(Map params, List<Cookie> cookie) {
  cookie.add(Cookie('os', 'ios'));
  cookie.add(Cookie('appver', '8.7.01'));

  if (cookie.where((element) => element.name == "MUSIC_U").isEmpty) {
    cookie.add(Cookie('MUSIC_A',
        '8aae43f148f990410b9a2af38324af24e87ab9227c9265627ddd10145db744295fcd8701dc45b1ab8985e142f491516295dd965bae848761274a577a62b0fdc54a50284d1e434dcc04ca6d1a52333c9a'));
  }
  return request(
    'POST',
    'https://music.163.com/eapi/homepage/dragon/ball/static',
    {},
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
