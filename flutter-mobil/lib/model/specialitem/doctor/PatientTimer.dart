class PatientTimer {
  late int _hours;
  late int _minutes;
  late int _patientId;

  PatientTimer({int hours = 0, int minutes = 0, int patientId = -1}) {
    _hours = hours;
    _minutes = minutes;
    _patientId = patientId;
  }

  int get hours => _hours;

  set hours(int value) {
    _hours = value;
  }

  int get minutes => _minutes;

  set minutes(int value) {
    _minutes = value;
  }

  int get patientId => _patientId;

  set patientId(int value) {
    _patientId = value;
  }

  factory PatientTimer.fromJson(Map<String, dynamic> json) {
    return PatientTimer(
      hours: json["hours"] as int,
      minutes: json["minutes"] as int,
      patientId: json["patientId"] as int,
    );
  }

  @override
  String toString() {
    return 'PatientTimer{_hour: $_hours, _min: $_minutes, _patientId: $_patientId}';
  }
}
