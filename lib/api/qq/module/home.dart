part of '../qq.dart';

/*
* 首页
 */
Future<Answer> _home(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "newMv": {
        "module": "MvService.MvInfoProServer",
        "method": "GetNewMv",
        "param": {"style": 0, "tag": 0, "start": 0, "size": 8}
      },
      "req_1": {
        "module": "music.musicHall.MusicHallPlatform",
        "method": "GetFocus",
        "param": {
          "Device": {"OS": "3", "AppName": "QQ音乐"}
        }
      },
      "hotRecommend": {
        "module": "playlist.HotRecommendServer",
        "method": "get_new_hot_recommend",
        "param": {"cmd": 0, "page": 0, "daily_page": 0, "size": 12}
      },
      "newSong": {
        "module": "newsong.NewSongServer",
        "method": "get_new_song_info",
        "param": {"type": 5}
      },
      "radioLis": {
        "module": "music.longRadio.recommend",
        "method": "getRadioList",
        "param": {"pos": 6}
      },
      "toplist": {
        "module": "musicToplist.ToplistInfoServer",
        "method": "GetAll",
        "param": {}
      },
      "comm": {
        "ct": 20,
        "cv": 1807,
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}
