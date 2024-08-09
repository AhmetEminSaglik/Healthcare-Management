import 'package:fl_chart/fl_chart.dart';

import '../bloodresult/BloodResult.dart';

class BloodListSubItemsFlSpot {
  DateTime now = DateTime.now();

  List<BloodResult> _bloodResultList = [];
  List<FlSpot> _bloodSugarList = [];
  List<FlSpot> _bloodPressureList = [];
  List<FlSpot> _calciumList = [];
  List<FlSpot> _magnesiumList = [];

  BloodListSubItemsFlSpot({required List<BloodResult> bloodResultList}) {
    _bloodResultList = bloodResultList;
  }

  List<BloodResult> get bloodResultList => _bloodResultList;

  List<FlSpot> get magnesiumList => _magnesiumList;

  List<FlSpot> get calciumList => _calciumList;

  List<FlSpot> get bloodPressureList => _bloodPressureList;

  List<FlSpot> get bloodSugarList => _bloodSugarList;
}
