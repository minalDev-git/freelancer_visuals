enum PStatus { complete, cancelled, pending }

extension PStatusX on PStatus {
  /// Convert enum to string
  String toValue() {
    switch (this) {
      case PStatus.complete:
        return 'complete';
      case PStatus.cancelled:
        return 'cancelled';
      case PStatus.pending:
        return 'pending';
    }
  }

  /// Convert string to enum
  static PStatus fromValue(String value) {
    switch (value) {
      case 'complete':
        return PStatus.complete;
      case 'cancelled':
        return PStatus.cancelled;
      case 'pending':
      default:
        return PStatus.pending;
    }
  }
}

class Project {
  final String projectId;
  final String clientId;
  final String userId;
  final String projectName;
  final String category;
  final DateTime startDate;
  final DateTime deadline;
  final PStatus status;
  final double ammount;

  Project({
    required this.projectId,
    required this.clientId,
    required this.userId,
    required this.projectName,
    required this.category,
    required this.startDate,
    required this.deadline,
    required this.status,
    required this.ammount,
  });
}
