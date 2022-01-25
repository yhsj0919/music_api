import 'dart:convert';

import 'package:music_api/api/baidu/baidu.dart';
import 'package:music_api/api/kugou/kugou.dart';
import 'package:music_api/api/kuwo/kuwo.dart';
import 'package:music_api/api/migu/migu.dart';
import 'package:music_api/api/my_free_mp3/my_free_mp3.dart';
import 'package:music_api/api/netease/netease.dart';
import 'package:music_api/api/qq/qq.dart';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/utils/answer.dart';

part 'module/album.dart';

part 'module/banner.dart';

part 'module/playlist.dart';

part 'module/song.dart';

class MixMusic {
  MixMusic._();

  static Future<Answer> banner({List<MusicSite> site = allSite}) {
    return _banner(site: site);
  }

  static Future<Answer> playlistRec({List<MusicSite> site = allSite}) {
    return _playlistRec(site: site);
  }

  static Future<Answer> albumNew({List<MusicSite> site = allSite}) {
    return _albumNew(site: site);
  }

  static Future<Answer> songNew({List<MusicSite> site = allSite}) {
    return _songNew(site: site);
  }

  static Future<Answer> matchMusic({String? name, String? artist, List<MusicSite> site = allSite}) {
    return _matchMusic(name: name, artist: artist, site: site);
  }
}
