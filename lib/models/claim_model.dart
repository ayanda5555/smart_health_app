class ClaimModel {
  final String id;
  final String userId;
  final String title;
  final String category;
  final String description;
  final double amount;
  final String date;
  final String status;

  ClaimModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    this.status = 'Pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
      'status': status,
    };
  }

  factory ClaimModel.fromJson(Map<String, dynamic> json) {
    return ClaimModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      date: json['date'] ?? '',
      status: json['status'] ?? 'Pending',
    );
  }
}