enum MusicSite { MyFreeMp3, Baidu, KuGou, KuWo, MiGu, Netease, QQ }
enum MusicFormat { LQ, PQ, HQ, SQ, ZQ24 }

Map Resp({int? code = 200, String? msg = "操作成功", dynamic data}) {
  return {"code": code, "msg": msg, "data": data};
}

class Song {
  Song({this.site, this.id, this.name, this.artist, this.album, this.url, this.thumb, this.date});

  Song.fromJson(dynamic json) {
    site = json['site'];
    id = json['id'];
    name = json['name'];
    if (json['artist'] != null) {
      artist = [];
      json['artist'].forEach((v) {
        artist?.add(Artist.fromJson(v));
      });
    }
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    if (json['url'] != null) {
      url = [];
      json['url'].forEach((v) {
        url?.add(Url.fromJson(v));
      });
    }
    thumb = json['thumb'];
    date = json['date'];
  }

  String? site;
  String? id;
  String? name;
  List<Artist>? artist;
  Album? album;
  List<Url>? url;
  String? thumb;
  int? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site'] = site;
    map['id'] = id;
    map['name'] = name;
    if (artist != null) {
      map['artist'] = artist?.map((v) => v.toJson()).toList();
    }
    if (album != null) {
      map['album'] = album?.toJson();
    }
    if (url != null) {
      map['url'] = url?.map((v) => v.toJson()).toList();
    }
    map['thumb'] = thumb;
    map['date'] = date;
    return map;
  }
}

class Url {
  Url({this.format, this.url});

  Url.fromJson(dynamic json) {
    format = json['format'];
    url = json['url'];
  }

  String? format;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['format'] = format;
    map['url'] = url;
    return map;
  }
}

class Album {
  Album({this.id, this.name, this.thumb});

  Album.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    thumb = json['thumb'];
  }

  String? id;
  String? name;
  String? thumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['thumb'] = thumb;
    return map;
  }
}

class Artist {
  Artist({this.id, this.name});

  Artist.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  dynamic id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

