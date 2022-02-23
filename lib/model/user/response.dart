class PersonResponse {
  String? username;
  String? password;
  String? email;
  String? imageAsBase64;
  String? intrestId;
  String? id;

  PersonResponse(
      {this.username,
      this.password,
      this.email,
      this.imageAsBase64,
      this.intrestId,
      this.id});

  PersonResponse.fromJson(Map<dynamic, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    imageAsBase64 = json['imageAsBase64'];
    intrestId = json['intrestId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['imageAsBase64'] = imageAsBase64;
    data['intrestId'] = intrestId;
    data['id'] = id;
    return data;
  }
}
