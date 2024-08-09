enum EnumUserRole {
  ADMIN(roleId: 1, roleName: "Admin"),
  DOCTOR(roleId: 2, roleName: "Doctor"),
  PATIENT(roleId: 3, roleName: "Patient");

  final int roleId;
  final String roleName;

  const EnumUserRole({required this.roleId, required this.roleName});

  static String getRoleName(int roleId) {
    switch (roleId) {
      case 1:
        return EnumUserRole.ADMIN.roleName;
      case 2:
        return EnumUserRole.DOCTOR.roleName;
      case 3:
        return EnumUserRole.PATIENT.roleName;
      default:
        throw ArgumentError("Invalid roleId");
    }
  }
}
