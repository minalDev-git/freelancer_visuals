import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class UploadInvoice implements UseCase<Invoice, UploadInvoiceParams> {
  final InvoiceRepository invoiceRepository;

  UploadInvoice(this.invoiceRepository);

  @override
  Future<Either<Failure, Invoice>> call(UploadInvoiceParams params) async {
    return await invoiceRepository.createInvoice(
      clientId: params.clientId,
      userId: params.userId,
      projectId: params.projectId,
      status: params.status,
    );
  }
}

class UploadInvoiceParams {
  final String userId;
  final String clientId;
  final String projectId;
  final IStatus status;
  final DateTime issueDate;

  UploadInvoiceParams({
    required this.userId,
    required this.issueDate,
    required this.clientId,
    required this.projectId,
    required this.status,
  });
}
