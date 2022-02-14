class Product {
  int id, categoryId;
  String name;
  int buyPrice, sellPrice, conversionRate, lowerThreshold, status;
  String unitLabel;
  int? unpackedProductId;
  String? unpackedProductName, categoryName;

  Product({
    required this.id,
    required this.name,
    this.unpackedProductId,
    this.unpackedProductName,
    required this.categoryId,
    required this.categoryName,
    required this.buyPrice,
    required this.sellPrice,
    required this.conversionRate,
    required this.lowerThreshold,
    required this.unitLabel,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'],
      unpackedProductId: (json['unpackedProductId'] != null) ? json['unpackedProductId'] as int : null,
      unpackedProductName: (json['unpackedProductName'] != null) ? json['unpackedProductName'] : null,
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'],
      buyPrice: json['buyPrice'] as int,
      sellPrice: json['sellPrice'] as int,
      conversionRate: json['conversionRate'] as int,
      lowerThreshold: json['lowerThreshold'] as int,
      unitLabel: json['unitLabel'],
      status: json['status'] as int,
    );
  }
}
