class CorrectSpellModel {
  final String correctText;
  final int errorCount;
  List<WordBagModel> wordBags = [];

  CorrectSpellModel.fromArray(List<dynamic> arr)
      : correctText = arr[2],
        errorCount = arr[3] {
    final Map<String, dynamic> wordBagsMap = arr[4];
    wordBagsMap.forEach((key, value) {
      if (key != '<em' && !key.contains("class='violet_text'>")) {
        if (value == 0) {
          wordBags.add(WordBagModel(text: key, isWrong: false));
        } else {
          wordBags.add(WordBagModel(text: key, isWrong: true));
        }
      }
    });
  }

  CorrectSpellModel.fromJson(Map<String, dynamic> json)
      : correctText = json['correctText'],
        errorCount = json['errorCount'] {
    List<dynamic> wordBagsList = json['wordBags'];
    for (var element in wordBagsList) {
      wordBags.add(WordBagModel.fromJson(element));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['correctText'] = correctText;
    data['errorCount'] = errorCount;
    data['wordBags'] = wordBags.map((element) => element.toJson()).toList();
    return data;
  }
}

class WordBagModel {
  final String text;
  final bool isWrong;

  WordBagModel({required this.text, required this.isWrong});

  WordBagModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        isWrong = json['isWrong'];

  Map<String, dynamic> toJson() {
    return {'text': text, 'isWrong': isWrong};
  }
}
