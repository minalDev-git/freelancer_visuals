import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/delete_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_all_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_monthly_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/get_total_clients.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/update_client.dart';
import 'package:freelancer_visuals/features/projects/domain/usecases/client/upload_client.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final UploadClient _uploadClient;
  final UpdateClients _updateClients;
  final GetAllClients _getAllClients;
  final GetClients _getClient;
  final GetTotalClients _getTotalClients;
  final GetMonthlyClients _getMonthlyClients;
  final DeleteClient _deleteClient;

  ClientBloc({
    required UploadClient uploadClient,
    required GetAllClients getAllClients,
    required DeleteClient deleteClient,
    required UpdateClients updateClients,
    required GetClients getClient,
    required GetTotalClients getTotalClients,
    required GetMonthlyClients getMonthlyClients,
  }) : _uploadClient = uploadClient,
       _getAllClients = getAllClients,
       _deleteClient = deleteClient,
       _getClient = getClient,
       _getMonthlyClients = getMonthlyClients,
       _getTotalClients = getTotalClients,
       _updateClients = updateClients,
       super(ClientInitial()) {
    on<ClientEvent>((event, emit) {
      emit(ClientLoading());
    });
    on<ClientUpload>(_onClientUpload);
    on<ClientDelete>(_onDeleteClient);
    on<ClientUpdate>(_onUpdateClient);
    on<CountAllClients>(_onCountAllClients);
    on<CountMonthlyClients>(_onCountMonthlyClients);
    on<AllClientsList>(_onAllClientsList);
    on<ClientSearch>(_onClientSearch);
  }

  void _onClientUpload(ClientUpload event, Emitter<ClientState> emit) async {
    final res = await _uploadClient(
      UploadClientParams(
        userId: event.userId,
        clientName: event.clientName,
        companyName: event.companyName,
        clientEmail: event.clientEmail,
      ),
    );
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientUploadSuccess()),
    );
  }

  void _onUpdateClient(ClientUpdate event, Emitter<ClientState> emit) async {
    final res = await _updateClients(
      UpdateClientParams(
        clientId: event.clientId,
        userId: event.userId,
        clientName: event.clientName,
        companyName: event.companyName,
        clientEmail: event.clientEmail,
      ),
    );
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientUploadSuccess()),
    );
  }

  void _onDeleteClient(ClientDelete event, Emitter<ClientState> emit) async {
    final res = await _deleteClient(DelClientParams(clientId: event.clientId));
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientUploadSuccess()),
    );
  }

  void _onClientSearch(ClientSearch event, Emitter<ClientState> emit) async {
    final res = await _getClient(ClientParams(clientName: event.clientName));
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDisplaySuccess(r)),
    );
  }

  void _onCountAllClients(
    CountAllClients event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _getTotalClients(TotalClientParams(userId: event.userId));
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientUploadSuccess()),
    );
  }

  void _onCountMonthlyClients(
    CountMonthlyClients event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _getMonthlyClients(
      MonthlyClientParams(userId: event.userId),
    );
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientUploadSuccess()),
    );
  }

  void _onAllClientsList(
    AllClientsList event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _getAllClients(AllClientParams(userId: event.userId));
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDisplaySuccess(r)),
    );
  }
}
