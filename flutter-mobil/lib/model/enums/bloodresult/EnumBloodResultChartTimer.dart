enum EnumBloodResultChartTimer {
  DAILY(timeRange: 24, name: "Daily"),
  WEEKLY(timeRange: 7, name: "Weekly"),
  MONTHLY(timeRange: 30, name: "Monthly"),
  SIX_MONTHLY(timeRange: 30, name: "6 Monthly");

  final int timeRange;
  final String name;

  const EnumBloodResultChartTimer(
      {required this.timeRange, required this.name});

  static int getTime(String name) {
    switch (name) {
      case "Daily":
        return EnumBloodResultChartTimer.DAILY.timeRange;
      case "Weekly":
        return EnumBloodResultChartTimer.WEEKLY.timeRange;
      case "Monthly":
        return EnumBloodResultChartTimer.MONTHLY.timeRange;
      case "6 Monthly":
        return EnumBloodResultChartTimer.SIX_MONTHLY.timeRange;
      default:
        throw ArgumentError("Invalid Disease Timer Type");
    }
  }
}
