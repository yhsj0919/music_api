import 'dart:collection';

bool toBoolean(val) {
  if (val == '') return val;
  return val == 'true' || val == '1';
}

int getPageSize(int total, int size, {int? currentTotal}) {
  if (total > 1000) {
    total = 1000;
  }
  //这里防止有一些total不准确的情况导致大量请求，比如实际总数60，total是500，currentTotal是当前页数量
  if (currentTotal != null && size - currentTotal > 10) {
    return 1;
  } else {
    var remainder = total % size;
    int num = total ~/ size;
    if (remainder != 0) {
      return num + 1;
    } else {
      return num;
    }
  }
}

String toParamsString(LinkedHashMap? params) {
  return params?.entries.map((e) => "${e.key}=${e.value}").join("&") ?? "";
}

//删除一些转义字符，这个主要用于qqMusic
String lyricFormat(String lyric) {
  return lyric
      .replaceAll("&#10;", "\n")
      .replaceAll("&#13;", "\r")
      .replaceAll("&#32;", " ")
      .replaceAll("&#39;", "'")
      .replaceAll("&#40;", "(")
      .replaceAll("&#41;", ")")
      .replaceAll("&#45;", "-")
      .replaceAll("&#46;", ".")
      .replaceAll("&#58;", ":")
      .replaceAll("&#64;", "@")
      .replaceAll("&#95;", "_")
      .replaceAll("&#124;", "|");
}

Map<String, String> paramsToMap(String params) {
  var map = <String, String>{};

  params.split("&").forEach((element) {
    var entity = element.split("=");
    if (entity.length > 1) {
      map[entity[0]] = entity[1];
    } else {
      map[entity[0]] = "";
    }
  });

  return map;
}

//分割数组
List<List> splitList(List list, int len) {
  var length = list.length; //列表数组数据总条数
  List<List> result = []; //结果集合
  int index = 1;
  //循环 构造固定长度列表数组
  while (true) {
    if (index * len < length) {
      List temp = list.skip((index - 1) * len).take(len).toList();
      result.add(temp);
      index++;
      continue;
    }
    List temp = list.skip((index - 1) * len).toList();
    result.add(temp);
    break;
  }
  return result;
}
