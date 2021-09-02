import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ShopApi {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {'Content-Type': 'application/json'}
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Authorization': '$token',
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
