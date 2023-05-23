import 'package:dagather_frontend/models/tag_model.dart';
import 'package:intl/intl.dart';

class UserModel {
  String? uid;
  String? name;
  String? imgUrl;
  String? friendState;
  DateTime? birth;
  bool? gender;
  int? period;
  String? address;
  double? latitude;
  double? longitude;
  String? region;
  String? introduction;
  List<TagModel>? purposeTags;
  List<TagModel>? interestTags;

  UserModel();

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['memberId'] = uid!;
    data['resident'] = address!;
    data['name'] = name!;
    data['gender'] = gender!;
    data['imageUrl'] = imgUrl!;
    data['birth'] = DateFormat('yyyy-MM-dd').format(birth!);
    data['nationality'] = region!;
    data['rperiod'] = period!;
    data['introduction'] = introduction!;
    data['purposes'] = purposeTags!.map((element) => element.text).toList();
    data['interests'] = interestTags!.map((element) => element.text).toList();
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
