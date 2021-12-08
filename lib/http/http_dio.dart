import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'error_interceptor.dart';

class HttpDio {
  ///超时时间
  static const int defConnectTimeout = 15000;
  static const int defReceiveTimeout = 15000;

  static final HttpDio _instance = HttpDio._internal();

  factory HttpDio() => _instance;

  Dio? _dio;
  final CancelToken _cancelToken = CancelToken();

  HttpDio._internal() {
    if (_dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = BaseOptions(
          connectTimeout: defConnectTimeout,
          // 响应流上前后两次接受到数据的间隔，单位为毫秒。
          receiveTimeout: defReceiveTimeout,
          // Http请求头.
          headers: {});

      options.extra['withCredentials'] = true;

      _dio = Dio(options);

      // 添加拦截器
      if (kDebugMode == true) {
        //只在测试的时候添加
        _dio?.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      }
      _dio?.interceptors.add(ErrorInterceptor());
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  Future<void> init({required String baseUrl, int? connectTimeout, int? receiveTimeout, List<Interceptor>? interceptors}) async {
    _dio?.options.baseUrl = baseUrl;
    _dio?.options.connectTimeout = connectTimeout ?? defConnectTimeout;
    _dio?.options.receiveTimeout = receiveTimeout ?? defReceiveTimeout;

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio?.interceptors.addAll(interceptors);
    }
  }


  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    _dio?.options.headers.addAll(map);
  }

  ///校验证书
  void verifyCert(bool verify) {
    if (!verify) {
      (_dio?.httpClientAdapter as DefaultHttpClientAdapter?)?.onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          return true;
        };
      };
    }
  }

/*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  ///  get
  Future<Response?> get(String path, {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    Options requestOptions = options ?? Options();
    return _dio?.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  ///  post
  Future<Response?> post(String path,
      {Map<String, dynamic>? params, data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    Options requestOptions = options ?? Options();
    return _dio?.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  ///  put 操作
  Future<Response?> put(String path,
      {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    Options requestOptions = options ?? Options();
    return _dio?.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  ///  patch
  Future<Response?> patch(String path,
      {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    Options requestOptions = options ?? Options();
    return _dio?.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  ///  delete
  Future<Response?> delete(String path, {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken}) async {
    Options requestOptions = options ?? Options();

    return _dio?.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
  }

  ///  post form 表单提交
  Future<Response?> postForm(String path,
      {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    Options requestOptions = options ?? Options();

    return _dio?.post(
      path,
      data: FormData.fromMap(params ?? {}),
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  ///  download 下载
  Future<Response?> download(String path, String savePath,
      {Map<String, dynamic>? params, data, bool deleteOnError = true, ProgressCallback? onReceiveProgress, Options? options, CancelToken? cancelToken}) async {
    Options requestOptions = options ?? Options();

    return _dio?.download(
      path,
      savePath,
      data: data,
      queryParameters: params,
      deleteOnError: deleteOnError,
      onReceiveProgress: onReceiveProgress,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
  }
}
