import 'package:dagather_frontend/utilities/variables.dart';

class TagModel {
  final TagType type;
  final String text;
  bool isSelected;

  TagModel(this.text, this.isSelected, this.type);

  TagModel.fromJsonPurpose(Map<String, dynamic> json)
      : type = TagType.purpose,
        text = json["purpose"],
        isSelected = json["same"];

  TagModel.fromJsonInterest(Map<String, dynamic> json)
      : type = TagType.interest,
        text = json["interest"],
        isSelected = json["same"];

  void changeSelectedState(newState) {
    isSelected = newState;
  }
}
