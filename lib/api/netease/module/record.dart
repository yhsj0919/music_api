part of '../netease.dart';

///最近播放-专辑
Future<Answer> _recordRecentAlbum(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/album/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

///最近播放-播客
Future<Answer> _recordRecentDj(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/djradio/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

///最近播放-歌单
Future<Answer> _recordRecentPlaylist(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/playlist/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

///最近播放-歌曲
Future<Answer> _recordRecentSong(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/song/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

///最近播放-视频
Future<Answer> _recordRecentVideo(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/newvideo/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}

///最近播放-声音
Future<Answer> _recordRecentVoice(Map params, List<Cookie> cookie) {
  return request(
    'POST',
    'https://music.163.com/api/play-record/voice/list',
    {
      'limit': params["limit"] ?? 100,
    },
    crypto: Crypto.weApi,
    cookies: cookie,
  );
}
