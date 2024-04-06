import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/native_item.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.jsonbin.io/v3/qs/';

  ApiProvider() {
    // Add interceptors for logging and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request details only in debug mode
        assert(() {
          print('Request: ${options.method} ${options.path}');
          print('Request headers: ${options.headers}');
          print('Request data: ${options.data}');
          return true;
        }());
        return handler.next(options); // continue the request
      },
      onResponse: (response, handler) {
        // Log response details only in debug mode
        assert(() {
          print('Response: ${response.statusCode}');
          print('Response data: ${response.data}');
          return true;
        }());
        return handler.next(response); // continue the response
      },
      onError: (DioError e, handler) {
        // Log error details only in debug mode
        assert(() {
          print('Error: ${e.response?.statusCode}');
          print('Error message: ${e.message}');
          return true;
        }());
        return handler.next(e); // continue the error
      },
    ));
  }

  /***  Native Item API ***/
  Future<NativeItem> fetchMenuDetails() async {
    Response response = await _dio.get('${_baseUrl}66119488acd3cb34a8347518');
    Map<String, dynamic> jsonResponse =
        response.data['record']['record']['record']['record'];

    if (jsonResponse['items'] != null) {
      var itemList = jsonResponse['items'] as List;
      List<Items> itemsList = itemList.map((i) => Items.fromJson(i)).toList();
      NativeItem nativeItem = NativeItem(items: itemsList);
      return nativeItem;
    }
    return NativeItem(items: []);
  }
}
