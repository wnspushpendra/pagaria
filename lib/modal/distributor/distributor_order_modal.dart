class DistributorOrder {
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
  String? createdAt;
  String? updatedAt;

  DistributorOrder(
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

  DistributorOrder.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['allProduct'] = this.allProduct;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['booked_by_id'] = this.bookedById;
    data['admin_id'] = this.adminId;
    data['order_status'] = this.orderStatus;
    data['tracking_id'] = this.trackingId;
    data['remark'] = this.remark;
    data['shipping_address'] = this.shippingAddress;
    data['payment_status'] = this.paymentStatus;
    data['payment_amount'] = this.paymentAmount;
    data['payment_date'] = this.paymentDate;
    data['total_quantity'] = this.totalQuantity;
    data['pick_up_date'] = this.pickUpDate;
    data['pick_up_time'] = this.pickUpTime;
    data['pick_up_type'] = this.pickUpType;
    data['current_location'] = this.currentLocation;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
