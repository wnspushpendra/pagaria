class CheckInDetails {
  bool? status;
  String? message;
  CheckInData? checkInData;

  CheckInDetails({this.status, this.message, this.checkInData});

  CheckInDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    checkInData =
    json['record'] != null ? CheckInData.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (checkInData != null) {
      data['record'] = checkInData!.toJson();
    }
    return data;
  }
}

class CheckInData {
  int? id;
  String? status;
  String? date;
  String? checkInTime;
  String? checkOutTime;

  CheckInData(
      {this.id, this.status, this.date, this.checkInTime, this.checkOutTime});

  CheckInData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    return data;
  }
}
