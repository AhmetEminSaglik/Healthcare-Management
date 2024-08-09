import 'package:blood_check/Pages/CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/BaseLineChart.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/LineChart6Monthly.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/LineChartPreDataMonthly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailLineChartCubit extends Cubit<BaseLineChart> {
  late BaseLineChart? baseLineChart;

  DetailLineChartCubit()
      : super(LineChart6Monthly(
          baseLineChartPreData: LineChartPreDataMonthly(bloodResultList: []),
          checkBoxVisibleBloodResultContent:
              CheckBoxVisibleBloodResultContent(),
        ));

  void updateBaseLineChart(BaseLineChart baseLineChart) {
    this.baseLineChart = baseLineChart;
    emit(baseLineChart);
  }
}
