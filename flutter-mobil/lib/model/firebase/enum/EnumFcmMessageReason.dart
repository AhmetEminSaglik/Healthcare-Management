enum EnumFcmMessageReason {
  UPDATE_LINE_CHART(code: 1000, reason: "Update Line Chart"),
  UPDATE_SENSOR_TIMER(code: 1001, reason: "Update Sensor Timer");

  final int code;
  final String reason;

  const EnumFcmMessageReason({required this.code, required this.reason});

  static String getReasonOfCode(int code) {
    switch (code) {
      case 1000:
        return EnumFcmMessageReason.UPDATE_LINE_CHART.reason;
      case 1001:
        return EnumFcmMessageReason.UPDATE_SENSOR_TIMER.reason;
      default:
        return "Unknown Code";
    }
  }

  static int getCodeOfReason(String reason) {
    switch (reason) {
      case "UPDATE_LINE_CHART":
      case "Update Line Chart":
        return EnumFcmMessageReason.UPDATE_LINE_CHART.code;

      case "UPDATE_SENSOR_TIMER":
      case "Update Sensor Timer":
        return EnumFcmMessageReason.UPDATE_SENSOR_TIMER.code;
      default:
        return -1;
    }
  }
}
