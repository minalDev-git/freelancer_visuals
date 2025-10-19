part of 'client_bloc.dart';

@immutable
sealed class ClientState {}

final class ClientInitial extends ClientState {}

final class ClientLoading extends ClientState {}

final class ClientFailure extends ClientState {
  final String error;
  ClientFailure(this.error);
}

final class ClientDisplaySuccess extends ClientState {
  final List<Client> clients;
  ClientDisplaySuccess(this.clients);
}

final class ClientUploadSuccess extends ClientState {}
