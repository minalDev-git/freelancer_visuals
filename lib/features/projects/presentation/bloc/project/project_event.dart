part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

final class ProjectUpload extends ProjectEvent {
  final String clientId;
  final String userId;
  final String projectName;
  final String category;
  final DateTime startDate;
  final DateTime deadline;
  final PStatus status;
  final double ammount;

  ProjectUpload({
    required this.clientId,
    required this.userId,
    required this.projectName,
    required this.category,
    required this.startDate,
    required this.deadline,
    required this.status,
    required this.ammount,
  });
}

final class ProjectUpdate extends ProjectEvent {
  final String projectId;
  final String clientId;
  final String userId;
  final String projectName;
  final String category;
  final DateTime startDate;
  final DateTime deadline;
  final PStatus status;
  final double ammount;

  ProjectUpdate({
    required this.projectId,
    required this.clientId,
    required this.userId,
    required this.projectName,
    required this.category,
    required this.startDate,
    required this.deadline,
    required this.status,
    required this.ammount,
  });
}

final class AllProjectsList extends ProjectEvent {
  final String userId;

  AllProjectsList({required this.userId});
}

final class AllProjectsByStatusList extends ProjectEvent {
  final String userId;
  final PStatus status;

  AllProjectsByStatusList({required this.userId, required this.status});
}

final class AllClientProjects extends ProjectEvent {
  final String userId;
  final String clientId;

  AllClientProjects({required this.userId, required this.clientId});
}

final class ProjectDelete extends ProjectEvent {
  final String projectId;

  ProjectDelete({required this.projectId});
}

final class ProjectSearch extends ProjectEvent {
  final String projectName;

  ProjectSearch({required this.projectName});
}

final class ProjectSearchByID extends ProjectEvent {
  final String projectId;

  ProjectSearchByID({required this.projectId});
}

final class ProjectSearchByStatus extends ProjectEvent {
  final String clientId;
  final PStatus status;

  ProjectSearchByStatus({required this.clientId, required this.status});
}

final class CountAllProjects extends ProjectEvent {
  final String userId;

  CountAllProjects({required this.userId});
}

final class CountMonthlyProjects extends ProjectEvent {
  final String userId;

  CountMonthlyProjects({required this.userId});
}
