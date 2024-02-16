class CustomerDueAmountModal {
  bool? status;
  String? message;
  String? totalAmount;
  int? dueAmount;

  CustomerDueAmountModal(
      {this.status, this.message, this.totalAmount, this.dueAmount});

  CustomerDueAmountModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalAmount = json['total_amount'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total_amount'] = totalAmount;
    data['due_amount'] = dueAmount;
    return data;
  }
}
