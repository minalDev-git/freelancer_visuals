import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetTotalInvoicesByStatus
    implements UseCase<int, TotalInvoicesByStatusParams> {
  final InvoiceRepository invoiceRepository;
  GetTotalInvoicesByStatus(this.invoiceRepository);
  @override
  Future<Either<Failure, int>> call(TotalInvoicesByStatusParams params) async {
    return await invoiceRepository.getTotalInvoicesByStatus(
      params.userId,
      params.status,
    );
  }
}

class TotalInvoicesByStatusParams {
  final String userId;
  final IStatus status;

  TotalInvoicesByStatusParams({required this.userId, required this.status});
}
