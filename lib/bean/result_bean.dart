class ResultBean<T> {
  int? code;
  T? data;
  String? msg;

  ResultBean({this.code, this.data, this.msg});

  ResultBean.fromJson(Map<String, dynamic> json,T Function(dynamic) dataConverter) {
    code = json['code'];
    data = dataConverter(json['data']);
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['data'] = this.data;
    data['msg'] = this.msg;
    return data;
  }
}
