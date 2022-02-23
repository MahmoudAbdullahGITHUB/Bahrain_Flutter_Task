class AddingNoteRequest {
  String? text;
  String? userId;
  String? placeDateTime;

  AddingNoteRequest({this.text, this.userId, this.placeDateTime});

  AddingNoteRequest.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    userId = json['UserId'];
    placeDateTime = json['PlaceDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Text'] = text;
    data['UserId'] = userId;
    data['PlaceDateTime'] = placeDateTime;
    return data;
  }
}