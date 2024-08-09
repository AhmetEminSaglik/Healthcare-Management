import 'package:flutter/material.dart';

import 'package:blood_check/util/ProductColor.dart';

class TimerMinute extends StatelessWidget {
  int mins;

  TimerMinute({required this.mins});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        mins < 10 ? '0' + mins.toString() : mins.toString(),
        style: TextStyle(fontSize: 40, color: ProductColor.white),
      ),
    );
  }
}
