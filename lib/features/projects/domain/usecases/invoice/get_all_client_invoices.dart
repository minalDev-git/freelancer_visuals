import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetAllClientInvoices
    implements UseCase<List<Invoice>, AllClientInvoiceParams> {
  final InvoiceRepository invoiceRepository;
  GetAllClientInvoices(this.invoiceRepository);
  @override
  Future<Either<Failure, List<Invoice>>> call(
    AllClientInvoiceParams params,
  ) async {
    return await invoiceRepository.getAllInvoicesOfClient(
      params.userId,
      params.clientId,
    );
  }
}

class AllClientInvoiceParams {
  final String userId;
  final String clientId;
  AllClientInvoiceParams({required this.clientId, required this.userId});
}
