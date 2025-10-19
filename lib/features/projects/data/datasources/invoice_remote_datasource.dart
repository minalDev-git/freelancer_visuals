import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/features/projects/data/models/invoice_model.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class InvoiceRemoteDataSource {
  Future<InvoiceModel> createInvoice(InvoiceModel invoice);
  Future<List<InvoiceModel>> getAllInvoices(String userId);
  Future<List<InvoiceModel>> getAllInvoicesOfClient(
    String userId,
    String clientId,
  );
  Future<InvoiceModel> updateInvoice(InvoiceModel invoice);
  Future<void> deleteInvoice(String invoiceId);
  Future<InvoiceModel> getInvoice(String invoiceId);
  Future<InvoiceModel> getInvoiceByStatus(String invoiceId, PStatus status);
  Future<List<InvoiceModel>> getAllInvoicesByStatus(
    String userId,
    String clientId,
    PStatus status,
  );
  Future<int> getTotalInvoicesByStatus(String userId, PStatus status);
  Future<int> getTotalInvoices(String userId);
  Future<int> getMonthlyInvoices(String userId);
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  final SupabaseClient supabaseClient;

  InvoiceRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<InvoiceModel> createInvoice(InvoiceModel invoice) async {
    try {
      final invoiceData = await supabaseClient
          .from('invoice')
          .insert(invoice.toJson())
          .select();
      return InvoiceModel.fromJson(invoiceData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteInvoice(String invoiceId) async {
    try {
      await supabaseClient.from('invoice').delete().eq('invoice_id', invoiceId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getAllInvoices(String userId) async {
    try {
      final invoices = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId);
      return invoices.map((invoice) => InvoiceModel.fromJson(invoice)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getAllInvoicesOfClient(
    String userId,
    String clientId,
  ) async {
    try {
      final invoices = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId)
          .eq('client_id', clientId);

      return (invoices as List<dynamic>)
          .map((invoice) => InvoiceModel.fromJson(invoice))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InvoiceModel> getInvoice(String invoiceId) async {
    try {
      final invoiceData = await supabaseClient
          .from('invoice')
          .select()
          .eq('invoice_id', invoiceId);
      return InvoiceModel.fromJson(invoiceData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InvoiceModel> getInvoiceByStatus(
    String invoiceId,
    PStatus status,
  ) async {
    try {
      final invoiceData = await supabaseClient
          .from('invoice')
          .select()
          .eq('invoice_id', invoiceId)
          .eq('status', status.toValue());
      return InvoiceModel.fromJson(invoiceData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InvoiceModel> updateInvoice(InvoiceModel invoice) async {
    try {
      final updatedInvoiceData = await supabaseClient
          .from('invoice')
          .update(invoice.toJson())
          .eq('invoice_id', invoice.clientId)
          .select();
      return InvoiceModel.fromJson(updatedInvoiceData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getMonthlyInvoices(String userId) async {
    try {
      final now = DateTime.now();
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0);

      final res = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId)
          .gte('created_at', firstDay.toIso8601String())
          .lte('created_at', lastDay.toIso8601String())
          .count();

      if (res.count > 0) {
        return res.count;
      }
      return 0;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalInvoicesByStatus(String userId, PStatus status) async {
    try {
      final res = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId)
          .eq('status', status.toValue())
          .count();

      if (res.count > 0) {
        return res.count;
      }
      return 0;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getAllInvoicesByStatus(
    String userId,
    String clientId,
    PStatus status,
  ) async {
    try {
      final invoices = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId)
          .eq('client_id', clientId)
          .eq('status', status.toValue());

      return (invoices as List<dynamic>)
          .map((invoice) => InvoiceModel.fromJson(invoice))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalInvoices(String userId) async {
    try {
      final res = await supabaseClient
          .from('invoice')
          .select('*')
          .eq('user_id', userId)
          .count();

      if (res.count > 0) {
        return res.count;
      }
      return 0;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
