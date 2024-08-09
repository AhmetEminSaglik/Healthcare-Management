class IsVisibleBloodResultSubItem {
  bool _bloodSugar = true;
  bool _bloodPressure = true;
  bool _calcium = true;
  bool _magnesium = true;

  bool get bloodSugar => _bloodSugar;

  set bloodSugar(bool value) {
    _bloodSugar = value;
  }

  bool get bloodPressure => _bloodPressure;

  bool get magnesium => _magnesium;

  set magnesium(bool value) {
    _magnesium = value;
  }

  bool get calcium => _calcium;

  set calcium(bool value) {
    _calcium = value;
  }

  set bloodPressure(bool value) {
    _bloodPressure = value;
  }

  @override
  String toString() {
    return 'IsVisibleBloodResultSubItems{_bloodSugar: $_bloodSugar, _bloodPressure: $_bloodPressure, _calcium: $_calcium, _magnesium: $_magnesium}';
  }
}
