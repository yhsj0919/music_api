import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///2022/1/5
///
class MediaTypeInterceptor extends Interceptor {
  /// Cookie manager for http requests。Learn more details about
  /// CookieJar please refer to [cookie_jar](https://github.com/flutterchina/cookie_jar)
  static dynamic kwCookies;

  MediaTypeInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // cookieJar!.loadForRequest(options.uri).then((cookies) {
    //   var cookie = getCookies(cookies);
    //   kwCookies = cookies;
    //   if (cookie.isNotEmpty) {
    //     options.headers[HttpHeaders.cookieHeader] = cookie;
    //   }
    print(options.headers);
    handler.next(options);
    // }).catchError((e, stackTrace) {
    //   var err = DioError(requestOptions: options, error: e, stackTrace: stackTrace);
    //   handler.reject(err, true);
    // });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.headers);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.response?.headers);
    if (err.response != null) {
      handler.next(err);
    } else {
      handler.next(err);
    }
  }





}
