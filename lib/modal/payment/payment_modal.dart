import 'package:webnsoft_solution/modal/order/user_role_order_list_modal.dart';

class CustomerPaymentModal {
  bool? status;
  String? message;
  PaymentRecord? record;
  //List<Order>? order;

  CustomerPaymentModal({this.status, this.message, this.record,/* this.order*/});

  CustomerPaymentModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    record = json['record'] != null ? PaymentRecord.fromJson(json['record']) : null;
   /* if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (record != null) {
      data['record'] = record!.toJson();
    }
   /* if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class PaymentRecord {
  int? userId;
  String? executiveId;
  String? userType;
  int? amount;
  String? paymentType;
  String? image;
  String? date;
  String? imageUrl;
  int? orderId;
  int? dueAmount;
  String? updatedAt;
  String? createdAt;
  int? id;



  PaymentRecord(
      {this.userId,
        this.executiveId,
        this.userType,
        this.amount,
        this.paymentType,
        this.image,
        this.date,
        this.imageUrl,
        this.orderId,
        this.dueAmount,
        this.updatedAt,
        this.createdAt,
        this.id});

  PaymentRecord.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    executiveId = json['executive_id'];
    userType = json['user_type'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    image = json['image'];
    date = json['date'];
    imageUrl = json['image_url'];
    orderId = json['order_id'];
    dueAmount = json['due_amount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['executive_id'] = executiveId;
    data['user_type'] = userType;
    data['amount'] = amount;
    data['payment_type'] = paymentType;
    data['image'] = image;
    data['date'] = date;
    data['image_url'] = imageUrl;
    data['order_id'] = orderId;
    data['due_amount'] = dueAmount;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

/*class Order {
  int? id;
  String? totalAmount;
  String? allProduct;
  String? userType;
  String? userId;
  String? bookedById;
  String? adminId;
  String? orderStatus;
  String? trackingId;
  Null? remark;
  String? shippingAddress;
  String? paymentStatus;
  String? paymentAmount;
  String? paymentDate;
  int? totalQuantity;
  String? pickUpDate;
  String? pickUpTime;
  String? pickUpType;
  String? currentLocation;
  String? longitude;
  String? latitude;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
        this.totalAmount,
        this.allProduct,
        this.userType,
        this.userId,
        this.bookedById,
        this.adminId,
        this.orderStatus,
        this.trackingId,
        this.remark,
        this.shippingAddress,
        this.paymentStatus,
        this.paymentAmount,
        this.paymentDate,
        this.totalQuantity,
        this.pickUpDate,
        this.pickUpTime,
        this.pickUpType,
        this.currentLocation,
        this.longitude,
        this.latitude,
        this.createdAt,
        this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    allProduct = json['allProduct'];
    userType = json['user_type'];
    userId = json['user_id'];
    bookedById = json['booked_by_id'];
    adminId = json['admin_id'];
    orderStatus = json['order_status'];
    trackingId = json['tracking_id'];
    remark = json['remark'];
    shippingAddress = json['shipping_address'];
    paymentStatus = json['payment_status'];
    paymentAmount = json['payment_amount'];
    paymentDate = json['payment_date'];
    totalQuantity = json['total_quantity'];
    pickUpDate = json['pick_up_date'];
    pickUpTime = json['pick_up_time'];
    pickUpType = json['pick_up_type'];
    currentLocation = json['current_location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_amount'] = totalAmount;
    data['allProduct'] = allProduct;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['booked_by_id'] = bookedById;
    data['admin_id'] = adminId;
    data['order_status'] = orderStatus;
    data['tracking_id'] = trackingId;
    data['remark'] = remark;
    data['shipping_address'] = shippingAddress;
    data['payment_status'] = paymentStatus;
    data['payment_amount'] = paymentAmount;
    data['payment_date'] = paymentDate;
    data['total_quantity'] = totalQuantity;
    data['pick_up_date'] = pickUpDate;
    data['pick_up_time'] = pickUpTime;
    data['pick_up_type'] = pickUpType;
    data['current_location'] = currentLocation;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}*/
