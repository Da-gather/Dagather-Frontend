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
    return GenderType.women;
  } else {
    return GenderType.men;
  }
}
