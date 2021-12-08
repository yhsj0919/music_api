import 'dart:collection';

bool toBoolean(val) {
  if (val == '') return val;
  return val == 'true' || val == '1';
}

String toParamsString(LinkedHashMap? params) {
  return params?.entries.map((e) => "${e.key}=${e.value}").join("&")??"";
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
