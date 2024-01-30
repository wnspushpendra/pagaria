class CheckInCheckOutResponse {
  bool? status;
  String? message;
  CheckInOutRecord? checkInOutRecord;

  CheckInCheckOutResponse({this.status, this.message, this.checkInOutRecord});

  CheckInCheckOutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    checkInOutRecord =
    json['record'] != null ? CheckInOutRecord.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (checkInOutRecord != null) {
      data['record'] = checkInOutRecord!.toJson();
    }
    return data;
  }
}

class CheckInOutRecord {
  String? marketingExecutiveId;
  String? date;
  String? checkInDatetime;
  String? checkInTime;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  CheckInOutRecord(
      {this.marketingExecutiveId,
        this.date,
        this.checkInDatetime,
        this.checkInTime,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  CheckInOutRecord.fromJson(Map<String, dynamic> json) {
    marketingExecutiveId = json['marketing_executive_id'];
    date = json['date'];
    checkInDatetime = json['check_in_datetime'];
    checkInTime = json['check_in_time'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['marketing_executive_id'] = marketingExecutiveId;
    data['date'] = date;
    data['check_in_datetime'] = checkInDatetime;
    data['check_in_time'] = checkInTime;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
