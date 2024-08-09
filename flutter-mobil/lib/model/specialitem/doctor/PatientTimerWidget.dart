import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/model/specialitem/doctor/PatientTimer.dart';
import 'package:blood_check/util/CustomSnackBar.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'TimerHours.dart';
import 'TimerMinute.dart';

class PatientTimerWidget extends StatefulWidget {
  PatientTimerWidget({Key? key}) : super(key: key);

  @override
  State<PatientTimerWidget> createState() => _PatientTimerWidgetState();

  final PatientTimer _patientTimer = PatientTimer();

  PatientTimer get patientTimer => _patientTimer;
/*TODO Istenirse patient'indirek kayitli timeri cekilir ve ekrana o bastirilir.
     *  Eger bunu eklersem, doctor sureyi degistirmeyi kaydetmeye calistigi zamanda zaten kayitli degil istek atmam, server gereksiz mesgul olmaz.
  * */
}

class _PatientTimerWidgetState extends State<PatientTimerWidget> {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  FixedExtentScrollController minuteCont =
      FixedExtentScrollController(initialItem: 5);
  FixedExtentScrollController hourCont =
      FixedExtentScrollController(initialItem: 10);

  @override
  void initState() {
    super.initState();
    widget._patientTimer.minutes = minuteCont.initialItem;
    widget._patientTimer.hours = hourCont.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    animateItemToRequestedIndex(
        showAnimatin: false, cont: minuteCont, index: 10);
    animateItemToRequestedIndex(showAnimatin: false, cont: hourCont, index: 10);
    return Scaffold(
        backgroundColor: ProductColor.alertBoxBackgroundColor,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: ResponsiveDesign.getScreenWidth() / 5,
                // color: Colors.redAccent,
                child: ListWheelScrollView.useDelegate(
                    controller: hourCont,
                    onSelectedItemChanged: (value) => {
                          jumpToMinute(minute: 1),
                          //   minuteCont.selectedItem=1,
                          // },
                          widget._patientTimer.hours = value
                        },
                    itemExtent: 50,
                    physics: FixedExtentScrollPhysics(),
                    perspective: 0.01,
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 24,
                        builder: (BuildContext context, int index) {
                          return TimerHours(
                            hours: index,
                          );
                        })),
              ),
            ),
            Center(
              child: Container(
                width: ResponsiveDesign.getScreenWidth() / 5,
                // color: Colors.blueAccent,
                child: ListWheelScrollView.useDelegate(
                    controller: minuteCont,
                    // useMagnifier: true,
                    //   magnification: 1.4,
                    onSelectedItemChanged: (value) => {
                          if (jumpToMinute(minute: 1))
                            {
                              value = minuteCont.selectedItem,
                            },
                          widget._patientTimer.minutes =
                              minuteCont.selectedItem,
                        },
                    itemExtent: 50,
                    physics: FixedExtentScrollPhysics(),
                    perspective: 0.01,
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (BuildContext context, int index) {
                          return TimerMinute(
                            mins: index,
                          );
                        })),
              ),
            ),
          ],
        ));
  }

  bool jumpToMinute({required int minute}) {
    if (minuteCont.selectedItem == 0 && hourCont.selectedItem == 0) {
      String msg = "Timer can be setup minimum 1 minute.";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
      // minuteCont.jumpToItem(1);
      animateItemToRequestedIndex(
          showAnimatin: true, cont: minuteCont, index: 1);
      log.i("minute zipladi, ${minuteCont.selectedItem}");
      return true;
    }
    return false;
  }

  void animateItemToRequestedIndex(
      {required bool showAnimatin,
      required FixedExtentScrollController cont,
      required int index}) {
    int milliseconds = showAnimatin ? 500 : 0;
    cont.animateToItem(
      index,
      duration: Duration(milliseconds: milliseconds), // Animasyon süresi
      curve: Curves.easeInOut, // Animasyon eğrisi
    );
  }
}
