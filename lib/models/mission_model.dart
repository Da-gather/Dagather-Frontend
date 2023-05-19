import 'package:cloud_firestore/cloud_firestore.dart';

class MissionModel {
  final num id;
  final String friendId;
  final String friendImgUrl;
  final String mission;
  final int category;
  final Timestamp? completedAt;

  MissionModel({
    required this.id,
    required this.friendId,
    required this.friendImgUrl,
    required this.mission,
    required this.category,
    required this.completedAt,
  });
}
