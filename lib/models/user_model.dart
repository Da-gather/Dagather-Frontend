import 'package:dagather_frontend/models/tag_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String imgUrl;
  String? friendState;
  DateTime? birth;
  bool? gender;
  String? period;
  String? address;
  String? region;
  String? introduction;
  List<TagModel>? purposeTags;
  List<TagModel>? interestTags;

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["memberId"],
        address = json["resident"],
        name = json["name"],
        imgUrl = json["imageUrl"],
        gender = json["gender"],
        birth = DateTime.parse(json["birth"]),
        region = json["nationality"],
        period = json["rperiod"],
        introduction = json["introduction"],
        friendState = json["areWeFriend"] {
    List<TagModel> purposeTagsInstance = [];
    for (var purpose in json['purposes']) {
      purposeTagsInstance.add(TagModel.fromJsonPurpose(purpose));
    }
    purposeTags = purposeTagsInstance;

    List<TagModel> interestTagsInstance = [];
    for (var interest in json['interests']) {
      interestTagsInstance.add(TagModel.fromJsonInterest(interest));
    }
    interestTags = interestTagsInstance;
  }

  UserModel.fromJsonForFriend(Map<String, dynamic> json)
      : uid = json["memberId"],
        name = json["name"],
        imgUrl = json["imageUrl"];

  UserModel.fromJsonForFireStore(Map<String, dynamic> json)
      : uid = json["uid"],
        name = json["name"],
        imgUrl = json["img_url"];

  Map<String, dynamic> toJsonForFireStore() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['img_url'] = imgUrl;
    return data;
  }
}
