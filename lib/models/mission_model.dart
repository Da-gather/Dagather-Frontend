import 'dart:ui';

import 'package:dagather_frontend/utilities/variables.dart';

class MissionModel {
  final num id;
  final String mission;
  final int category;
  late Color color;
  late Color subColor;
  final String friendId;
  final String? friendName;
  final String friendImgUrl;
  String? completedAt;
  String? currentUserId;
  String? currentUserName;
  String? currentUserImgUrl;
  bool hasCurrentUserCompleted = false;
  bool hasFriendCompleted = false;

  MissionModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        friendId = json["friendId"],
        friendName = json["friendName"],
        friendImgUrl = json["friendImageUrl"],
        mission = json["mission"],
        category = json["category"],
        completedAt = json["completedAt"] {
    color =
        missionTypes.firstWhere((element) => element.value == category).color;
    subColor = missionTypes
        .firstWhere((element) => element.value == category)
        .subColor;
  }

  MissionModel.fromJsonForOngoing(Map<String, dynamic> json)
      : id = json["id"],
        friendId = json["friendId"],
        friendName = json["friendName"],
        friendImgUrl = json["friendImageUrl"],
        hasFriendCompleted = json["friendCompleted"] ?? false,
        currentUserId = json["userId"],
        currentUserName = json["userName"],
        currentUserImgUrl = json["userImageUrl"],
        hasCurrentUserCompleted = json["userCompleted"] ?? false,
        mission = json["mission"],
        category = json["category"] {
    color =
        missionTypes.firstWhere((element) => element.value == category).color;
    subColor = missionTypes
        .firstWhere((element) => element.value == category)
        .subColor;
  }
}
