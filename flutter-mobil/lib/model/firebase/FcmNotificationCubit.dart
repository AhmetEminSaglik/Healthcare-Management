import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class FcmNotificationCubit extends Cubit<bool> {
  var log = Logger(printer: PrettyPrinter(colors: false));
  bool updateSensorTimer = false;
  bool updateLineChart = false;
  bool isAllowedUpdatePatientPage = false;

  FcmNotificationCubit() : super(false);

  void enableUpdatingPatientPage() {
    // log.e("Patient Page update is AVAILABLE");
    isAllowedUpdatePatientPage = true;
    // emit(letPermissionFcmNotifyPatientPage); // if I add this line, retrive data 3 times.
    //if I do not add, it works just once.
  }

  void disableUpdatingPatientPage() {
    // log.e("Patient Page update is NOT AVAILABLE");
    isAllowedUpdatePatientPage = false;
    // emit(letPermissionFcmNotifyPatientPage);
  }

  void enableUpdatingPatientLineChart() {
    log.e("Line Chart update is AVAILABLE");
    if (isAllowedUpdatePatientPage) {
      updateLineChart = true;
      emit(updateLineChart);
    }
  }

  void disableUpdatePatientLineChart() {
    log.e("Line Chart update is NOT AVAILABLE");
    updateLineChart = false;
    emit(updateLineChart);
  }

  void enableUpdateSensorTimer() {
    log.e("SENSOR  update is AVAILABLE");
    updateSensorTimer = true;
    emit(updateSensorTimer);
  }

  void disableUpdateSensorTimer() {
    log.e("SENSOR  update is NOT AVAILABLE");
    updateSensorTimer = false;
    emit(updateSensorTimer);
  }
}
