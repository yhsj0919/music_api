import 'dart:collection';

import 'package:music_api/api/utils/utils.dart';
import 'package:universal_io/io.dart';

class Http {
  static Future<HttpClientResponse> get(String url, {Map<String, dynamic>? params, Map<String, String>? headers}) {
    url += "?${toParamsString(LinkedHashMap.from(params ?? {}))}";
    return HttpClient().getUrl(Uri.parse(url)).then((request) {
      headers?.forEach(request.headers.add);
      return request.close();
    });
  }

  static Future<HttpClientResponse> post(String url, {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return HttpClient().postUrl(Uri.parse(url)).then((request) {
      headers?.forEach(request.headers.add);
      request.headers.add('Content-Type', 'application/x-www-form-urlencoded');
      request.write(Uri(queryParameters: (params ?? {}).map((key, value) => MapEntry(key, value.toString())).cast()).query);
      return request.close();
    });
  }
}
