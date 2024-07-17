class OrderListResponseModal {
  bool? status;
  String? message;
  List<OrderList>? orderList;

  OrderListResponseModal({this.status, this.message, this.orderList});

  OrderListResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      orderList = <OrderList>[];
      json['record'].forEach((v) {
        orderList!.add(OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderList != null) {
      data['record'] = orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
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
  String? remainingAmount;
  BookedUser? bookedUser;
  UserData? userData;

  OrderList(
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
        this.updatedAt,
        this.remainingAmount,
        this.bookedUser,
        this.userData});

  OrderList.fromJson(Map<String, dynamic> json) {
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
    remainingAmount = json['remaining_amount'];
    bookedUser = json['booked_user'] != null
        ? new BookedUser.fromJson(json['booked_user'])
        : null;
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
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
    data['remaining_amount'] = remainingAmount;
    if (bookedUser != null) {
      data['booked_user'] = bookedUser!.toJson();
    }
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class BookedUser {
  int? id;
  String? fullName;
  String? email;

  BookedUser({this.id, this.fullName, this.email});

  BookedUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    return data;
  }
}

class UserData {
  int? id;
  String? fullName;
  String? email;
  String? contactNo;
  String? city;
  String? state;
  String? address;
  String? zipCode;
  String? profileImageUrl;

  UserData(
      {this.id,
        this.fullName,
        this.email,
        this.contactNo,
        this.city,
        this.state,
        this.address,
        this.zipCode,
        this.profileImageUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    contactNo = json['contact_no'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    zipCode = json['zip_code'];
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['contact_no'] = contactNo;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['profile_image_url'] = profileImageUrl;
    return data;
  }
}

