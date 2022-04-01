import 'dart:math';


class Utils {
  static minNumber(double number) {
    return min(number.floor(), 40000);
  }

  static maxNumber(double number) {
    return max(number.ceil(), 48000);
  }

  static String getHourMin(String date) {
    var time = DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000);

    return addZero(time.hour) +
        ':' +
        addZero(time.minute) +
        ':' +
        addZero(time.second);
  }

  static String addZero(int digit) {
    if (digit > 9) {
      return digit.toString();
    }
    return '0' + digit.toString();
  }
}
