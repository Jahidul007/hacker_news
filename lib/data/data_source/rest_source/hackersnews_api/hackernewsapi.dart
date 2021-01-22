import 'package:hacker_news/data/app_helper/url_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class HackerNewsRestApi {
  final _httpClient = http.Client();

  Future<dynamic> getHackernewsId() async {
    var responseJson;
    try {
      final response = await _httpClient.get(UrlHelper.topStoryUrl);
      responseJson = _response(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getHackernews(int id) async {
    var responseJson;
    try {
      final response = await _httpClient.get(UrlHelper.urlForStory(id));
      print(response);
      responseJson = _response(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw Exception(response.body.toString());
      case 401:

      case 403:
        throw Exception(response.body.toString());
      case 500:

      default:
        throw Exception(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
