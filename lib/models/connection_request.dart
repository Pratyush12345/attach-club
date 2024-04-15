class ConnectionRequest {
  final String phoneNo;
  final String status;
  final String updateTime;
  final String uid;

  ConnectionRequest({
    required this.phoneNo,
    required this.status,
    required this.updateTime,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      "phoneNo": phoneNo,
      "status": status,
      "updateTime": updateTime,
    };
  }

  factory ConnectionRequest.fromMap(Map<String, dynamic> map, String uid) {
    return ConnectionRequest(
      phoneNo: map["phoneNo"],
      status: map["status"],
      updateTime: map["updateTime"],
      uid: uid,
    );
  }
}
