class NotificationCountModal {
  bool? status;
  int? count;

  NotificationCountModal({this.status, this.count});

  NotificationCountModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    return data;
  }
}
