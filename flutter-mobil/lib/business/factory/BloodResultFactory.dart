import '../../model/bloodresult/BloodResult.dart';

class BloodResultFactory {
  static List<BloodResult> createBloodResultList(List<dynamic> json) {
    List<BloodResult> bloodResultList =
        json.map((data) => BloodResult.fromJson(data)).toList();
    return bloodResultList;
  }
}
