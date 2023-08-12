import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:post_app/core/apis.dart';

abstract class Network {
  Future<String?> get({
    required String api,
    int? id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  Future<void> post({
    required String api,
    required String body,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  Future<void> put({
    required String api,
    required String body,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  Future<void> patch({
    required String api,
    required String body,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  Future<void> delete({
    required String api,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}

class HttpNetwork implements Network {
  @override
  Future<void> delete({
    required String api,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<String?> get({
    required String api,
    int? id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final Uri url = Uri.https(
        baseUrl,
        '$api${id != null ? '/$id' : ''}',
        queryParameters,
      );

      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        return utf8.decode(response.bodyBytes);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> patch({
    required String api,
    required String body,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<void> post({
    required String api,
    required String body,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<void> put({
    required String api,
    required String body,
    required int id,
    String baseUrl = Api.baseUrl,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
