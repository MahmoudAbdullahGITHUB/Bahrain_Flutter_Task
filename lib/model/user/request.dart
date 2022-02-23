class AddingRequest {
  int? id;

  int? barcodeID;
  int? price;
  int? count;
  String? imagePath;

  AddingRequest({this.id,this.barcodeID, this.price, this.count, this.imagePath});

  AddingRequest.fromJson(Map<String, dynamic> json) {
    barcodeID = json['barcodeID'];
    price = json['price'];
    count = json['count'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcodeID'] = this.barcodeID;
    data['price'] = this.price;
    data['count'] = this.count;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
