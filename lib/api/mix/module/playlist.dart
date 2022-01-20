part of '../mix_music.dart';

///歌单推荐
Future<Answer> _playlistRec({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait(site.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.playListRec();
        case MusicSite.MiGu:
          return MiGu.playListNewWeb();
        case MusicSite.KuGou:
          return KuGou.playList();
        case MusicSite.Baidu:
          return Baidu.playlistRec();
        case MusicSite.Netease:
          return Netease.topPlaylist();
        case MusicSite.QQ:
          return QQ.playlistHot();
        default:
          return Future.value(const Answer(site: MusicSite.None, code: 200));
      }
    }).toList());

    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              var datas = (e.data["data"]?["list"] as List?)
                  ?.map((e) => {
                        "site": "kuwo",
                        "id": e["id"],
                        "pic": e["img"],
                        "title": e["name"],
                        "listenCount": e["listencnt"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": "kuwo", "data": datas ?? []};
            case MusicSite.MiGu:
              var datas = (e.data["msg"] as List?)
                  ?.map((e) => {
                        "site": "migu",
                        "id": e["playlistId"],
                        "pic": e["image"],
                        "title": e["playlistName"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": "migu", "data": datas ?? []};
            case MusicSite.KuGou:
              var datas = (e.data["plist"]?["list"]?["info"] as List?)
                  ?.map((e) => {
                        "site": "kugou",
                        "id": e["specialid"],
                        "pic": e["imgurl"],
                        "title": e["specialname"],
                        "subTitle": e["intro"],
                        "listenCount": e["playcount"],
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": "kugou", "data": datas ?? []};
            case MusicSite.Baidu:
              var datas = (e.data["data"]?["result"] as List?)
                  ?.map((e) => {
                        "site": "baidu",
                        "id": e["id"],
                        "pic": e["pic"],
                        "title": e["title"],
                        "subTitle": e["desc"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": "baidu", "data": datas ?? []};
            case MusicSite.Netease:
              var datas = (e.data["playlists"] as List?)
                  ?.map((e) => {
                        "site": "netease",
                        "id": e["id"],
                        "pic": e["coverImgUrl"],
                        "title": e["name"],
                        "subTitle": e["description"],
                        "listenCount": e["playCount"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": "netease", "data": datas ?? []};
            case MusicSite.QQ:
              var datas = (e.data["hotRecommend"]?["data"]?["v_hot"] as List?)
                  ?.map((e) => {
                        "site": "qq",
                        "id": e["content_id"],
                        "pic": e["coverImgUrl"],
                        "title": e["title"],
                        "listenCount": e["listen_num"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": "qq", "data": datas ?? []};
            default:
              return {};
          }
        })
        .where((element) => element.isNotEmpty )
        .toList();
    return Answer(site: MusicSite.Mix, data: datas);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}
