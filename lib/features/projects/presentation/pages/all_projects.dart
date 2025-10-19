import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';
import 'package:freelancer_visuals/core/utils/show_snackbar.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/add_new_project.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/edit_project.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/project_details_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/show_listview.dart';

import 'package:freelancer_visuals/features/projects/presentation/widgets/text_editor.dart';

class AllProjects extends StatefulWidget {
  final Client? client;
  const AllProjects({super.key, this.client});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<ProjectBloc>().add(AllProjectsList(userId: userId));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query, BuildContext context) {
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    if (query.isEmpty) {
      if (widget.client == null) {
        context.read<ProjectBloc>().add(
          AllProjectsList(userId: userId),
        ); // show all
      } else {
        context.read<ProjectBloc>().add(
          AllClientProjects(userId: userId, clientId: widget.client!.clientId),
        ); // show all
      }
    } else {
      context.read<ProjectBloc>().add(ProjectSearch(projectName: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextEditor(
                  controller: searchController,
                  hintText: 'Search Projects',
                  onChanged: (value) => _onSearchChanged(value, context),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Projects',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 650,
                  child: BlocConsumer<ProjectBloc, ProjectState>(
                    listener: (context, state) {
                      if (state is ProjectFailure) {
                        showSnackBar(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProjectLoading) {
                        return const Center(child: Loader());
                      }
                      if (state is ProjectDisplaySuccess) {
                        return ShowListview<Project>(
                          itemcount: state.projects.length,
                          items: state.projects,
                          status: null,
                          itemBuilder: (project) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(project.projectName),
                              subtitle: Text(project.status.toValue()),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProjectDetailsPage(project: project),
                                  ),
                                );
                              },
                              tileColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              leading: Image.asset(
                                'assets/images/user.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          onEditPressed: (context, project) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProjectPage(project: project),
                              ),
                            );
                          },
                          onDeletePressed: (context, project) {
                            context.read<ProjectBloc>().add(
                              ProjectDelete(projectId: project.projectId),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNewProjectsPage(client: widget.client!),
            ),
          );
        },
        heroTag: 3,
        child: const Icon(Icons.add),
      ),
    );
  }
}
