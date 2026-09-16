class GoldPointLog {
  final String id;
  final String userId;
  final int amount;
  final String reason;
  final String? referenceId;
  final DateTime createdAt;

  GoldPointLog({
    required this.id,
    required this.userId,
    required this.amount,
    required this.reason,
    this.referenceId,
    required this.createdAt,
  });

  factory GoldPointLog.fromJson(Map<String, dynamic> json) {
    return GoldPointLog(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: json['amount'] as int,
      reason: json['reason'] as String,
      referenceId: json['reference_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
    );
  }

  /// User-friendly label for each earning reason
  String get displayReason {
    switch (reason) {
      case 'daily_login':
        return 'Daily Login Bonus';
      case 'referral':
        return 'Member Referral';
      case 'order_service':
        return 'Service Order Reward';
      default:
        return 'Bonus Points';
    }
  }

  /// Icon corresponding to each earning reason
  String get displayIcon {
    switch (reason) {
      case 'daily_login':
        return '📅';
      case 'referral':
        return '👥';
      case 'order_service':
        return '🛍️';
      default:
        return '⭐';
    }
  }
}