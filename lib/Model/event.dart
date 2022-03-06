class Event {
  int id, status, productCount;
  String name;
  List<EventDetail> details;

  Event({
    required this.id,
    required this.name,
    required this.productCount,
    required this.status,
    required this.details,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['eventName'],
      productCount: json['productCount'],
      status: json['status'],
      details: (json['eventDetails'] as List)
          .map((detail) => EventDetail.fromJson(detail))
          .toList(),
    );
  }
}

class EventDetail {
  int eventId, productId;
  String productName, sku;
  int newPrice, originalPrice;

  EventDetail({
    required this.eventId,
    required this.productId,
    required this.productName,
    required this.newPrice,
    required this.originalPrice,
    required this.sku,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      eventId: json['eventId'],
      productId: json['productId'],
      productName: json['productName'],
      newPrice: json['newPrice'],
      originalPrice: json['originalPrice'],
      sku: json['sku'],
    );
  }
}
