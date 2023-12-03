class NotificationClass {
  String? details;
  String? title;
  String? status;
  String? time;
  bool? open;

  NotificationClass(
      {this.details, this.title, this.status, this.time, this.open});

  NotificationClass.fromJson(Map<String, dynamic> json) {
    details = json['image'];
    title = json['name'];
    status = json['status'];
    time = json['time'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.details;
    data['name'] = this.title;
    data['status'] = this.status;
    data['time'] = this.time;
    data['open'] = this.open;
    return data;
  }
}
