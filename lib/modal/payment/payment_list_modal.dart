class PaymentListModal {
  bool? status;
  String? message;
  List<PaymentDetailData>? paymentDetail;

  PaymentListModal({this.status, this.message, this.paymentDetail});

  PaymentListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      paymentDetail = <PaymentDetailData>[];
      json['record'].forEach((v) {
        paymentDetail!.add(PaymentDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (paymentDetail != null) {
      data['record'] = paymentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetailData {
  int? id;
  int? amount;
  String? paymentType;
  String? paymentReferenceId;
  String? imageUrl;
  String? image;
  String? userType;
  String? date;
  int? userId;
  String? executiveId;
  String? createdAt;
  String? updatedAt;
  UserData? userData;

  PaymentDetailData(
      {this.id,
        this.amount,
        this.paymentType,
        this.paymentReferenceId,
        this.imageUrl,
        this.image,
        this.userType,
        this.date,
        this.userId,
        this.executiveId,
        this.createdAt,
        this.updatedAt,
        this.userData});

  PaymentDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    paymentReferenceId = json['payment_reference_id'];
    imageUrl = json['image_url'];
    image = json['image'];
    userType = json['user_type'];
    date = json['date'];
    userId = json['user_id'];
    executiveId = json['executive_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['payment_type'] = paymentType;
    data['payment_reference_id'] = paymentReferenceId;
    data['image_url'] = imageUrl;
    data['image'] = image;
    data['user_type'] = userType;
    data['date'] = date;
    data['user_id'] = userId;
    data['executive_id'] = executiveId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? fullName;
  String? roleId;
  String? email;

  UserData({this.id, this.fullName, this.roleId, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleId = json['role_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_id'] = roleId;
    data['email'] = email;
    return data;
  }
}
