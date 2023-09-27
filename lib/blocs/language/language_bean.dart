class LanguageBean {
  int? id;
  String? local;
  String? language;

  LanguageBean({this.id, this.local, this.language});

  LanguageBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    local = json['local'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['local'] = this.local;
    data['language'] = this.language;
    return data;
  }
}