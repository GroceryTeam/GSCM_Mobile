class Receipt {
  int id, storeId, totalCost;
  DateTime dateCreated;
  List<ReceiptDetail> details;

  Receipt({
    required this.id,
    required this.storeId,
    required this.totalCost,
    required this.dateCreated,
    required this.details,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'],
      storeId: json['storeId'],
      totalCost: json['totalCost'],
      dateCreated: DateTime.parse(json['dateCreated']),
      details: (json['receiptDetails'] as List)
          .map((detail) => ReceiptDetail.fromJson(detail))
          .toList(),
    );
  }
}

class ReceiptDetail {
  int id, quantity, productId, buyPrice;
  String productName;

  ReceiptDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.buyPrice,
  });

  factory ReceiptDetail.fromJson(Map<String, dynamic> json) {
    return ReceiptDetail(
      id: json['receiptId'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      buyPrice: json['buyPrice'],
    );
  }
}
