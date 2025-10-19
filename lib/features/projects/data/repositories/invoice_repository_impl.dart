import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/features/projects/data/datasources/invoice_remote_datasource.dart';
import 'package:freelancer_visuals/features/projects/data/models/invoice_model.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';
import 'package:uuid/uuid.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDataSource invoiceRemoteDataSource;
  InvoiceRepositoryImpl(this.invoiceRemoteDataSource);
  @override
  Future<Either<Failure, Invoice>> createInvoice({
    required String clientId,
    required String userId,
    required String projectId,
    required IStatus status,
  }) async {
    try {
      final InvoiceModel invoiceModel = InvoiceModel(
        invoiceId: const Uuid().v1(),
        clientId: clientId,
        userId: userId,
        projectId: projectId,
        issueDate: DateTime.now(),
        status: status,
      );
      final uploadedInvoice = await invoiceRemoteDataSource.createInvoice(
        invoiceModel,
      );
      return right(uploadedInvoice);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteInvoice(String invoiceId) async {
    try {
      await invoiceRemoteDataSource.deleteInvoice(invoiceId);
      return right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getAllInvoices(String userId) async {
    try {
      final invoices = await invoiceRemoteDataSource.getAllInvoices(userId);
      return right(invoices);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getAllInvoicesByStatus(
    String userId,
    String clientId,
    PStatus status,
  ) async {
    try {
      final invoices = await invoiceRemoteDataSource.getAllInvoicesByStatus(
        userId,
        clientId,
        status,
      );
      return right(invoices);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getAllInvoicesOfClient(
    String userId,
    String clientId,
  ) async {
    try {
      final invoices = await invoiceRemoteDataSource.getAllInvoicesOfClient(
        userId,
        clientId,
      );
      return right(invoices);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Invoice>> getInvoice(String invoiceId) async {
    try {
      final invoice = await invoiceRemoteDataSource.getInvoice(invoiceId);
      return right(invoice);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Invoice>> getInvoiceByStatus(
    String invoiceId,
    PStatus status,
  ) async {
    try {
      final invoice = await invoiceRemoteDataSource.getInvoiceByStatus(
        invoiceId,
        status,
      );
      return right(invoice);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getMonthlyInvoices(String userId) async {
    try {
      final count = await invoiceRemoteDataSource.getMonthlyInvoices(userId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalInvoices(String userId) async {
    try {
      final count = await invoiceRemoteDataSource.getTotalInvoices(userId);
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalInvoicesByStatus(
    String userId,
    PStatus status,
  ) async {
    try {
      final count = await invoiceRemoteDataSource.getTotalInvoicesByStatus(
        userId,
        status,
      );
      return right(count);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Invoice>> updateInvoice({
    required String invoiceId,
    required String clientId,
    required String projectId,
    required String userId,
    required IStatus status,
  }) async {
    try {
      final InvoiceModel invoiceModel = InvoiceModel(
        invoiceId: invoiceId,
        clientId: clientId,
        userId: userId,
        projectId: projectId,
        issueDate: DateTime.now(),
        status: status,
      );
      final uploadedInvoice = await invoiceRemoteDataSource.updateInvoice(
        invoiceModel,
      );
      return right(uploadedInvoice);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
