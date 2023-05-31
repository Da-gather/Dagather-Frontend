import 'variables.dart';

int getAgeFromDateTime(DateTime datetime) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - datetime.year;
  int currentMonth = currentDate.month;
  int birthMonth = datetime.month;
  if (birthMonth > currentMonth) {
    age--;
  } else if (currentMonth == birthMonth) {
    int day1 = currentDate.day;
    int day2 = datetime.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

String getGender(isWomen) {
  if (isWomen) {
    return "여자";
  } else {
    return "남자";
  }
}

bool getGenderBool(GenderType type) {
  if (GenderType.woman == type) {
    return true;
  } else {
    return false;
  }
}

String getRegionText(String region) {
  final country = countries.firstWhere(
    (element) => element['code'] == region,
    orElse: () {
      throw Error();
    },
  );
  return "${country['emoji']} ${country['name']}";
}

String getRegionEmoji(String region) {
  final country = countries.firstWhere(
    (element) => element['code'] == region,
    orElse: () {
      throw Error();
    },
  );
  return country['emoji']!;
}
