class CheckInCheckOutResponse {
  bool? status;
  String? message;
  CheckInOutRecord? checkInOutRecord;

  CheckInCheckOutResponse({this.status, this.message, this.checkInOutRecord});

  CheckInCheckOutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    checkInOutRecord =
    json['record'] != null ? new CheckInOutRecord.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.checkInOutRecord != null) {
      data['record'] = this.checkInOutRecord!.toJson();
    }
    return data;
  }
}

class CheckInOutRecord {
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

  CheckInOutRecord(
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

  CheckInOutRecord.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marketing_executive_id'] = this.marketingExecutiveId;
    data['date'] = this.date;
    data['check_in_datetime'] = this.checkInDatetime;
    data['check_out_datetime'] = this.checkOutDatetime;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['total_working_time'] = this.totalWorkingTime;
    data['latitude_checkin'] = this.latitudeCheckin;
    data['longitude_checkin'] = this.longitudeCheckin;
    data['address_checkin'] = this.addressCheckin;
    data['zip_code_checkin'] = this.zipCodeCheckin;
    data['latitude_checkout'] = this.latitudeCheckout;
    data['longitude_checkout'] = this.longitudeCheckout;
    data['address_checkout'] = this.addressCheckout;
    data['zip_code_checkout'] = this.zipCodeCheckout;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
