enum EnumBloodResultContent {
  BLOOD_SUGAR(id: 1, name: "Blood Sugar"),
  BLOOD_PRESSURE(id: 2, name: "Blood Pressure"),
  MAGNESIUM(id: 3, name: "Magnesium"),
  CALCIUM(id: 4, name: "Calcium");

  final int id;
  final String name;

  const EnumBloodResultContent({required this.id, required this.name});

  static String getTypeName(int id) {
    switch (id) {
      case 1:
        return EnumBloodResultContent.BLOOD_SUGAR.name;
      case 2:
        return EnumBloodResultContent.BLOOD_PRESSURE.name;
      default:
        return "Invalid Blood Result Content";
    }
  }
}
