import 'package:dagather_frontend/models/mission_type_model.dart';
import 'package:dagather_frontend/utilities/colors.dart';

enum MessageType {
  text,
  image,
  all,
}

enum TagType {
  purpose,
  interest,
}

class GenderType {
  static const women = "여자";
  static const men = "남자";
}

class FriendRequestType {
  static const send = 1;
  static const receive = 0;
}

class FriendStateType {
  static const isNotFriend = 'NONE';
  static const send = 'SEND';
  static const receive = 'RECEIVE';
  static const isFriend = 'FRIEND';
}

class MissionType {
  static final red = MissionTypeModel(value: 0, color: AppColor.red);
  static final yellow = MissionTypeModel(value: 1, color: AppColor.yellow4);
  static final green = MissionTypeModel(value: 2, color: AppColor.green);
  static final blue = MissionTypeModel(value: 3, color: AppColor.blue);
}
