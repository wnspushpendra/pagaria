class FirmCustomerResponseModal {
  bool? status;
  String? message;
  List<Firm>? firm;

  FirmCustomerResponseModal({this.status, this.message, this.firm});

  FirmCustomerResponseModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['record'] != null) {
      firm = <Firm>[];
      json['record'].forEach((v) {
        firm!.add(Firm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (firm != null) {
      data['record'] = firm!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Firm {
  int? id;
  String? firmName;
  List<AllCustomer>? allCustomer;

  Firm({this.id, this.firmName, this.allCustomer});

  Firm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firmName = json['firm_name'];
    if (json['all_customer'] != null) {
      allCustomer = <AllCustomer>[];
      json['all_customer'].forEach((v) {
        allCustomer!.add(AllCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firm_name'] = firmName;
    if (allCustomer != null) {
      data['all_customer'] = allCustomer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCustomer {
  int? id;
  String? fullName;
  String? email;
  String? contactNo;

  AllCustomer({this.id, this.fullName, this.email, this.contactNo});

  AllCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['contact_no'] = contactNo;
    return data;
  }
}
