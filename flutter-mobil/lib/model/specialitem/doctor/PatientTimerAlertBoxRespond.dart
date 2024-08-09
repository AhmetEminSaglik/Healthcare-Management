import 'package:blood_check/model/specialitem/doctor/PatientTimer.dart';

class PatientTimerAlertBoxRespond {
  late bool _result;
  late PatientTimer _patientTimer;

  PatientTimerAlertBoxRespond({required result, required patientTimer}) {
    _result = result;
    _patientTimer = patientTimer;
  }

  bool get result => _result;

  set result(bool value) {
    _result = value;
  }

  PatientTimer get patientTimer => _patientTimer;

  set patientTimer(PatientTimer value) {
    _patientTimer = value;
  }
}
