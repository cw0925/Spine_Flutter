import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api_list.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    handler.next(options);
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // super.onRequest(options, handler);
    handler.next(options);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    debugPrint('onError====：' + err.message);
    return super.onError(err, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    // super.onResponse(response, handler);
    debugPrint('onResponse====：' + response.data.runtimeType.toString() + '+====' + response.runtimeType.toString());
    if (response.statusCode == 200) {
      if(response.data is ResponseBody){
        handler.next(response);
      }else{
        final data = (response.data is Map) ? response.data : json.decode(response.data);
        RespData respData = RespData.fromJson(data);
        if(respData.success){
          response.data = respData.data;
          handler.next(response);
        }else{
          debugPrint('onResponse===1');
          handler.reject(handleFailed(response));
        }
      }
    }else{
      debugPrint('onResponse===2');
      handler.reject(handleFailed(response));
    }
  }
  DioError handleFailed(Response response){
    debugPrint('handleFailed:'+response.toString());
    debugPrint('handleFailed:'+response.requestOptions.path);
    return DioError(
        requestOptions: response.requestOptions,
        error: response.data,
        response: response);
  }
}
class RespData {
  dynamic data;

  int returnCode;

  String returnDesc;

  RespData({this.data, this.returnCode, this.returnDesc});

  bool get success => returnCode == 0;

  @override
  String toString() {
    return "RespData{ data: $data, code: $returnCode, message: $returnDesc}";
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["data"] = data;
    map["code"] = returnCode;
    map["msg"] = returnDesc;

    return map;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    data = json["data"];
    returnCode = json["code"] ?? int.parse(json["code"]);
    returnDesc = json["msg"];
  }
}
