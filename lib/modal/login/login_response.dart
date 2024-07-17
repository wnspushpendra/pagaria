class UserResponse {
  bool? status;
  String? message;
  ProfileData? profileData;

  UserResponse({this.status, this.message, this.profileData});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    profileData =
    json['record'] != null ? new ProfileData.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (profileData != null) {
      data['record'] = profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? token;
  User? user;

  ProfileData({this.token, this.user});

  ProfileData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? roleId;
  String? registeredId;
  Null? domain;
  String? contactNo;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? profileImage;
  String? profileImageUrl;
  String? gstNo;
  String? firmName;
  String? aadharNo;
  String? panCardNo;
  String? country;
  String? city;
  String? state;
  String? address;
  String? zipCode;
  String? landmark;
  String? town;
  String? houseNumber;
  String? emailVerifiedAt;
  String? userStatus;
  String? createdById;
  String? adminId;
  String? deviceType;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.fullName,
        this.roleId,
        this.registeredId,
        this.domain,
        this.contactNo,
        this.email,
        this.gender,
        this.dateOfBirth,
        this.profileImage,
        this.profileImageUrl,
        this.gstNo,
        this.firmName,
        this.aadharNo,
        this.panCardNo,
        this.country,
        this.city,
        this.state,
        this.address,
        this.zipCode,
        this.landmark,
        this.town,
        this.houseNumber,
        this.emailVerifiedAt,
        this.userStatus,
        this.createdById,
        this.adminId,
        this.deviceType,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    roleId = json['role_id'];
    registeredId = json['registered_id'];
    domain = json['domain'];
    contactNo = json['contact_no'];
    email = json['email'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    profileImage = json['profile_image'];
    profileImageUrl = json['profile_image_url'];
    gstNo = json['gst_no'];
    firmName = json['firm_name'];
    aadharNo = json['aadhar_no'];
    panCardNo = json['pan_card_no'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    town = json['town'];
    houseNumber = json['house_number'];
    emailVerifiedAt = json['email_verified_at'];
    userStatus = json['user_status'];
    createdById = json['created_by_id'];
    adminId = json['admin_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['role_id'] = roleId;
    data['registered_id'] = registeredId;
    data['domain'] = domain;
    data['contact_no'] = contactNo;
    data['email'] = email;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['profile_image'] = profileImage;
    data['profile_image_url'] = profileImageUrl;
    data['gst_no'] = gstNo;
    data['firm_name'] = firmName;
    data['aadhar_no'] = aadharNo;
    data['pan_card_no'] = panCardNo;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['landmark'] = landmark;
    data['town'] = town;
    data['house_number'] = houseNumber;
    data['email_verified_at'] = emailVerifiedAt;
    data['user_status'] = userStatus;
    data['created_by_id'] = createdById;
    data['admin_id'] = adminId;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
