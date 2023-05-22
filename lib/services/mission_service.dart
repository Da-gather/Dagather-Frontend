import 'dart:convert';

import 'package:dagather_frontend/models/mission_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class MissionService {
  static const String mission = "mission";
  static const String statistics = "statistics";
  static const String recent10 = "recent10";
  static const String ongoings = "ongoings";
  static const String ongoing = "ongoing";

  static Future<MissionModel> getOngoingMission(String friendId) async {
    final Map<String, String> queryParameters = {};
    queryParameters['memberId1'] = FirebaseAuth.instance.currentUser!.uid;
    queryParameters['memberId2'] = friendId;

    final Uri url = Uri.http(
      API.baseUrl,
      '${API.version}/$mission/$ongoing',
      queryParameters,
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        return MissionModel.fromJsonForOngoing(body["data"]);
      }
    }
    throw Error();
  }

  static Future<List<MissionModel>> getOngoingMissions(id) async {
    final Map<String, String> queryParameters = {};
    queryParameters['memberId'] = id;

    final Uri url = Uri.http(
      API.baseUrl,
      '${API.version}/$mission/$ongoings',
      queryParameters,
    );
    List<MissionModel> missionInstances = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var mission in body["data"]) {
          missionInstances.add(MissionModel.fromJson(mission));
        }
      }
      return missionInstances;
    }
    throw Error();
  }

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

  static Future<List<MissionModel>> getRecentMission(id) async {
    final Map<String, String> queryParameters = {};
    queryParameters['memberId'] = id;

    final Uri url = Uri.http(
      API.baseUrl,
      '${API.version}/$mission/$recent10',
      queryParameters,
    );
    List<MissionModel> missionInstances = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var mission in body["data"]) {
          missionInstances.add(MissionModel.fromJson(mission));
        }
      }
      return missionInstances;
    }
    throw Error();
  }
}
