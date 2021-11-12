import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/http.dart';
import 'api_exceptions.dart';
import 'api_list.dart';
/// 发送 http 请求.
/// 若无需返回值 T 可传递 Null
Future<T> request<T>(
  String url, {
  Map<String, dynamic> data,
  Map<String, dynamic> queryParameters,
  String method = "POST",
  bool errorToast = true,
}) async {
  var result = await _requestImpl(
    url,
    data: data,
    queryParameters: queryParameters,
    method: method,
    errorToast: errorToast,
  );
  return _convertTo<T>(result);
}

/// 发送 http get 请求.
/// 若无需返回值 T 可传递 Null
Future<T> getRequest<T>(
  String url, {
  Map<String, dynamic> data,
  bool errorToast = true,
}) async {
  return await request<T>(
    url,
    queryParameters: data,
    method: "GET",
    errorToast: errorToast,
  );
}
 /// 下载文件
Future<dynamic> downloadFile(
  String url,
  dynamic savePath, {
  dynamic data,
  ProgressCallback onReceiveProgress,
  bool deleteOnError = true,
  String lengthHeader = Headers.contentLengthHeader,
  bool errorToast = true,
  bool requestMain = true,
}) async {
  var options = Options(method: "GET");
  try {
    var result = await http.download(url, savePath,
        data: data,
        onReceiveProgress: onReceiveProgress,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        options: options);
    return result;
  } catch (e) {
    _netWorkErrorHandler(e, errorToast, url);
  }
}

Future<dynamic> _requestImpl(
  String url, {
  dynamic data,
  Map<String, dynamic> queryParameters,
  String method,
  ProgressCallback onSendProgress,
  bool errorToast = true
}) async {
  try {
    var response = await http.request(
        ApiList.mainBaseUrl + url,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        options: Options(method: method));
    debugPrint('请求url ：'+ ApiList.mainBaseUrl + url);
    return response.data;
  } catch (e) {
    _netWorkErrorHandler(e, errorToast, url);
  }
}
void _netWorkErrorHandler(dynamic error, bool errorToast, String url) {
  debugPrint('请求错误 ：'+ url + '错误信息：' + error.toString());
  if(error is DioError){
    switch (error.type){
      case DioErrorType.connectTimeout:
        _showToast('网络连接超时', errorToast);
        break;
      case DioErrorType.response:
        _showToast(error, errorToast);
        break;
      case DioErrorType.other:
          _showToast(error, errorToast);
        break;
      default:
        break;
    }
  }
  throw error;
}
void _showToast(err, errorToast) {
  if (errorToast) {
    if (err.error is SocketException) {
      print('网络加载失败,请重试');
    }else{
      var msg = err.response.data['msg'] ?? '接口请求错误';
      print(msg);
    }
  }
}

/// 新增模型时需添加新的 case 处理逻辑
T _convertTo<T>(dynamic data) {
  try {
    if (T == Null) {
      return data;
    } else if (T == bool) {
      return data;
    } else if (T == int) {
      return data;
    } else if (T == String) {
      return data;
    } else if (T == List) {
      return data;
    } else {
      throw UnimplementedError("$T is undefined");
    }
  } on UnimplementedError catch (e) {
    throw e;
  } catch (e) {
    throw JsonDeserializeException("$T", data);
  }
}
