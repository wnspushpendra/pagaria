class TargetModal {
  bool? status;
  String? message;
  List<Target>? target;

  TargetModal({this.status, this.message, this.target});

  TargetModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['target'] != null) {
      target = <Target>[];
      json['target'].forEach((v) {
        target!.add(new Target.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.target != null) {
      data['target'] = this.target!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Target {
  String? type;
  String? target;
  int? achievedTarget;

  Target({this.type, this.target, this.achievedTarget});

  Target.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    target = json['target'];
    achievedTarget = json['achieved_target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['target'] = target;
    data['achieved_target'] = achievedTarget;
    return data;
  }
}
