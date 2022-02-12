class Brand {
  int id;
  String name;
  int status;

  Brand({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
