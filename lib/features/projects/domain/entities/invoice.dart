enum IStatus { unpaid, paid, late }

extension IStatusX on IStatus {
  /// Convert enum to string
  String toValue() {
    switch (this) {
      case IStatus.unpaid:
        return 'unpaid';
      case IStatus.paid:
        return 'paid';
      case IStatus.late:
        return 'late';
    }
  }

  /// Convert string to enum
  static IStatus fromValue(String value) {
    switch (value) {
      case 'unpaid':
        return IStatus.unpaid;
      case 'paid':
        return IStatus.paid;
      case 'late':
      default:
        return IStatus.late;
    }
  }
}

class Invoice {
  final String invoiceId;
  final String userId;
  final String clientId;
  final String projectId;
  final DateTime issueDate;
  final IStatus status;

  Invoice({
    required this.invoiceId,
    required this.userId,
    required this.clientId,
    required this.projectId,
    required this.issueDate,
    required this.status,
  });
}
