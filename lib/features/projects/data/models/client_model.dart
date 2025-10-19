import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.clientId,
    required super.userId,
    required super.clientName,
    required super.companyName,
    required super.clientEmail,
    required super.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'client_id': clientId,
      'user_id': userId,
      'client_name': clientName,
      'company_name': companyName,
      'client_email': clientEmail,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> map) {
    return ClientModel(
      clientId: map['client_id'] as String,
      userId: map['user_id'] as String,
      clientName: map['client_name'] as String,
      companyName: map['company_name'] as String,
      clientEmail: map['client_email'] as String,
      createdAt: map['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['created_at']),
    );
  }

  ClientModel copyWith({
    String? clientId,
    String? userId,
    String? clientName,
    String? companyName,
    String? clientEmail,
    DateTime? createdAt,
  }) {
    return ClientModel(
      clientId: clientId ?? this.clientId,
      userId: userId ?? this.userId,
      clientName: clientName ?? this.clientName,
      companyName: companyName ?? this.companyName,
      clientEmail: clientEmail ?? this.clientEmail,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
