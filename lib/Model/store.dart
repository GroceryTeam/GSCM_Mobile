class Store {
  int id;
  String name;
  String address;
  int status;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      status: json['approvedStatus'],
    );
  }
}
