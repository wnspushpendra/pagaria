import 'package:webnsoft_solution/modal/login/login_response.dart';

class DistributorListResponse {
  bool? status;
  String? message;
  List<User>? customerList;

  DistributorListResponse({this.status, this.message, this.customerList});

  DistributorListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      customerList = <User>[];
      json['record'].forEach((v) {
        customerList!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.customerList != null) {
      data['record'] = customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Customer {
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
  String? address;
  String? zipCode;
  String? emailVerifiedAt;
  String? userStatus;
  String? createdById;
  String? adminId;
  String? createdAt;
  String? updatedAt;
  CreatedByUser? createdByUser;
  UserRole? userRole;

  Customer(
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
        this.emailVerifiedAt,
        this.userStatus,
        this.createdById,
        this.adminId,
        this.createdAt,
        this.updatedAt,
        this.createdByUser,
        this.userRole});

  Customer.fromJson(Map<String, dynamic> json) {
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
    emailVerifiedAt = json['email_verified_at'];
    userStatus = json['user_status'];
    createdById = json['created_by_id'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdByUser = json['created_by_user'] != null
        ? new CreatedByUser.fromJson(json['created_by_user'])
        : null;
    userRole = json['user_role'] != null
        ? new UserRole.fromJson(json['user_role'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['role_id'] = this.roleId;
    data['registered_id'] = this.registeredId;
    data['domain'] = this.domain;
    data['contact_no'] = this.contactNo;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['profile_image'] = this.profileImage;
    data['profile_image_url'] = this.profileImageUrl;
    data['gst_no'] = this.gstNo;
    data['firm_name'] = this.firmName;
    data['aadhar_no'] = this.aadharNo;
    data['pan_card_no'] = this.panCardNo;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['zip_code'] = this.zipCode;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['user_status'] = this.userStatus;
    data['created_by_id'] = this.createdById;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdByUser != null) {
      data['created_by_user'] = this.createdByUser!.toJson();
    }
    if (this.userRole != null) {
      data['user_role'] = this.userRole!.toJson();
    }
    return data;
  }
}*/

class CreatedByUser {
  int? id;
  String? fullName;
  String? email;
  String? roleId;
  UserRole? userRole;

  CreatedByUser(
      {this.id, this.fullName, this.email, this.roleId, this.userRole});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    roleId = json['role_id'];
    userRole = json['user_role'] != null
        ? new UserRole.fromJson(json['user_role'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    if (this.userRole != null) {
      data['user_role'] = this.userRole!.toJson();
    }
    return data;
  }
}

class UserRole {
  int? id;
  String? userRole;
  String? role;

  UserRole({this.id, this.userRole, this.role});

  UserRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRole = json['user_role'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_role'] = this.userRole;
    data['role'] = this.role;
    return data;
  }
}
