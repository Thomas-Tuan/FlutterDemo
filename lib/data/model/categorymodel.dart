class Category {
  int? id;
  String? name;
  String? img;
  GenderCategories? genderCategories;

  Category({
    this.id,
    this.name,
    this.img,
    this.genderCategories,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    genderCategories =
        getGenderCategoryFromString(json['genderCategories'] as String);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['genderCategories'] = genderCategories.toString().split('.').last;
    return data;
  }
}

enum GenderCategories {
  males,
  females,
  kids,
}

GenderCategories getGenderCategoryFromString(String categoryString) {
  switch (categoryString) {
    case 'kids':
      return GenderCategories.kids;
    case 'females':
      return GenderCategories.females;
    default:
      return GenderCategories.males;
  }
}
