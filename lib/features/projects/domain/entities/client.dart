class Client {
  final String clientId;
  final String userId;
  final String clientName;
  final String companyName;
  final String clientEmail;
  final DateTime createdAt;

  Client({
    required this.clientId,
    required this.userId,
    required this.clientName,
    required this.companyName,
    required this.clientEmail,
    required this.createdAt,
  });
}
