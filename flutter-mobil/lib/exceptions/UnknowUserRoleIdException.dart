class UnknowUserRoleIdException implements Exception {
  final String msg;

  UnknowUserRoleIdException({required this.msg});

  @override
  String toString() {
    return "Unknow-User-Role-Type-Exception: $msg";
  }
}
