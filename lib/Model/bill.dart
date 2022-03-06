class Bill {
  int id, cashierId, storeId, totalPrice;
  String cashierName;
  DateTime dateCreated;
  List<BillDetail> details;

  Bill({
    required this.id,
    required this.storeId,
    required this.cashierId,
    required this.cashierName,
    required this.totalPrice,
    required this.dateCreated,
    required this.details,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      storeId: json['storeId'],
      cashierId: json['cashierId'],
      cashierName: json['cashierName'],
      totalPrice: json['totalPrice'],
      dateCreated: DateTime.parse(json['dateCreated']),
      details: (json['billDetails'] as List)
          .map((detail) => BillDetail.fromJson(detail))
          .toList(),
    );
  }
}

class BillDetail {
  int buyPrice, sellPrice, quantity, productId, stockId;
  String productName;

  BillDetail({
    required this.buyPrice,
    required this.sellPrice,
    required this.quantity,
    required this.productId,
    required this.stockId,
    required this.productName,
  });

  factory BillDetail.fromJson(Map<String, dynamic> json) {
    return BillDetail(
      buyPrice: json['buyPrice'] as int,
      sellPrice: json['sellPrice'] as int,
      quantity: json['quantity'] as int,
      productId: json['productId'] as int,
      stockId: json['stockId'] as int,
      productName: json['productName'] as String,
    );
  }
}
