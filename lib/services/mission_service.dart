import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';

class MissionService {
  static const String mission = "mission";
  static const String statistics = "statistics";
  static const String recent10 = "recent10";

  static Future<Map<String, dynamic>> getMissionStatistics(id) async {
    final Map<String, String> queryParameters = {};
    queryParameters['memberId'] = id;

    final Uri url = Uri.http(
      API.baseUrl,
      '${API.version}/$mission/$statistics',
      queryParameters,
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return body["data"];
    }
    throw Error();
  }

  static Future<Map<String, dynamic>> getRecentMission(id) async {
    final Map<String, String> queryParameters = {};
    queryParameters['memberId'] = id;

    final Uri url = Uri.http(
      API.baseUrl,
      '${API.version}/$mission/$recent10',
      queryParameters,
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return body["data"];
    }
    throw Error();
  }
}
