enum EnumUserRole {

  ADMIN(roleId: 1,roleName: "Admin"),
  HEALTHCARE_PERSONEL(roleId: 2,roleName: "HealthCare Personel"),
  PATIENT(roleId: 3,roleName: "Patient");

  final int roleId;
  final String roleName;
  const EnumUserRole({required this.roleId, required this.roleName});

  static String getRoleName(int roleId){

      switch (roleId) {
      case 1:
      return EnumUserRole.ADMIN.name;
      case 2:
      return EnumUserRole.HEALTHCARE_PERSONEL.name;
      case 3:
      return EnumUserRole.PATIENT.name;
      default:
      throw ArgumentError("Invalid roleId");
      }

  }
}
