part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceEvent {}

final class InvoiceUpload extends InvoiceEvent {
  final String userId;
  final String clientId;
  final String projectId;
  final IStatus status;
  final DateTime issueDate;

  InvoiceUpload({
    required this.userId,
    required this.clientId,
    required this.projectId,
    required this.status,
    required this.issueDate,
  });
}

final class AllInvoicesList extends InvoiceEvent {
  final String userId;

  AllInvoicesList({required this.userId});
}

final class AllInvoicesByStatusList extends InvoiceEvent {
  final String userId;
  final String clientId;
  final PStatus status;

  AllInvoicesByStatusList({
    required this.userId,
    required this.clientId,
    required this.status,
  });
}

final class InvoiceByStatus extends InvoiceEvent {
  final String invoiceId;
  final PStatus status;

  InvoiceByStatus({required this.invoiceId, required this.status});
}

final class InvoiceDelete extends InvoiceEvent {
  final String invoiceId;

  InvoiceDelete({required this.invoiceId});
}

final class InvoiceSearch extends InvoiceEvent {
  final String invoiceId;
  final PStatus status;

  InvoiceSearch({required this.status, required this.invoiceId});
}

final class InvoiceSearchByStatus extends InvoiceEvent {
  final String invoiceId;
  final PStatus status;

  InvoiceSearchByStatus({required this.invoiceId, required this.status});
}

final class AllInvoiceSearchByStatus extends InvoiceEvent {
  final String userId;
  final String clientId;
  final PStatus status;

  AllInvoiceSearchByStatus({
    required this.userId,
    required this.clientId,
    required this.status,
  });
}

final class InvoiceUpdate extends InvoiceEvent {
  final String invoiceId;
  final String clientId;
  final String projectId;
  final String userId;
  final IStatus status;

  InvoiceUpdate({
    required this.userId,
    required this.invoiceId,
    required this.projectId,
    required this.clientId,
    required this.status,
  });
}

final class CountAllInvoices extends InvoiceEvent {
  final String userId;

  CountAllInvoices({required this.userId});
}

final class CountMonthlyInvoices extends InvoiceEvent {
  final String userId;

  CountMonthlyInvoices({required this.userId});
}
