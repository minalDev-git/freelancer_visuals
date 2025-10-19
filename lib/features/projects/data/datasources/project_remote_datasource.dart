import 'package:freelancer_visuals/core/error/exceptions.dart';
import 'package:freelancer_visuals/features/projects/data/models/project_model.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProjectRemoteDataSource {
  Future<ProjectModel> createProject(ProjectModel project);
  Future<List<ProjectModel>> getAllProjects(String userId);
  Future<List<ProjectModel>> getAllProjectsOfClient(
    String userId,
    String clientId,
  );
  Future<int> getTotalProjects(String userId);
  Future<int> getMonthlyProjects(String userId);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<void> deleteProject(String projectId);
  Future<ProjectModel> getProject(String projectName);
  Future<ProjectModel> getProjectByStatus(String clientId, PStatus status);
  Future<List<ProjectModel>> getAllProjectsByStatus(
    String userId,
    PStatus status,
  );
  Future<int> getTotalProjectsByStatus(String userId, PStatus status);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProjectRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ProjectModel> createProject(ProjectModel project) async {
    try {
      final projectData = await supabaseClient
          .from('project')
          .insert(project.toJson())
          .select();
      return ProjectModel.fromJson(projectData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProjectModel> getProject(String projectName) async {
    try {
      final projectData = await supabaseClient
          .from('project')
          .select()
          .eq('projectName', projectName);
      return ProjectModel.fromJson(projectData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProjectModel> getProjectByStatus(
    String clientId,
    PStatus status,
  ) async {
    try {
      final projectData = await supabaseClient
          .from('project')
          .select()
          .eq('client_id', clientId)
          .eq('status', status.toValue());
      return ProjectModel.fromJson(projectData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> getAllProjects(String userId) async {
    try {
      final projects = await supabaseClient
          .from('project')
          .select('*')
          .eq('user_id', userId);
      return projects.map((project) => ProjectModel.fromJson(project)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> getAllProjectsOfClient(
    String userId,
    String clientId,
  ) async {
    try {
      final projects = await supabaseClient
          .from('project')
          .select('*')
          .eq('user_id', userId)
          .eq('client_id', clientId);

      return (projects as List<dynamic>)
          .map((project) => ProjectModel.fromJson(project))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalProjects(String userId) async {
    try {
      final response = await supabaseClient
          .from('project')
          .select('project_id')
          .eq('user_id', userId)
          .count();
      if (response.count > 0) {
        return response.count;
      }
      return 0;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getMonthlyProjects(String userId) async {
    try {
      final now = DateTime.now();
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0);

      final res = await supabaseClient
          .from('project')
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
  Future<ProjectModel> updateProject(ProjectModel project) async {
    try {
      final updatedProjectData = await supabaseClient
          .from('project')
          .update(project.toJson())
          .eq('project_id', project.clientId)
          .select();
      return ProjectModel.fromJson(updatedProjectData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteProject(String projectId) async {
    try {
      await supabaseClient.from('project').delete().eq('project_id', projectId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProjectModel>> getAllProjectsByStatus(
    String userId,
    PStatus status,
  ) async {
    try {
      final projects = await supabaseClient
          .from('project')
          .select('*')
          .eq('user_id', userId)
          .eq('status', status.toValue());

      return (projects
          .map((project) => ProjectModel.fromJson(project))
          .toList());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTotalProjectsByStatus(String userId, PStatus status) async {
    try {
      final res = await supabaseClient
          .from('project')
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
}
