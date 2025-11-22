class Category {
  final String id;
  final String name;
  final String? iconName;
  final String? imageUrl;

  Category({
    required this.id,
    required this.name,
    this.iconName,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      iconName: json['iconName'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'imageUrl': imageUrl,
    };
  }
}
