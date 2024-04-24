// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  int? id;
  String? name;
  String? des;
  String? img;

  Category({
    this.id,
    this.name,
    this.des,
    this.img,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    des = json['description'];
    img = json['imageURL'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = des;
    data['imageURL'] = img;
    return data;
  }
}

enum GenderCategories {
  males,
  females,
  kids,
}

extension GenderCategoriesExtension on GenderCategories {
  String get displayName {
    switch (this) {
      case GenderCategories.males:
        return 'nam';
      case GenderCategories.females:
        return 'nữ';
      case GenderCategories.kids:
        return 'trẻ em';
      default:
        return 'nam';
    }
  }
}
