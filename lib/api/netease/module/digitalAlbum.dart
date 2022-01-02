part of '../netease.dart';

// 购买数字专辑
Future<Answer> _digitalAlbumOrdering(Map params, List<Cookie> cookie) {
  final data = {
    'business': 'Album',
    'paymentMethod': params['paymentMethod'],
    'digitalResources': json.encode({
      "business": 'Album',
      'resourceID': params['id'],
      'quantity': params['quantity'],
    }),
    "from": 'web',
  };

  return request(
    'POST',
    'https://music.163.com/api/digitalAlbum/purchased',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

//我的数字专辑
Future<Answer> _digitalAlbumPurchased(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/digitalAlbum/purchased',
    {
      'limit': params['limit'] ?? 30,
      'offset': params['offset'] ?? 0,
      'total': true,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
