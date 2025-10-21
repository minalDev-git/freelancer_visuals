import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';

import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetAllInvoicesByStatus
    implements UseCase<List<Invoice>, AllInvoiceStatusParams> {
  final InvoiceRepository invoiceRepository;
  GetAllInvoicesByStatus(this.invoiceRepository);
  @override
  Future<Either<Failure, List<Invoice>>> call(
    AllInvoiceStatusParams params,
  ) async {
    return await invoiceRepository.getAllInvoicesByStatus(
      params.userId,
      params.clientId,
      params.status,
    );
  }
}

class AllInvoiceStatusParams {
  final String userId;
  final String clientId;
  final IStatus status;
  AllInvoiceStatusParams({
    required this.clientId,
    required this.status,
    required this.userId,
  });
}
