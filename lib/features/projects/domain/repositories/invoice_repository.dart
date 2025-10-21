import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';

abstract interface class InvoiceRepository {
  Future<Either<Failure, Invoice>> createInvoice({
    required String clientId,
    required String projectId,
    required String userId,
    required IStatus status,
  });

  Future<Either<Failure, List<Invoice>>> getAllInvoices(String userId);
  Future<Either<Failure, List<Invoice>>> getAllInvoicesOfClient(
    String userId,
    String clientId,
  );
  Future<Either<Failure, Invoice>> updateInvoice({
    required String invoiceId,
    required String clientId,
    required String projectId,
    required String userId,
    required IStatus status,
  });
  Future<Either<Failure, bool>> deleteInvoice(String invoiceId);
  Future<Either<Failure, Invoice>> getInvoice(String invoiceId);
  Future<Either<Failure, Invoice>> getInvoiceByStatus(
    String invoiceId,
    IStatus status,
  );
  Future<Either<Failure, List<Invoice>>> getAllInvoicesByStatus(
    String userId,
    String clientId,
    IStatus status,
  );
  Future<Either<Failure, int>> getTotalInvoicesByStatus(
    String userId,
    IStatus status,
  );
  Future<Either<Failure, int>> getTotalInvoices(String userId);
  Future<Either<Failure, int>> getMonthlyInvoices(String userId);
}
