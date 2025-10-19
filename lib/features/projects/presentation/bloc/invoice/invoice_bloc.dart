import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/delete_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_all_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_all_invoices_by_satus.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_invoice_by_status.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_monthly_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/get_total_invoices.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/update_invoice.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/invoice/upload_invoice.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final UploadInvoice _uploadInvoice;
  final UpdateInvoice _updateInvoice;
  final GetAllInvoices _getAllInvoices;
  final GetInvoiceByStatus _getInvoice;
  final GetTotalInvoices _getTotalInvoices;
  final GetMonthlyInvoices _getMonthlyInvoices;
  final DeleteInvoice _deleteInvoice;
  final GetInvoiceByStatus _invoiceSearchByStatus;
  final GetAllInvoicesByStatus _allInvoiceSearchByStatus;

  InvoiceBloc({
    required UploadInvoice uploadInvoice,
    required UpdateInvoice updateInvoice,
    required GetAllInvoices getAllInvoices,
    required GetInvoiceByStatus getInvoice,
    required GetTotalInvoices getTotalInvoices,
    required GetMonthlyInvoices getMonthlyInvoices,
    required DeleteInvoice deleteInvoice,
    required GetInvoiceByStatus invoiceSearchByStatus,
    required GetAllInvoicesByStatus allInvoiceSearchByStatus,
  }) : _uploadInvoice = uploadInvoice,
       _updateInvoice = updateInvoice,
       _invoiceSearchByStatus = invoiceSearchByStatus,
       _allInvoiceSearchByStatus = allInvoiceSearchByStatus,
       _deleteInvoice = deleteInvoice,
       _getAllInvoices = getAllInvoices,
       _getInvoice = getInvoice,
       _getMonthlyInvoices = getMonthlyInvoices,
       _getTotalInvoices = getTotalInvoices,
       super(InvoiceInitial()) {
    on<InvoiceEvent>((event, emit) {
      emit(InvoiceLoading());
    });
    on<InvoiceUpload>(_onUploadInvoice);
    on<InvoiceUpdate>(_onUpdateInvoice);
    on<InvoiceDelete>(_onDeleteInvoice);
    on<InvoiceSearch>(_onInvoiceSearch);
    on<CountAllInvoices>(_onCountAllInvoices);
    on<CountMonthlyInvoices>(_onCountMonthlyInvoices);
    on<AllInvoicesList>(_onAllInvoicesList);
    on<InvoiceSearchByStatus>(_onInvoiceSearchByStatus);
    on<AllInvoiceSearchByStatus>(_onAllInvoicesByStatus);
  }

  void _onUploadInvoice(InvoiceUpload event, Emitter<InvoiceState> emit) async {
    final res = await _uploadInvoice(
      UploadInvoiceParams(
        clientId: event.clientId,
        userId: event.userId,
        projectId: event.projectId,
        status: event.status,
        issueDate: event.issueDate,
      ),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onUpdateInvoice(InvoiceUpdate event, Emitter<InvoiceState> emit) async {
    final res = await _updateInvoice(
      UpdateInvoiceParams(
        invoiceId: event.invoiceId,
        clientId: event.clientId,
        userId: event.userId,
        projectId: event.projectId,
        status: event.status,
        issueDate: DateTime.now(),
      ),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onDeleteInvoice(InvoiceDelete event, Emitter<InvoiceState> emit) async {
    final res = await _deleteInvoice(
      DelInvoiceParams(invoiceId: event.invoiceId),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onInvoiceSearch(InvoiceSearch event, Emitter<InvoiceState> emit) async {
    final res = await _getInvoice(
      InvoiceStatusParams(invoiceId: event.invoiceId, status: event.status),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onInvoiceSearchByStatus(
    InvoiceSearchByStatus event,
    Emitter<InvoiceState> emit,
  ) async {
    final res = await _invoiceSearchByStatus(
      InvoiceStatusParams(invoiceId: event.invoiceId, status: event.status),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onCountAllInvoices(
    CountAllInvoices event,
    Emitter<InvoiceState> emit,
  ) async {
    final res = await _getTotalInvoices(
      TotalInvoicesParams(userId: event.userId),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onCountMonthlyInvoices(
    CountMonthlyInvoices event,
    Emitter<InvoiceState> emit,
  ) async {
    final res = await _getMonthlyInvoices(
      MonthlyInvoicesParams(userId: event.userId),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceUploadSuccess()),
    );
  }

  void _onAllInvoicesList(
    AllInvoicesList event,
    Emitter<InvoiceState> emit,
  ) async {
    final res = await _getAllInvoices(AllInvoiceParams(userId: event.userId));
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceDisplaySuccess(r)),
    );
  }

  void _onAllInvoicesByStatus(
    AllInvoiceSearchByStatus event,
    Emitter<InvoiceState> emit,
  ) async {
    final res = await _allInvoiceSearchByStatus(
      AllInvoiceStatusParams(
        clientId: event.clientId,
        status: event.status,
        userId: event.userId,
      ),
    );
    res.fold(
      (l) => emit(InvoiceFailure(l.message)),
      (r) => emit(InvoiceDisplaySuccess(r)),
    );
  }
}
