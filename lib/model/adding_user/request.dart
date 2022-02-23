class AddingUserRequest {
  String? username;
  String? password;
  String? email;
  Null? imageAsBase64;
  String? intrestId;

  AddingUserRequest(
      {this.username,
        this.password,
        this.email,
        this.imageAsBase64,
        this.intrestId});

  AddingUserRequest.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    password = json['Password'];
    email = json['Email'];
    imageAsBase64 = json['ImageAsBase64'];
    intrestId = json['IntrestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['Email'] = this.email;
    data['ImageAsBase64'] = this.imageAsBase64;
    data['IntrestId'] = this.intrestId;
    return data;
  }
}