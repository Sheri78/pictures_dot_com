class CategoryViewModel {
  CategoryViewModel({
    required this.id,
    required this.category,
    required this.subCategories,
    required this.v,
  });

  final String? id;
  final String? category;
  final List<String> subCategories;
  final int? v;

  factory CategoryViewModel.fromJson(Map<String, dynamic> json){
    return CategoryViewModel(
      id: json["_id"],
      category: json["category"],
      subCategories: json["subCategories"] == null ? [] : List<String>.from(json["subCategories"]!.map((x) => x)),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "subCategories": subCategories.map((x) => x).toList(),
    "__v": v,
  };

}
