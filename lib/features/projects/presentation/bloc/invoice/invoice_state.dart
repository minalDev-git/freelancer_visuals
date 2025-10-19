part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceLoading extends InvoiceState {}

final class InvoiceFailure extends InvoiceState {
  final String error;

  InvoiceFailure(this.error);
}

final class InvoiceDisplaySuccess extends InvoiceState {
  final List<Invoice> clients;
  InvoiceDisplaySuccess(this.clients);
}

final class InvoiceUploadSuccess extends InvoiceState {}
