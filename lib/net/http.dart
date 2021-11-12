import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

import 'interceptors.dart';

final Http http = Http();

mixin HttpClientCreate {

  HttpClient createHttpClient(HttpClient client) {
    client = HttpClient();
    if (!kReleaseMode && false) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        ///设置代理
        return "PROXY 192.168.3.40:8888";
      };
    }
    return client;
  }

}

class Http extends DioForNative with HttpClientCreate {
  static Http instance;

  factory Http() {
    if (instance == null) {
      instance = Http._().._init();
    }
    return instance;
  }

  Http._();

  _init() {
    ///Custom jsonDecodeCallback
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

//    options.baseUrl = Constants.baseUrl;
    options.connectTimeout = 1000 * 60;

    options.receiveTimeout = 1000 * 30;

    _setHttps();

    interceptors

      ///通用请求头处理
      ..add(HeaderInterceptor())

      ///request response 处理
      ..add(ApiInterceptor());

      ///日志 处理
      // ..add(DioLogInterceptor());

    /// cookie 持久化 异步
    // ..add(CookieManager(
    //     PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
    ///此处可添加自定义header
    options.headers["Os"] = Platform.isAndroid ? "android" : "ios";
  }

  _setHttps() {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      return createHttpClient(client);
    };
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}