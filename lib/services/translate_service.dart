import 'dart:convert';

import 'package:dagather_frontend/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateService {
  Future<String> getLanguageCodePapago(String content) async {
    String contentType = "application/x-www-form-urlencoded; charset=UTF-8";
    String url = "https://openapi.naver.com/v1/papago/detectLangs";

    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': contentType,
      'X-Naver-Client-Id': API.clientId,
      'X-Naver-Client-Secret': API.clientSecret
    }, body: {
      'query': content
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['langCode'];
    } else {
      debugPrint(response.statusCode.toString());
      throw Error();
    }
  }

  Future<String> getTranslationPapago(String content) async {
    String contentType = "application/x-www-form-urlencoded; charset=UTF-8";
    String url = "https://openapi.naver.com/v1/papago/n2mt";

    final code = await getLanguageCodePapago(content);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': contentType,
        'X-Naver-Client-Id': API.clientId,
        'X-Naver-Client-Secret': API.clientSecret
      },
      body: {
        'source': code,
        'target': "ko",
        'text': content,
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['message']['result']['translatedText'];
    } else {
      print(response.statusCode);
      throw Error();
    }
  }
}
