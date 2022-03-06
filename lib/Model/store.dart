class Store {
  int id;
  String name;
  String address;

  Store({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['address'],
      address: json['address'],
    );
  }
}
