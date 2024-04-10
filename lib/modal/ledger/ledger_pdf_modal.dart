class LedgerPdfModal {
  bool? status;
  String? message;
  String? pdfUrl;

  LedgerPdfModal({this.status, this.message, this.pdfUrl});

  LedgerPdfModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pdfUrl = json['pdf_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['pdf_url'] = pdfUrl;
    return data;
  }
}
