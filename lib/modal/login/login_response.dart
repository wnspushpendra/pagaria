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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.profileData != null) {
      data['record'] = this.profileData!.toJson();
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
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? roleId;
  String? registeredId;
  String? domain;
  String? contactNo;
  String? email;
  String? dob;
  String? gender;
  String? profileImage;
  String? profileImageUrl;
  String? gstNo;
  String? firmName;
  String? aadharNo;
  String? panCardNo;
  String? city;
  String? state;
  String? address;
  String? zipCode;
  String? emailVerifiedAt;
  String? userStatus;
  String? createdById;
  String? adminId;
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
        this.dob,
        this.gender,
        this.profileImage,
        this.profileImageUrl,
        this.gstNo,
        this.firmName,
        this.aadharNo,
        this.panCardNo,
        this.city,
        this.state,
        this.address,
        this.zipCode,
        this.emailVerifiedAt,
        this.userStatus,
        this.createdById,
        this.adminId,
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
    dob = json['dob'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    profileImageUrl = json['profile_image_url'];
    gstNo = json['gst_no'];
    firmName = json['firm_name'];
    aadharNo = json['aadhar_no'];
    panCardNo = json['pan_card_no'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    zipCode = json['zip_code'];
    emailVerifiedAt = json['email_verified_at'];
    userStatus = json['user_status'];
    createdById = json['created_by_id'];
    adminId = json['admin_id'];
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
    data['dob'] = dob;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['profile_image_url'] = profileImageUrl;
    data['gst_no'] = gstNo;
    data['firm_name'] = firmName;
    data['aadhar_no'] = aadharNo;
    data['pan_card_no'] = panCardNo;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['email_verified_at'] = emailVerifiedAt;
    data['user_status'] = userStatus;
    data['created_by_id'] = createdById;
    data['admin_id'] = adminId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
