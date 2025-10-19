import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetMonthlyInvoices implements UseCase<int, MonthlyInvoicesParams> {
  final InvoiceRepository invoiceRepository;
  GetMonthlyInvoices(this.invoiceRepository);
  @override
  Future<Either<Failure, int>> call(MonthlyInvoicesParams params) async {
    return await invoiceRepository.getMonthlyInvoices(params.userId);
  }
}

class MonthlyInvoicesParams {
  final String userId;

  MonthlyInvoicesParams({required this.userId});
}
