class UserReport {
  final int itemsCount;
  final int rentalRequestsReceivedCount;
  final int approvedRequestsCount;
  final int rejectedRequestsCount;
  final int pendingRequestsCount;
  final int approvedRentalRequestsCount;
  final int rejectedRentalRequestsCount;
  final int pendingRentalRequestsCount;
  final int lateFeesCount;
  final double totalLateFeesAmount;

  UserReport({
    required this.itemsCount,
    required this.rentalRequestsReceivedCount,
    required this.approvedRequestsCount,
    required this.rejectedRequestsCount,
    required this.pendingRequestsCount,
    required this.approvedRentalRequestsCount,
    required this.rejectedRentalRequestsCount,
    required this.pendingRentalRequestsCount,
    required this.lateFeesCount,
    required this.totalLateFeesAmount,
  });

  factory UserReport.fromJson(Map<String, dynamic> json) {
    return UserReport(
      itemsCount: json['items_count'] is int
          ? json['items_count']
          : int.tryParse(json['items_count'].toString()) ?? 0,
      rentalRequestsReceivedCount: json['rental_requests_received_count'] is int
          ? json['rental_requests_received_count']
          : int.tryParse(json['rental_requests_received_count'].toString()) ??
              0,
      approvedRequestsCount: json['approved_requests_count'] is int
          ? json['approved_requests_count']
          : int.tryParse(json['approved_requests_count'].toString()) ?? 0,
      rejectedRequestsCount: json['rejected_requests_count'] is int
          ? json['rejected_requests_count']
          : int.tryParse(json['rejected_requests_count'].toString()) ?? 0,
      pendingRequestsCount: json['pending_requests_count'] is int
          ? json['pending_requests_count']
          : int.tryParse(json['pending_requests_count'].toString()) ?? 0,
      approvedRentalRequestsCount: json['approved_rental_requests_count'] is int
          ? json['approved_rental_requests_count']
          : int.tryParse(json['approved_rental_requests_count'].toString()) ??
              0,
      rejectedRentalRequestsCount: json['rejected_rental_requests_count'] is int
          ? json['rejected_rental_requests_count']
          : int.tryParse(json['rejected_rental_requests_count'].toString()) ??
              0,
      pendingRentalRequestsCount: json['pending_rental_requests_count'] is int
          ? json['pending_rental_requests_count']
          : int.tryParse(json['pending_rental_requests_count'].toString()) ?? 0,
      lateFeesCount: json['late_fees_count'] is int
          ? json['late_fees_count']
          : int.tryParse(json['late_fees_count'].toString()) ?? 0,
      totalLateFeesAmount: json['total_late_fees_amount'] is num
          ? (json['total_late_fees_amount'] as num).toDouble()
          : double.tryParse(json['total_late_fees_amount'].toString()) ?? 0.0,
    );
  }
}
