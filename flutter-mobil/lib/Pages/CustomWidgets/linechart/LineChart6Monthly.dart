import 'package:blood_check/Pages/CustomWidgets/linechart/BaseLineChart.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChart6Monthly extends BaseLineChart {
  double rangeIndex = 180;

  LineChart6Monthly(
      {required super.baseLineChartPreData,
      required super.checkBoxVisibleBloodResultContent,
      double aspectRadio = 1.40})
      : super(aspectRadio: aspectRadio) {
    extraMsg = "Not Completed Yet";
  }

  @override
  LineChartData getLineChartData() {
    return LineChartData();
  }
}
