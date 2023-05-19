import 'package:dagather_frontend/utilities/variables.dart';

class TagModel {
  final String type;
  final String text;
  final bool changeColor;

  TagModel.fromJsonPurpose(Map<String, dynamic> json)
      : type = TagType.purpose.name,
        text = json["purpose"],
        changeColor = json["same"];

  TagModel.fromJsonInterest(Map<String, dynamic> json)
      : type = TagType.interest.name,
        text = json["interest"],
        changeColor = json["same"];
}
