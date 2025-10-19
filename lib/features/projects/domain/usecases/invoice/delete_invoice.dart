import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class DeleteInvoice implements UseCase<bool, DelInvoiceParams> {
  final InvoiceRepository invoiceRepository;
  DeleteInvoice(this.invoiceRepository);
  @override
  Future<Either<Failure, bool>> call(DelInvoiceParams params) async {
    return await invoiceRepository.deleteInvoice(params.invoiceId);
  }
}

class DelInvoiceParams {
  final String invoiceId;

  DelInvoiceParams({required this.invoiceId});
}
