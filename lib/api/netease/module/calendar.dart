part of '../netease.dart';

Future<Answer> _calendar(Map params, List<Cookie> cookie) {
  final data = {
    'startTime': params['startTime'] ?? DateTime.now(),
    'endTime': params['endTime'] ?? DateTime.now(),
  };
  return request(
    'POST',
    'https://music.163.com/api/mcalendar/detail',
    data,
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
