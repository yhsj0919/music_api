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
                        "site": MusicSite.KuWo.name,
                        "id": e["id"],
                        "pic": e["img"],
                        "title": e["name"],
                        "listenCount": e["listencnt"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.KuWo.name, "data": datas ?? []};
            case MusicSite.MiGu:
              var datas = ((e.data["data"] as List?)?.first?["items"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.MiGu.name,
                        "id": e["id"],
                        "pic": "https:${e["image"]}",
                        "title": e["title"],
                        "listenCount": e["playTimes"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.MiGu.name, "data": datas ?? []};
            case MusicSite.KuGou:
              var datas = (e.data["plist"]?["list"]?["info"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.KuGou.name,
                        "id": e["specialid"],
                        "pic": e["imgurl"].toString().replaceAll("{size}", "400"),
                        "title": e["specialname"],
                        "subTitle": e["intro"],
                        "listenCount": e["playcount"],
                      })
                  .where((element) => element["id"] != null)
                  .toList()
                  .sublist(0, 10);
              return {"site": MusicSite.KuGou.name, "data": datas ?? []};
            case MusicSite.Baidu:
              var datas = (e.data["data"]?["result"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.Baidu.name,
                        "id": e["id"],
                        "pic": e["pic"],
                        "title": e["title"],
                        "subTitle": e["desc"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.Baidu.name, "data": datas ?? []};
            case MusicSite.Netease:
              var datas = (e.data["playlists"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.Netease.name,
                        "id": e["id"],
                        "pic": e["coverImgUrl"],
                        "title": e["name"],
                        "subTitle": e["description"],
                        "listenCount": e["playCount"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.Netease.name, "data": datas ?? []};
            case MusicSite.QQ:
              var datas = (e.data["hotRecommend"]?["data"]?["v_hot"] as List?)
                  ?.map((e) => {
                        "site": MusicSite.QQ.name,
                        "id": e["content_id"],
                        "pic": e["cover"],
                        "title": e["title"],
                        "listenCount": e["listen_num"],
                      })
                  .where((element) => element["id"] != null)
                  .toList();
              return {"site": MusicSite.QQ.name, "data": datas ?? []};
            default:
              return {};
          }
        })
        .where((element) => element.isNotEmpty)
        .toList();
    return Answer(site: MusicSite.Mix, data: datas);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(site: MusicSite.Mix, data: []);
  }
}
