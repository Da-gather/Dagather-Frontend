class UserModel {
  final String uid;
  final String name;
  final String imgUrl;
  bool gender = true;
  int age = 0;
  String region = "";
  String address = "";

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        name = json["name"],
        imgUrl = json["img_url"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['img_url'] = imgUrl;
    return data;
  }
}
