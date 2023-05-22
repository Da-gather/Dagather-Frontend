class FriendModel {
  final int id;
  String areWeFriend;
  String? uid;
  String? name;
  String? imgUrl;
  String? senderId;
  String? receiverId;
  String? chatroomId;

  FriendModel.fromJsonForFriendWidget(Map<String, dynamic> json)
      : id = json["friendId"],
        uid = json["memberId"],
        name = json["name"],
        imgUrl = json["imageUrl"],
        areWeFriend = json["areWeFriend"],
        chatroomId = json["chatroomId"];

  FriendModel.fromJson(Map<String, dynamic> json)
      : id = json["friendId"],
        senderId = json["sender"],
        receiverId = json["receiver"],
        areWeFriend = json["areWeFriend"],
        chatroomId = json["chatroomId"];
}
