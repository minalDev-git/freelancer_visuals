import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetInvoiceByStatus implements UseCase<Invoice, InvoiceStatusParams> {
  final InvoiceRepository invoiceRepository;
  GetInvoiceByStatus(this.invoiceRepository);
  @override
  Future<Either<Failure, Invoice>> call(InvoiceStatusParams params) async {
    return await invoiceRepository.getInvoiceByStatus(
      params.invoiceId,
      params.status,
    );
  }
}

class InvoiceStatusParams {
  final String invoiceId;
  final IStatus status;

  InvoiceStatusParams({required this.invoiceId, required this.status});
}
