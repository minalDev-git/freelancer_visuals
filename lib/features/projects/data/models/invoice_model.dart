import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    required super.invoiceId,
    required super.userId,
    required super.clientId,
    required super.projectId,
    required super.issueDate,
    required super.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'invoice_id': invoiceId,
      'user_id': userId,
      'client_id': clientId,
      'project_id': projectId,
      //'issueDate': issueDate.toIso8601String(),
      'status': status.toValue(),
    };
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> map) {
    return InvoiceModel(
      invoiceId: map['invoice_id'] as String,
      userId: map['user_id'] as String,
      clientId: map['client_id'] as String,
      projectId: map['project_id'] as String,
      issueDate: map['issue_date'] == null
          ? DateTime.now()
          : DateTime.parse(map['issue_date']),
      status: IStatusX.fromValue(map['status'] as String),
    );
  }

  InvoiceModel copyWith({
    String? invoiceId,
    String? userId,
    String? clientId,
    String? projectId,
    DateTime? issueDate,
    IStatus? status,
  }) {
    return InvoiceModel(
      invoiceId: invoiceId ?? this.invoiceId,
      userId: userId ?? this.userId,
      clientId: clientId ?? this.clientId,
      projectId: projectId ?? this.projectId,
      issueDate: issueDate ?? this.issueDate,
      status: status ?? this.status,
    );
  }
}
