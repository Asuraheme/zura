class PropertyModel {
  String? label;
  String? name;
  String? price;
  String? location;
  String? sqm;
  String? review;
  String? description;
  String? frontImage;
  String? ownerImage;
  List<String>? images;

  PropertyModel(
      {this.label,
      this.name,
      this.price,
      this.location,
      this.sqm,
      this.review,
      this.description,
      this.frontImage,
      this.ownerImage,
      this.images});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    price = json['price'];
    location = json['location'];
    sqm = json['sqm'];
    review = json['review'];
    description = json['description'];
    ownerImage = json['ownerImage'];
    frontImage = json['frontImage'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['price'] = price;
    data['frontImage'] = frontImage;
    data['ownerImage'] = ownerImage;
    data['review'] = review;
    data['sqm'] = sqm;
    data['description'] = description;
    data['label'] = label;
    data['images'] = images;
    return data;
  }
}
