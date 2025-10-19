part of 'client_bloc.dart';

@immutable
sealed class ClientEvent {}

final class ClientUpload extends ClientEvent {
  final String userId;
  final String clientName;
  final String companyName;
  final String clientEmail;
  final DateTime createdAt;

  ClientUpload({
    required this.userId,
    required this.clientName,
    required this.companyName,
    required this.clientEmail,
    required this.createdAt,
  });
}

final class AllClientsList extends ClientEvent {
  final String userId;

  AllClientsList({required this.userId});
}

final class ClientDelete extends ClientEvent {
  final String clientId;

  ClientDelete({required this.clientId});
}

final class ClientSearch extends ClientEvent {
  final String clientName;

  ClientSearch({required this.clientName});
}

final class ClientUpdate extends ClientEvent {
  final String clientId;
  final String userId;
  final String clientName;
  final String companyName;
  final String clientEmail;
  final DateTime createdAt;

  ClientUpdate({
    required this.clientId,
    required this.userId,
    required this.clientName,
    required this.companyName,
    required this.clientEmail,
    required this.createdAt,
  });
}

final class CountAllClients extends ClientEvent {
  final String userId;

  CountAllClients({required this.userId});
}

final class CountMonthlyClients extends ClientEvent {
  final String userId;

  CountMonthlyClients({required this.userId});
}
