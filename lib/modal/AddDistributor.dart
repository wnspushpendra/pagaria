class AddDistributorResponse {
  bool? status;
  String? message;
  DistributorProfileRecord? record;

  AddDistributorResponse({this.status, this.message, this.record});

  AddDistributorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    record =
    json['record'] != null ? DistributorProfileRecord.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (record != null) {
      data['record'] = record!.toJson();
    }
    return data;
  }
}

class DistributorProfileRecord {
  String? fullName;
  String? contactNo;
  String? email;
  String? gender;
  String? firmName;
  String? aadharNo;
  String? panCardNo;
  String? gstNo;
  String? city;
  String? state;
  String? address;
  String? zipCode;
  int? roleId;
  String? profileImage;
  String? profileImageUrl;
  String? updatedAt;
  String? createdAt;
  int? id;



  DistributorProfileRecord(
      {this.fullName,
        this.contactNo,
        this.email,
        this.gender,
        this.firmName,
        this.aadharNo,
        this.panCardNo,
        this.gstNo,
        this.city,
        this.state,
        this.address,
        this.zipCode,
        this.roleId,
        this.profileImage,
        this.profileImageUrl,
        this.updatedAt,
        this.createdAt,
        this.id});



  DistributorProfileRecord.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    contactNo = json['contact_no'];
    email = json['email'];
    gender = json['gender'];
    firmName = json['firm_name'];
    aadharNo = json['aadhar_no'];
    panCardNo = json['pan_card_no'];
    gstNo = json['gst_no'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    zipCode = json['zip_code'];
    roleId = json['role_id'];
    profileImage = json['profile_image'];
    profileImageUrl = json['profile_image_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['contact_no'] = contactNo;
    data['email'] = email;
    data['gender'] = gender;
    data['firm_name'] = firmName;
    data['aadhar_no'] = aadharNo;
    data['pan_card_no'] = panCardNo;
    data['gst_no'] = gstNo;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['role_id'] = roleId;
    data['profile_image'] = profileImage;
    data['profile_image_url'] = profileImageUrl;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
