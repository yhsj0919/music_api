part of '../mix_music.dart';

///PlaylistNew
Future<Answer> _playlistNew({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait([
      site.contains(MusicSite.KuWo) ? KuWo.playList() : Future.value(const Answer()),
      site.contains(MusicSite.MiGu) ? MiGu.banner() : Future.value(const Answer()),
      site.contains(MusicSite.KuGou) ? KuGou.banner() : Future.value(const Answer()),
      site.contains(MusicSite.Baidu) ? Baidu.banner() : Future.value(const Answer()),
      site.contains(MusicSite.Netease) ? Netease.banner() : Future.value(const Answer()),
      site.contains(MusicSite.QQ) ? QQ.banner() : Future.value(const Answer()),
    ]);

    var datas = value.map((e) {
      int index = value.indexOf(e);
      switch (index) {
        case 0:
          var datas = (e.data["data"] as List?)
              ?.map((e) => {
                    "site": "kuwo",
                    "id": RegExp(r"[\d]{5,}").stringMatch(e["url"]),
                    "pic": e["pic"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "kuwo", "data": datas ?? []};
        case 1:
          var datas = (e.data["results"] as List?)
              ?.map((e) => {
                    "site": "migu",
                    "id": e["id"],
                    "pic": e["picUrl"],
                    "title": e["title"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "migu", "data": datas ?? []};
        case 2:
          var datas = (e.data["banner"] as List?)
              ?.map((e) => {
                    "site": "kugou",
                    "id": e["id"],
                    "pic": e["imgurl"],
                    "title": e["title"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "kugou", "data": datas ?? []};
        case 3:
          var datas = (e.data["data"]?["result"] as List?)
              ?.map((e) => {
                    "site": "baidu",
                    "id": e["jumpLinkOutput"],
                    "pic": e["pic"],
                    "title": e["title"],
                    "type": e["jumpType"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "baidu", "data": datas ?? []};
        case 4:
          var datas = (e.data["banners"] as List?)
              ?.map((e) => {
                    "site": "netease",
                    "id": e["targetId"],
                    "pic": e["imageUrl"],
                    "title": e["typeTitle"],
                    "type": e["targetType"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "netease", "data": datas ?? []};
        case 5:
          var datas = ((e.data["banner"]?["data"]?["shelf"]?["v_niche"] as List?)?.first["v_card"] as List?)
              ?.map((e) => {
                    "site": "qq",
                    "id": e["id"],
                    "pic": e["cover"],
                    "title": e["title"],
                    "type": e["jumptype"],
                  })
              .where((element) => element["id"] != null)
              .toList();
          return {"site": "qq", "data": datas ?? []};
        default:
          return e.data;
      }
    }).toList();
    return Answer(data: datas);
  } catch (e) {
    print("歌曲列表异常：" + e.toString());
    return const Answer(data: []);
  }
}
