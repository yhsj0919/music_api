part of '../mix_music.dart';

///新碟上架
Future<Answer> _albumNew({List<MusicSite> site = allSite}) async {
  try {
    var value = await Future.wait(site.map((e) {
      switch (e) {
        case MusicSite.KuWo:
          return KuWo.albumNew();
        case MusicSite.MiGu:
          return MiGu.albumNewWeb();
        case MusicSite.KuGou:
          return KuGou.albumList();
        case MusicSite.Baidu:
          return Baidu.albumNew();
        case MusicSite.Netease:
          return Netease.albumNewest();
        case MusicSite.QQ:
          return QQ.albumNew(size: 10);
        default:
          return Future.value(const Answer(site: MusicSite.None, code: 200));
      }
    }).toList());

    var datas = value
        .map((e) {
          switch (e.site) {
            case MusicSite.KuWo:
              try {
                var datas = (((e.data["child"] as List?)?.firstWhere((element) => element["type"].toString() == "newmusic_list")?["child"] as List?)?.first?["child"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.KuWo.name,
                          "id": e["data"]?["id"],
                          "pic": e["data"]?["img"],
                          "title": e["data"]?["name"],
                          "subTitle": e["data"]?["artist"],
                        })
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.KuWo.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuWo.name, "data": []};
              }
            case MusicSite.MiGu:
              try {
                var datas = (e.data["data"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.MiGu.name,
                          "id": e["albumId"],
                          "pic": "http:${e["image"]}",
                          "title": e["albumName"],
                          "subTitle": (e["singers"] as List?)?.map((e) => e["singerName"]).join(","),
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.MiGu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.MiGu.name, "data": []};
              }
            case MusicSite.KuGou:
              try {
                var datas = (e.data["data"]?["info"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.KuGou.name,
                          "id": e["albumid"],
                          "pic": e["imgurl"].toString().replaceAll("{size}", "400"),
                          "title": e["albumname"],
                          "subTitle": e["singername"],
                        })
                    .where((element) => element["id"] != null)
                    .toList()
                    .sublist(0, 10);
                return {"site": MusicSite.KuGou.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.KuGou.name, "data": []};
              }
            case MusicSite.Baidu:
              try {
                var datas = (e.data["data"]?["result"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.Baidu.name,
                          "id": e["albumAssetCode"],
                          "pic": "${e["pic"]}@w_200,h_200",
                          "title": e["title"],
                          "subTitle": (e["artist"] as List?)?.map((e) => e["name"]).join(","),
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Baidu.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Baidu.name, "data": []};
              }

            case MusicSite.Netease:
              try {
                var datas = (e.data["albums"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.Netease.name,
                          "id": e["id"],
                          "pic": "${e["picUrl"]}?imageView=1&thumbnail=300x0",
                          "title": e["name"],
                          "subTitle": e["artist"]?["name"],
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.Netease.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.Netease.name, "data": []};
              }
            case MusicSite.QQ:
              try {
                var datas = (e.data["new_album"]?["data"]?["albums"] as List?)
                    ?.map((e) => {
                          "site": MusicSite.QQ.name,
                          "id": e["mid"],
                          "pic": "https://y.qq.com/music/photo_new/T002R300x300M000${e["mid"]}.jpg",
                          "title": e["name"],
                          "subTitle": (e["singers"] as List?)?.map((e) => e["name"]).join(","),
                        })
                    .where((element) => element["id"] != null)
                    .toList();
                return {"site": MusicSite.QQ.name, "data": datas ?? []};
              } catch (e) {
                return {"site": MusicSite.QQ.name, "data": []};
              }

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
