import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///2022/1/5
///
class SQCookieManager extends Interceptor {
  /// Cookie manager for http requests。Learn more details about
  /// CookieJar please refer to [cookie_jar](https://github.com/flutterchina/cookie_jar)
  CookieJar? cookieJar;
  static dynamic kwCookies;

  SQCookieManager(this.cookieJar);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    cookieJar!.loadForRequest(options.uri).then((cookies) {
      var cookie = getCookies(cookies);
      kwCookies = cookies;
      if (cookie.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader]=options.headers[HttpHeaders.cookieHeader]+";"+cookie;
      }
      handler.next(options);
    }).catchError((e, stackTrace) {
      var err = DioError(requestOptions: options, error: e, stackTrace: stackTrace);
      handler.reject(err, true);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCookies(response).then((_) => handler.next(response)).catchError((e, stackTrace) {
      var err = DioError(requestOptions: response.requestOptions, error: e, stackTrace: stackTrace);

      handler.reject(err, true);
    });
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _saveCookies(err.response!).then((_) => handler.next(err)).catchError((e, stackTrace) {
        var _err = DioError(requestOptions: err.response!.requestOptions, error: e, stackTrace: stackTrace);

        handler.next(_err);
      });
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookies(Response response) async {
    var cookies = response.headers[HttpHeaders.setCookieHeader];

    if (cookies != null) {
      await cookieJar!.saveFromResponse(
        response.requestOptions.uri,
        cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
      );
    }
  }

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }
}
