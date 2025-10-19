import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class UpdateInvoice implements UseCase<Invoice, UpdateInvoiceParams> {
  final InvoiceRepository invoiceRepository;

  UpdateInvoice(this.invoiceRepository);

  @override
  Future<Either<Failure, Invoice>> call(UpdateInvoiceParams params) async {
    return await invoiceRepository.updateInvoice(
      invoiceId: params.invoiceId,
      clientId: params.clientId,
      userId: params.userId,
      projectId: params.projectId,
      status: params.status,
    );
  }
}

class UpdateInvoiceParams {
  final String invoiceId;
  final String userId;
  final String clientId;
  final String projectId;
  final IStatus status;
  final DateTime issueDate;

  UpdateInvoiceParams({
    required this.invoiceId,
    required this.userId,
    required this.issueDate,
    required this.clientId,
    required this.projectId,
    required this.status,
  });
}
