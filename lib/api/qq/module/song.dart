part of '../qq.dart';

///新歌首发
Future<Answer> _songNew(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "newSong": {
        "module": "newsong.NewSongServer",
        "method": "get_new_song_info",
        "param": {"type": 5}
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

/*
*歌曲信息
*/
Future<Answer> _songInfo(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "songInfo": {
        "module": "music.pf_song_detail_svr",
        "method": "get_song_detail_yqq",
        "param": {
          "song_type": 0,
          "song_mid": params['songMid'],
          "song_id": params['songId'] ?? 0,
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌词
*/
Future<Answer> _songLyric(Map params, List<Cookie> cookie) {
  final data = {
    "nobase64": 1,
    "format": 'json',
    "musicid": params['songId'],
    "songmid": params['songMid'],
  };
  return _get(
    "https://c.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_yqq.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌词2
*/
Future<Answer> _songLyricNew(Map params, List<Cookie> cookie) {
  final data = {
    "nobase64": 1, //是否base64显示
    "format": 'json',
    "musicid": params['songId'],
    "songmid": params['songMid'],
  };
  return _get(
    "https://c.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_new.fcg",
    params: data,
    cookie: cookie,
  );
}

Future<Answer> _songLyric3(Map params, List<Cookie> cookie) {
  final data = {
    "version": 15,
    "miniversion": '82',
    "lrctype": '4',
    "musicid": params['songId'],
    // "songmid": params['songMid'],
  };
  return _getString(
    "https://c.y.qq.com/qqmusic/fcgi-bin/lyric_download.fcg",
    params: data,
    cookie: cookie,
  ).then((value) {
    var data = value.data["data"].toString().replaceAll("<!--", "").replaceAll("-->", "").replaceAll("miniversion=\"1\"", "miniversion");

    var lrc = XmlDocument.parse(data);

    var content = lrc.findAllElements('content')?.firstOrNull?.innerText;

    String decompressedString = QrcDecoder.decode(content ?? "");

    var qrc = XmlDocument.parse(decompressedString);

    var cc = qrc.findAllElements('Lyric_1')?.firstOrNull?.attributes.firstWhere((p0) => p0.localName == 'LyricContent').value;

    var dd = {"lyric": cc};

    return Future.value(value.copy(data: dd));
  });
}

/*
 * 相关MV
 */
Future<Answer> _songMv(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "mv": {
        "module": "MvService.MvInfoProServer",
        "method": "GetMvBySongid",
        "param": {
          "mids": ["${params['songMid']}"],
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 相关歌单
* 参数为歌曲Id，不是Mid
* */
Future<Answer> _songPlayList(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "comm": {"ct": 24, "cv": 0},
      "playList": {
        "module": "music.mb_gedan_recommend_svr",
        "method": "get_related_gedan",
        "param": {
          "song_id": params['songId'],
          "song_type": 1,
          "sin": 0,
          "last_id": 0,
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
* 歌曲评论，mv评论也是这个，pid不一样
* 参数为歌曲Id，不是Mid
* 分页从0开始
* */
Future<Answer> songComment(Map params, List<Cookie> cookie) {
  final data = {
    "biztype": 1,
    "topid": params['songId'],
    "cmd": 8,
    "pagenum": params['page'] ?? 0,
    "pagesize": 25,
    "lasthotcommentid": params['lastHotCommentId'] ?? '',
    "domain": 'qq.com',
  };
  return _get(
    "https://c.y.qq.com/base/fcgi-bin/fcg_global_comment_h5.fcg",
    params: data,
    cookie: cookie,
  );
}

/*
 * 暂时只能获取非VIP的，req/freeflowsip+req_0/midurlinfo
 * https://res.wx.qq.com/voice/getvoice?mediaid=MzI3NjYzODY0Nl8xMDAwMDAyMDI=
 */
Future<Answer> _songListen(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "req": {
        "module": "CDN.SrfCdnDispatchServer",
        "method": "GetCdnDispatch",
        "param": {"guid": "3982823384"}
      },
      //普通音乐获取播放地址
      "req_0": {
        "method": "CgiGetVkey",
        "module": "vkey.GetVkeyServer",
        "param": {
          "guid": "3982823384",
          "songmid": ["${params["songMid"]}"],
          "songtype": [0],
          "uin": "0",
          "loginflag": 1,
          "platform": "20"
        }
      },
      //vip获取试听地址、普通加密音乐
      //RS02为收费音乐固定开头，格式MP3
      //O6M0为普通音乐固定开头，格式mgg，这个参数暂时有问题，可能没办法播放
      "queryvkey": {
        "method": "CgiGetEVkey",
        "module": "vkey.GetEVkeyServer",
        "param": {
          "guid": "3982823384",
          "filename": [
            //file下media_mid
            "${params["mediaMid"]}.mp3",
          ],
          "songmid": ["${params["songMid"]}"],
          "songtype": [
            1,
          ],
          "uin": "0"
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  ).then((value) {
    print(value.data['req']["data"]['freeflowsip'][0] + value.data['queryvkey']['data']["midurlinfo"][0]['purl'] + '&fromtag=77');
    print(value.data['req']["data"]['freeflowsip'][0] + value.data['req_0']['data']["midurlinfo"][0]['purl'] + '&fromtag=77');

    return value;
  });
}

/*
 * 歌曲下载
 */
Future<Answer> _songDownload(Map params, List<Cookie> cookie) {
  final data = {
    "data": json.encode({
      "req": {
        "module": "CDN.SrfCdnDispatchServer",
        "method": "GetCdnDispatch",
        "param": {"guid": "3982823384"}
      },
      "comm": {
        "ct": "19",
        "cv": "1803",
        "guid": "BAA33EB707EDB4E5998AC716FC667CE5",
        "uin": "0",
      },
      "queryvkey": {
        "method": "CgiGetEDownUrl",
        "module": "vkey.GetEDownUrlServer",
        "param": {
          "checklimit": 1,
          "ctx": 1,
          "downloadfrom": 0,
          //M5000低品质
          //M8000高品质
          //只支持非会员下载的歌曲
          "filename": ["${params["mediaMid"]}.mp3"],
          "guid": "BAA33EB707EDB4E5998AC716FC667CE5",
          "songmid": ["${params["songMid"]}"],
          "songtype": [1],
          "uin": "0"
        }
      }
    })
  };
  return _get(
    "https://u.y.qq.com/cgi-bin/musicu.fcg",
    params: data,
    cookie: cookie,
  ).then((value) {
    print(value.data['req']["data"]['freeflowsip'][0] + value.data['queryvkey']['data']["midurlinfo"][0]['purl'] + '&fromtag=77');

    return value;
  });
}
