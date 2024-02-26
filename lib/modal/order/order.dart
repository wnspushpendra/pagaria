class OrderResponse {
  bool? status;
  String? message;
  OrderDetail? orderDetail;

  OrderResponse({this.status, this.message, this.orderDetail});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail =
    json['record'] != null ? OrderDetail.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['record'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  String? totalAmount;
  String? allProduct;
  String? userType;
  String? userId;
  String? bookedById;
  String? adminId;
  String? orderStatus;
  String? trackingId;
  String? remark;
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
  String? pdfUrl;
  String? pdfName;
  String? createdAt;
  String? updatedAt;

  OrderDetail(
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
        this.pdfUrl,
        this.pdfName,
        this.createdAt,
        this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
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
    pdfUrl = json['pdf_url'];
    pdfName = json['pdf_name'];
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
    data['pdf_url'] = pdfUrl;
    data['pdf_name'] = pdfName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}




/*
class OrderResponse {
  bool? status;
  String? message;
  OrderDetail? orderDetail;

  OrderResponse({this.status, this.message, this.orderDetail});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetail =
    json['record'] != null ? OrderDetail.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderDetail != null) {
      data['record'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  String? totalAmount;
  String? userType;
  String? userId;
  String? bookedById;
  String? allProduct;
  String? adminId;
  String? updatedAt;
  String? createdAt;
  int? id;

  OrderDetail(
      {this.totalAmount,
        this.userType,
        this.userId,
        this.bookedById,
        this.allProduct,
        this.adminId,
        this.updatedAt,
        this.createdAt,
        this.id});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    userType = json['user_type'];
    userId = json['user_id'];
    bookedById = json['booked_by_id'];
    allProduct = json['allProduct'];
    adminId = json['admin_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    data['user_type'] = userType;
    data['user_id'] = userId;
    data['booked_by_id'] = bookedById;
    data['allProduct'] = allProduct;
    data['admin_id'] = adminId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
*/
