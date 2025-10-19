import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';

class ProjectModel extends Project {
  ProjectModel({
    required super.projectId,
    required super.clientId,
    required super.userId,
    required super.projectName,
    required super.category,
    required super.startDate,
    required super.deadline,
    required super.status,
    required super.ammount,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'project_id': projectId,
      'user_id': userId,
      'client_id': clientId,
      'project_name': projectName,
      'start_date': startDate.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'status': status.toValue(),
      'amount': ammount,
      'category': category,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> map) {
    return ProjectModel(
      projectId: map['project_id'] as String,
      clientId: map['client_id'] as String,
      userId: map['user_id'] as String,
      projectName: map['project_name'] as String,
      category: map['category'] as String,
      startDate: map['start_date'] == null
          ? DateTime.now()
          : DateTime.parse(map['startDate']),
      deadline: map['deadline'] == null
          ? DateTime.now()
          : DateTime.parse(map['deadline']),
      status: PStatusX.fromValue(map['status'] as String),
      ammount: (map['amount'] as num).toDouble(),
    );
  }

  ProjectModel copyWith({
    String? projectId,
    String? clientId,
    String? userId,
    String? projectName,
    String? category,
    DateTime? startDate,
    DateTime? deadline,
    PStatus? status,
    double? ammount,
  }) {
    return ProjectModel(
      projectId: projectId ?? this.projectId,
      clientId: clientId ?? this.clientId,
      userId: userId ?? this.userId,
      projectName: projectName ?? this.projectName,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      ammount: ammount ?? this.ammount,
    );
  }
}
