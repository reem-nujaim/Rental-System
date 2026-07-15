class Category {
  final int id;
  final String enName;
  final String arName;
  final String enDescription;
  final String arDescription;

  Category({
    required this.id,
    required this.enName,
    required this.arName,
    required this.enDescription,
    required this.arDescription,
  });

  // إنشاء Factory لتحويل JSON إلى كائن
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      enName: json['en_name'],
      arName: json['ar_name'],
      enDescription: json['en_descrieption'],
      arDescription: json['ar_description'],
    );
  }
}
