class CustomerPaymentModal {
  bool? status;
  String? message;
  Record? record;

  CustomerPaymentModal({this.status, this.message, this.record});

  CustomerPaymentModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    record =
    json['record'] != null ? Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (record != null) {
      data['record'] = record!.toJson();
    }
    return data;
  }
}

class Record {
  String? userId;
  String? userType;
  String? amount;
  String? paymentType;
  String? updatedAt;
  String? createdAt;
  int? id;

  Record(
      {this.userId,
        this.userType,
        this.amount,
        this.paymentType,
        this.updatedAt,
        this.createdAt,
        this.id});

  Record.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['amount'] = amount;
    data['payment_type'] = paymentType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
