import 'package:webnsoft_solution/modal/executive/my_activity_modal/my_activity_modal.dart';

class MyVisitByDate {
  String? date;
  List<MyActivityData>? dateByData;

  MyVisitByDate({this.date, this.dateByData});

  MyVisitByDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['date_by_data'] != null) {
      dateByData = <MyActivityData>[];
      json['date_by_data'].forEach((v) {
        dateByData!.add(MyActivityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (dateByData != null) {
      data['date_by_data'] = dateByData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

