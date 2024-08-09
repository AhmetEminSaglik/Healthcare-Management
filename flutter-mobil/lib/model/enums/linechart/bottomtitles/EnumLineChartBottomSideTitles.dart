enum EnumLineChartBottomSideDailyTitles {
  DAILY_00_00(id: 0, name: "00:00"),
  DAILY_08_00(id: 1, name: "08:00"),
  DAILY_16_00(id: 2, name: "16:00");

  final int id;
  final String name;

  const EnumLineChartBottomSideDailyTitles(
      {required this.id, required this.name});

  static String getIndexName(int id) {
    switch (id) {
      case 0:
        return EnumLineChartBottomSideDailyTitles.DAILY_00_00.name;
      case 1:
        return EnumLineChartBottomSideDailyTitles.DAILY_08_00.name;
      case 2:
        return EnumLineChartBottomSideDailyTitles.DAILY_16_00.name;
      default:
        return "Invalid Line Chart Daily Bottom Side Title Index  : $id";
    }
  }
}
