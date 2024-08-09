import 'package:blood_check/model/LineChartData/LineChartSideTitle.dart';
import 'package:blood_check/model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';

import 'BaseLineChartPreData.dart';

class LineChartPreDataWeekly extends BaseLineChartPreData {
  LineChartPreDataWeekly({required super.bloodResultList})
      : super(rangeTotalIndexValue: 24 * 7); // 24 hours for 1 week

  @override
  void createBottomSideTitles() {
    int weeklyTotalIndexValue = rangeTotalIndexValue;
    int hour = now.hour;
    int minute = now.minute;
    int weekDay = now.weekday;
    int remainedTime = (hour * 60 + minute) ~/ 60;
    int weeklyTitleLength = EnumLineChartBottomSideWeeklyTitles.values.length;
    for (int i = 0; i < weeklyTitleLength; i++) {
      bottomTitle.add(LineChartSideTitle(
          index: weeklyTotalIndexValue - (remainedTime + ((i) * 24)),
          //24 : reset each 24 hours
          text: EnumLineChartBottomSideWeeklyTitles.getIndexName(
              (weekDay - i) % weeklyTitleLength)));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartPreDataWeekly";
  }

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours).toDouble();
    return diffHours;
  }
}
