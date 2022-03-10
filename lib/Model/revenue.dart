class DailyRevenue {
  DateTime date;
  int revenue;

  DailyRevenue({required this.date, required this.revenue});

  factory DailyRevenue.fromJson(Map<String, dynamic> json) {
    return DailyRevenue(
      date: DateTime.parse(json['date']),
      revenue: json['revenue'],
    );
  }
}

class MonthlyRevenue {
  DateTime date;
  int revenue;

  MonthlyRevenue({required this.date, required this.revenue});

  factory MonthlyRevenue.fromJson(Map<String, dynamic> json) {
    return MonthlyRevenue(
      date: DateTime.parse(json['month']),
      revenue: json['revenue'],
    );
  }
}
