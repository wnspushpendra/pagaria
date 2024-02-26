class DistributorPaymentModal {
  bool? status;
  String? message;
  List<DistributorPayment>? completedPayment;
  List<DistributorPayment>? recentPayment;
  List<DistributorPayment>? duePayment;

  DistributorPaymentModal(
      {this.status,
        this.message,
        this.completedPayment,
        this.recentPayment,
        this.duePayment});

  DistributorPaymentModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['completedPayment'] != null) {
      completedPayment = <DistributorPayment>[];
      json['completedPayment'].forEach((v) {
        completedPayment!.add(DistributorPayment.fromJson(v));
      });
    }
    if (json['recentPayment'] != null) {
      recentPayment = <DistributorPayment>[];
      json['recentPayment'].forEach((v) {
        recentPayment!.add(DistributorPayment.fromJson(v));
      });
    }
    if (json['duePayment'] != null) {
      duePayment = <DistributorPayment>[];
      json['duePayment'].forEach((v) {
        duePayment!.add(DistributorPayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (completedPayment != null) {
      data['completedPayment'] =
          completedPayment!.map((v) => v.toJson()).toList();
    }
    if (recentPayment != null) {
      data['recentPayment'] =
          recentPayment!.map((v) => v.toJson()).toList();
    }
    if (duePayment != null) {
      data['duePayment'] = duePayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistributorPayment {
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
  ExecutiveData? executiveData;
  UserData? userData;
  OrderDetails? orderDetails;

  DistributorPayment(
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
        this.updatedAt,
        this.executiveData,
        this.userData,
        this.orderDetails});

  DistributorPayment.fromJson(Map<String, dynamic> json) {
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
    executiveData = json['executive_data'] != null
        ? ExecutiveData.fromJson(json['executive_data'])
        : null;
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (executiveData != null) {
      data['executive_data'] = executiveData!.toJson();
    }
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? fullName;
  String? roleId;
  String? email;
  String? contactNo;

  UserData({this.id, this.fullName, this.roleId, this.email, this.contactNo});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleId = json['role_id'];
    email = json['email'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_id'] = roleId;
    data['email'] = email;
    data['contact_no'] = contactNo;
    return data;
  }
}
class ExecutiveData {
  int? id;
  String? fullName;
  String? roleId;
  String? email;
  String? contactNo;

  ExecutiveData({this.id, this.fullName, this.roleId, this.email, this.contactNo});

  ExecutiveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleId = json['role_id'];
    email = json['email'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_id'] = roleId;
    data['email'] = email;
    data['contact_no'] = contactNo;
    return data;
  }
}


class OrderDetails {
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

  OrderDetails(
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

  OrderDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class RecentPayment {
  int? id;
  int? amount;
  String? paymentType;
  Null? paymentReferenceId;
  Null? imageUrl;
  String? image;
  String? userType;
  String? date;
  int? dueAmount;
  String? orderId;
  String? userId;
  Null? executiveId;
  String? createdAt;
  String? updatedAt;
  String? executiveData;
  UserData? userData;
  OrderDetails? orderDetails;

  RecentPayment(
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
        this.updatedAt,
        this.executiveData,
        this.userData,
        this.orderDetails});

  RecentPayment.fromJson(Map<String, dynamic> json) {
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
    executiveData = json['executive_data'];
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['executive_data'] = executiveData;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.toJson();
    }
    return data;
  }
}



