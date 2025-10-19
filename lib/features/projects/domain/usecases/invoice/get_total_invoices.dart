import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetTotalInvoices implements UseCase<int, TotalInvoicesParams> {
  final InvoiceRepository invoiceRepository;
  GetTotalInvoices(this.invoiceRepository);
  @override
  Future<Either<Failure, int>> call(TotalInvoicesParams params) async {
    return await invoiceRepository.getTotalInvoices(params.userId);
  }
}

class TotalInvoicesParams {
  final String userId;

  TotalInvoicesParams({required this.userId});
}
