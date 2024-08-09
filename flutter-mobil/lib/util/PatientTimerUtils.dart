import 'package:blood_check/model/specialitem/doctor/PatientTimer.dart';

class PatientTimerUtils {
  static String getReadableFormat(PatientTimer timer) {
    String timeText = "";
    timeText = "${_get2DigitStringValue(timer.hours)}:";
    timeText += _get2DigitStringValue(timer.minutes);
    return timeText;
  }

  static String _get2DigitStringValue(int val) {
    if (val ~/ 10 == 0) {
      return "0$val";
    }
    return val.toString();
  }

  static String calculateSensorNextMeasurementTime(
      {required DateTime lastCreatedAt, required PatientTimer patientTimer}) {
    Duration duration =
        Duration(hours: patientTimer.hours, minutes: patientTimer.minutes);
    lastCreatedAt = lastCreatedAt.add(duration);
    String nextTimeText = "${_get2DigitStringValue(lastCreatedAt.hour)}:";
    nextTimeText += "${_get2DigitStringValue(lastCreatedAt.minute)} - ";
    nextTimeText +=
        "${_get2DigitStringValue(lastCreatedAt.day)}.${_get2DigitStringValue(lastCreatedAt.month)}.${lastCreatedAt.year}";
    return nextTimeText;
  }
}
