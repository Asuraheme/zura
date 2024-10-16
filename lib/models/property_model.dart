class PropertyModel {
  String? name;
  String? location;
  int? price;
  String? frontImage;

  PropertyModel({this.name, this.location, this.price,this.frontImage});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    price = json['price'];
    frontImage = json['frontImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['price'] = this.price;
    data['frontImage'] = this.frontImage;
    return data;
  }
}
