import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetInvoice implements UseCase<Invoice, InvoiceParams> {
  final InvoiceRepository invoiceRepository;
  GetInvoice(this.invoiceRepository);
  @override
  Future<Either<Failure, Invoice>> call(InvoiceParams params) async {
    return await invoiceRepository.getInvoice(params.invoiceId);
  }
}

class InvoiceParams {
  final String invoiceId;

  InvoiceParams({required this.invoiceId});
}
