import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/features/projects/data/models/client_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ClientRemoteDataSource {
  Future<ClientModel> createClient(ClientModel client);
  Future<List<ClientModel>> getClient(String clientId);
  Future<List<ClientModel>> getAllClients(String userId);
  Future<ClientModel> updateClient(ClientModel client);
  Future<void> deleteClient(String clientId);
  Future<int> getTotalClients(String userId);
  Future<int> getMonthlyClients(String userId);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final SupabaseClient supabaseClient;

  ClientRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ClientModel> createClient(ClientModel client) async {
    try {
      final clientData = await supabaseClient
          .from('client')
          .insert(client.toJson())
          .select();
      return ClientModel.fromJson(clientData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ClientModel>> getAllClients(String userId) async {
    try {
      final clients = await supabaseClient
          .from('client')
          .select('*')
          .eq('user_id', userId);
      return clients.map((client) => ClientModel.fromJson(client)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ClientModel>> getClient(String clientName) async {
    try {
      final clients = await supabaseClient
          .from('client')
          .select('*')
          .ilike(
            'clientName',
            '$clientName%',
          ); // case-insensitive "starts with"

      return clients
          .map<ClientModel>((client) => ClientModel.fromJson(client))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ClientModel> updateClient(ClientModel client) async {
    try {
      final updatedClientData = await supabaseClient
          .from('client')
          .update(client.toJson())
          .eq('client_id', client.clientId)
          .select();
      return ClientModel.fromJson(updatedClientData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> deleteClient(String clientId) async {
    try {
      await supabaseClient.from('client').delete().eq('client_id', clientId);
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalClients(String userId) async {
    try {
      final res = await supabaseClient
          .from('client')
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

  @override
  Future<int> getMonthlyClients(String userId) async {
    try {
      final now = DateTime.now();
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0);

      final res = await supabaseClient
          .from('client')
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
}
