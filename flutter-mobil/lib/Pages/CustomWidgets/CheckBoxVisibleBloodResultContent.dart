import 'package:blood_check/model/bloodresult/CheckboxBloodResultSubItem.dart';
import 'package:blood_check/model/enums/bloodresult/EnumBloodResultContent.dart';

class CheckBoxVisibleBloodResultContent {
  Map<String, CheckboxBloodResultSubItem> subItemMap = Map();

  CheckBoxVisibleBloodResultContent() {
    subItemMap.putIfAbsent(
        EnumBloodResultContent.BLOOD_SUGAR.name,
        () => CheckboxBloodResultSubItem(
            name: EnumBloodResultContent.BLOOD_SUGAR.name, showContent: true));
    subItemMap.putIfAbsent(
        EnumBloodResultContent.BLOOD_PRESSURE.name,
        () => CheckboxBloodResultSubItem(
            name: EnumBloodResultContent.BLOOD_PRESSURE.name,
            showContent: true));
    subItemMap.putIfAbsent(
        EnumBloodResultContent.CALCIUM.name,
        () => CheckboxBloodResultSubItem(
            name: EnumBloodResultContent.CALCIUM.name, showContent: true));
    subItemMap.putIfAbsent(
        EnumBloodResultContent.MAGNESIUM.name,
        () => CheckboxBloodResultSubItem(
            name: EnumBloodResultContent.MAGNESIUM.name, showContent: true));
  }

  @override
  String toString() {
    String text = "\n";
    subItemMap.forEach((key, value) {
      text += "${key} ${value.showContent} \n";
    });
    return 'CheckBoxVisibleBloodResultContent{subItemMap: $text}';
  }
}
