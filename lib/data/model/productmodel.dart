// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;

  Product({this.id, this.name, this.price, this.img, this.des, this.catId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['imageURL'];
    des = json['description'];
    catId = json['catId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['imageURL'] = img;
    data['description'] = des;
    data['catId'] = catId;
    return data;
  }
}
