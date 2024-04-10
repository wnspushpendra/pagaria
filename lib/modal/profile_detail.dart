class ProfileDetailResponse {
  bool? status;
  String? message;
  Profile? userProfile;

  ProfileDetailResponse({this.status, this.message, this.userProfile});

  ProfileDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userProfile =
    json['record'] != null ? Profile.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userProfile != null) {
      data['record'] = userProfile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? fullName;
  String? roleId;
  String? registeredId;
  String? domain;
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
  String? houseNo;
  String? town;
  String? landmark;
  String? address;
  String? zipCode;
  String? emailVerifiedAt;
  String? userStatus;
  String? createdById;
  String? adminId;
  String? createdAt;
  String? updatedAt;

  Profile(
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
        this.houseNo,
        this.town,
        this.landmark,
        this.address,
        this.zipCode,
        this.emailVerifiedAt,
        this.userStatus,
        this.createdById,
        this.adminId,
        this.createdAt,
        this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
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
    houseNo = json['house_number'];
     town = json['town'];
    landmark = json['landmark'];
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['house_number'] = houseNo;
    data['town'] = town;
    data['landmark'] = landmark;
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
