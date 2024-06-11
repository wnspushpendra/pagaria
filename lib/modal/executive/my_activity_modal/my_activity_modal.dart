class MyActivityModal {
  bool? status;
  String? message;
  List<MyActivityData>? myActivityData;

  MyActivityModal({this.status, this.message, this.myActivityData});

  MyActivityModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      myActivityData = <MyActivityData>[];
      json['record'].forEach((v) {
        myActivityData!.add(MyActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (myActivityData != null) {
      data['record'] = myActivityData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyActivityData {
  int? id;
  String? marketingExecutiveId;
  String? date;
  String? checkInDatetime;
  String? checkOutDatetime;
  String? checkInTime;
  String? checkOutTime;
  String? totalWorkingTime;
  String? latitudeCheckin;
  String? longitudeCheckin;
  String? addressCheckin;
  String? zipCodeCheckin;
  String? latitudeCheckout;
  String? longitudeCheckout;
  String? addressCheckout;
  String? zipCodeCheckout;
  String? status;
  String? createdAt;
  String? updatedAt;

  MyActivityData(
      {this.id,
        this.marketingExecutiveId,
        this.date,
        this.checkInDatetime,
        this.checkOutDatetime,
        this.checkInTime,
        this.checkOutTime,
        this.totalWorkingTime,
        this.latitudeCheckin,
        this.longitudeCheckin,
        this.addressCheckin,
        this.zipCodeCheckin,
        this.latitudeCheckout,
        this.longitudeCheckout,
        this.addressCheckout,
        this.zipCodeCheckout,
        this.status,
        this.createdAt,
        this.updatedAt});

  MyActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketingExecutiveId = json['marketing_executive_id'];
    date = json['date'];
    checkInDatetime = json['check_in_datetime'];
    checkOutDatetime = json['check_out_datetime'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    totalWorkingTime = json['total_working_time'];
    latitudeCheckin = json['latitude_checkin'];
    longitudeCheckin = json['longitude_checkin'];
    addressCheckin = json['address_checkin'];
    zipCodeCheckin = json['zip_code_checkin'];
    latitudeCheckout = json['latitude_checkout'];
    longitudeCheckout = json['longitude_checkout'];
    addressCheckout = json['address_checkout'];
    zipCodeCheckout = json['zip_code_checkout'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['marketing_executive_id'] = marketingExecutiveId;
    data['date'] = date;
    data['check_in_datetime'] = checkInDatetime;
    data['check_out_datetime'] = checkOutDatetime;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['total_working_time'] = totalWorkingTime;
    data['latitude_checkin'] = latitudeCheckin;
    data['longitude_checkin'] = longitudeCheckin;
    data['address_checkin'] = addressCheckin;
    data['zip_code_checkin'] = zipCodeCheckin;
    data['latitude_checkout'] = latitudeCheckout;
    data['longitude_checkout'] = longitudeCheckout;
    data['address_checkout'] = addressCheckout;
    data['zip_code_checkout'] = zipCodeCheckout;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Method to convert MyActivityData to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marketing_executive_id': marketingExecutiveId,
      'date': date,
      'check_in_datetime': checkInDatetime,
      'check_out_datetime': checkOutDatetime,
      'check_in_time': checkInTime,
      'check_out_time': checkOutTime,
      'total_working_time': totalWorkingTime,
      'latitude_checkin': latitudeCheckin,
      'longitude_checkin': longitudeCheckin,
      'address_checkin': addressCheckin,
      'zip_code_checkin': zipCodeCheckin,
      'latitude_checkout': latitudeCheckout,
      'longitude_checkout': longitudeCheckout,
      'address_checkout': addressCheckout,
      'zip_code_checkout': zipCodeCheckout,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
