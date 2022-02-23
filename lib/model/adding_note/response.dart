class AddingNoteResponse {
  String? type;
  String? title;
  int? status;
  String? traceId;

  AddingNoteResponse({this.type, this.title, this.status, this.traceId});

  AddingNoteResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    traceId = json['traceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['status'] = this.status;
    data['traceId'] = this.traceId;
    return data;
  }
}