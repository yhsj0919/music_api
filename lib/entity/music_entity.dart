enum MusicSite { MyFreeMp3, Baidu, KuGou, KuWo, MiGu, Netease, QQ }
enum MusicFormat { LQ, PQ, HQ, SQ, ZQ24 }

Map Resp({int? code = 200, String? msg = "操作成功", dynamic data}) {
  return {"code": code, "msg": msg, "data": data};
}


Map Song({
  MusicSite site = MusicSite.MyFreeMp3,
  required String? id,
  required String? name,
  List<Map> artist = const [],
  required Map? album,
  List<Map> url = const [],
  required String? thumb,
  required int? date,
}) {
  return {
    "site": site.name,
    "id": id,
    "name": name,
    "artist": artist,
    "album": album,
    "url": url,
    "thumb": thumb,
    "date": date,
  };
}

Map Artist({required String? id, required String? name}) {
  return {"id": id, "name": name};
}

Map Album({required String? id, required String? name, required String? thumb}) {
  return {"id": id, "name": name, "thumb": thumb};
}

Map Url({required String? url, MusicFormat format = MusicFormat.HQ}) {
  return {"format": format.name, "url": url};
}
