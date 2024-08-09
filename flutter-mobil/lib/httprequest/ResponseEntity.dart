class ResponseEntity {
  bool success;
  String message;
  var data;

  ResponseEntity(
      {required this.success, required this.message, required this.data});

  factory ResponseEntity.fromJson(Map<String, dynamic> json) {
    return ResponseEntity(
        success: json["success"], message: json["message"], data: json["data"]);
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }

  @override
  String toString() {
    return 'ResponseEntity{success: $success, message: $message, data: $data}';
  }
}
