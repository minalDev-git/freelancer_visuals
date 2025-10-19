import 'package:fpdart/fpdart.dart';
import 'package:freelancer_visuals/core/error/faliures.dart';
import 'package:freelancer_visuals/core/usecase/usecase.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/repositories/invoice_repository.dart';

class GetAllInvoices implements UseCase<List<Invoice>, AllInvoiceParams> {
  final InvoiceRepository invoiceRepository;
  GetAllInvoices(this.invoiceRepository);
  @override
  Future<Either<Failure, List<Invoice>>> call(AllInvoiceParams params) async {
    return await invoiceRepository.getAllInvoices(params.userId);
  }
}

class AllInvoiceParams {
  final String userId;
  AllInvoiceParams({required this.userId});
}
