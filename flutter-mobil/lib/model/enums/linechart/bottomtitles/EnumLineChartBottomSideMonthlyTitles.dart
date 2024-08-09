enum EnumLineChartBottomSideMonthlyTitles {
  WEEK_1(id: 0, name: "WK 1"),
  WEEK_2(id: 1, name: "WK 2"),
  WEEK_3(id: 2, name: "WK 3"),
  WEEK_4(id: 3, name: "WK 4");

  final int id;
  final String name;

  const EnumLineChartBottomSideMonthlyTitles(
      {required this.id, required this.name});

  static String getIndexName(int id) {
    switch (id) {
      case 0:
        return EnumLineChartBottomSideMonthlyTitles.WEEK_1.name;
      case 1:
        return EnumLineChartBottomSideMonthlyTitles.WEEK_2.name;
      case 2:
        return EnumLineChartBottomSideMonthlyTitles.WEEK_3.name;
      case 3:
        return EnumLineChartBottomSideMonthlyTitles.WEEK_4.name;

      default:
        return "Invalid Line Chart Monthly Bottom Side Title Index  : $id";
    }
  }
}
