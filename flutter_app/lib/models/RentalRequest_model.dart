class RentalRequest {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime requestDate;
  final String status;
  final double amount;
  final String paymentMethod;
  final String? transactionNumber;
  final String paymentStatus;
  final String deliveryMethod;
  final int userId;
  final int itemId;
  final String itemName; // ✅ إضافة اسم الغرض
  final int ownerId; // 🔹 إضافة معرف صاحب الغرض

  RentalRequest({
    required this.id,
    required this.ownerId,
    required this.startDate,
    this.endDate,
    required this.requestDate,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    this.transactionNumber,
    required this.paymentStatus,
    required this.deliveryMethod,
    required this.userId,
    required this.itemId,
    this.itemName = "", // ✅ تأكد أن القيمة الافتراضية ليست فارغة
  });

  // ✅ دالة لتحويل JSON إلى RentalRequest
  factory RentalRequest.fromJson(Map<String, dynamic> json) {
    return RentalRequest(
      id: json['id'] ?? 0, // ✅ تجنب null بالقيمة الافتراضية
      startDate: DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      requestDate: DateTime.parse(json['request_date']),
      status: json['status'] ?? "pending", // ✅ تجنب null
      amount: json['amount'] != null
          ? double.parse(json['amount'].toString())
          : 0.0, // ✅ تجنب null
      paymentMethod: json['payment_method'] ?? "unknown", // ✅ تجنب null
      transactionNumber: json['transaction_number']?.toString(),
      paymentStatus: json['payment_status'] ?? "pending", // ✅ تجنب null
      deliveryMethod: json['delivery_method'] ?? "self", // ✅ تجنب null
      userId: json['user_id'] ?? 0, // ✅ تجنب null
      itemId: json['item_id'] ?? 0, // ✅ تجنب null
      ownerId: json.containsKey('owner_id') && json['owner_id'] != null
          ? json['owner_id']
          : 0, // ✅ إذا لم يكن موجودًا، عين القيمة 0
      itemName: json['item_name'] ?? "", // ✅ تجنب null
    );
  }

  // ✅ دالة copyWith لتحديث الحقول
  RentalRequest copyWith({
    int? id,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? requestDate,
    String? status,
    double? amount,
    String? paymentMethod,
    String? transactionNumber,
    String? paymentStatus,
    String? deliveryMethod,
    int? userId,
    int? itemId,
    int? ownerId,
    String? itemName,
  }) {
    return RentalRequest(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      userId: userId ?? this.userId,
      itemId: itemId ?? this.itemId,
      ownerId: ownerId ?? this.ownerId, // 🔹 تحديث `ownerId`
      itemName: itemName ?? this.itemName, // ✅ دعم تحديث اسم الغرض
    );
  }
}
