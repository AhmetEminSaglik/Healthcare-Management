enum EnumDiabeticType {
  TIP_1(id: 1, name: "TIP 1"),
  TIP_2(id: 2, name: "TIP 2"),
  HIPOGLISEMI(id: 3, name: "Hipoglisemi"),
  HIPERGLISEMI(id: 4, name: "Hiperglisemi");

  final int id;
  final String name;

  const EnumDiabeticType({required this.id, required this.name});

  static String getTypeName(int id) {
    switch (id) {
      case 1:
        return EnumDiabeticType.TIP_1.name;
      case 2:
        return EnumDiabeticType.TIP_2.name;
      case 3:
        return EnumDiabeticType.HIPOGLISEMI.name;
      case 4:
        return EnumDiabeticType.HIPERGLISEMI.name;
      default:
        return "Invalid Diabetic Type";
    }
  }
}
