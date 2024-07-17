class NotificationModal {
  bool? status;
  String? message;
  List<NotificationData>? notification;

  NotificationModal({this.status, this.message, this.notification});

  NotificationModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      notification = <NotificationData>[];
      json['record'].forEach((v) {
        notification!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (notification != null) {
      data['record'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? notificationTitle;
  String? notificationMessage;
  String? notificationDate;
  String? notificationTime;
  String? notificationType;
  String? notificationStatus;
  String? userId;
  String? adminId;
  String? createdAt;
  String? updatedAt;

  NotificationData(
      {this.id,
        this.notificationTitle,
        this.notificationMessage,
        this.notificationDate,
        this.notificationTime,
        this.notificationType,
        this.notificationStatus,
        this.userId,
        this.adminId,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationTitle = json['notification_title'];
    notificationMessage = json['notification_message'];
    notificationDate = json['notification_date'];
    notificationTime = json['notification_time'];
    notificationType = json['notification_type'];
    notificationStatus = json['notification_status'];
    userId = json['user_id'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notification_title'] = notificationTitle;
    data['notification_message'] = notificationMessage;
    data['notification_date'] = notificationDate;
    data['notification_time'] = notificationTime;
    data['notification_type'] = notificationType;
    data['notification_status'] = notificationStatus;
    data['user_id'] = userId;
    data['admin_id'] = adminId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
