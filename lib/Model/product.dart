class Product {
  int id, categoryId;
  String name, categoryName, unitLabel;
  int sellPrice, conversionRate, lowerThreshold, status;
  int? unpackedProductId;
  String? unpackedProductName;

  Product({
    required this.id,
    required this.name,
    this.unpackedProductId,
    this.unpackedProductName,
    required this.categoryId,
    required this.categoryName,
    required this.sellPrice,
    required this.conversionRate,
    required this.lowerThreshold,
    required this.unitLabel,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      unpackedProductId: (json['unpackedProductId'] != null) ? json['unpackedProductId'] as int : null,
      unpackedProductName: (json['unpackedProductName'] != null) ? json['unpackedProductName'] : null,
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      sellPrice: json['sellPrice'] as int,
      conversionRate: json['conversionRate'] as int,
      lowerThreshold: json['lowerThreshold'] as int,
      unitLabel: json['unitLabel'],
      status: json['status'] as int,
    );
  }
}
