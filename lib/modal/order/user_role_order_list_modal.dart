class UserRoleOrderModal {
  bool? status;
  String? message;
  List<Order>? order;

  UserRoleOrderModal({this.status, this.message, this.order});

  UserRoleOrderModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      order = <Order>[];
      json['record'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['record'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
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
  String? landmark;
  String? zipCode;
  String? address;
  String? state;
  String? city;
  String? houseNumber;
  String? town;
  String? createdAt;
  String? updatedAt;
  String? remainingAmount;
  BookedUser? bookedUser;
  UserData? userData;
  List<PaymentDetails>? paymentDetails;

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
        this.pdfUrl,
        this.pdfName,
        this.landmark,
        this.zipCode,
        this.address,
        this.state,
        this.city,
        this.houseNumber,
        this.town,
        this.createdAt,
        this.updatedAt,
        this.remainingAmount,
        this.bookedUser,
        this.userData,
        this.paymentDetails});

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
    pdfUrl = json['pdf_url'];
    pdfName = json['pdf_name'];
    landmark = json['landmark'];
    zipCode = json['zip_code'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    houseNumber = json['house_number'];
    town = json['town'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    remainingAmount = json['remaining_amount'];
    bookedUser = json['booked_user'] != null
        ? BookedUser.fromJson(json['booked_user'])
        : null;
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['pdf_url'] = this.pdfUrl;
    data['pdf_name'] = this.pdfName;
    data['landmark'] = this.landmark;
    data['zip_code'] = this.zipCode;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['house_number'] = this.houseNumber;
    data['town'] = this.town;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['remaining_amount'] = this.remainingAmount;
    if (bookedUser != null) {
      data['booked_user'] = bookedUser!.toJson();
    }
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (paymentDetails != null) {
      data['payment_details'] =
          paymentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookedUser {
  int? id;
  String? fullName;
  String? email;
  String? contactNo;
  String? city;
  String? state;
  String? address;
  String? zipCode;
  String? profileImageUrl;

  BookedUser(
      {this.id,
        this.fullName,
        this.email,
        this.contactNo,
        this.city,
        this.state,
        this.address,
        this.zipCode,
        this.profileImageUrl});

  BookedUser.fromJson(Map<String, dynamic> json) {
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

class PaymentDetails {
  int? id;
  int? amount;
  String? paymentType;
  String? paymentReferenceId;
  String? imageUrl;
  String? image;
  String? userType;
  String? date;
  int? dueAmount;
  int? orderId;
  int? userId;
  String? executiveId;
  String? createdAt;
  String? updatedAt;

  PaymentDetails(
      {this.id,
        this.amount,
        this.paymentType,
        this.paymentReferenceId,
        this.imageUrl,
        this.image,
        this.userType,
        this.date,
        this.dueAmount,
        this.orderId,
        this.userId,
        this.executiveId,
        this.createdAt,
        this.updatedAt});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    paymentReferenceId = json['payment_reference_id'];
    imageUrl = json['image_url'];
    image = json['image'];
    userType = json['user_type'];
    date = json['date'];
    dueAmount = json['due_amount'];
    orderId = json['order_id'];
    userId = json['user_id'];
    executiveId = json['executive_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['due_amount'] = dueAmount;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['executive_id'] = executiveId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
