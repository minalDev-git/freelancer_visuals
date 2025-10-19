import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/core/utils/show_snackbar.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';

import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OngoingProjects extends StatefulWidget {
  const OngoingProjects({super.key});

  @override
  State<OngoingProjects> createState() => _OngoingProjectsState();
}

class _OngoingProjectsState extends State<OngoingProjects> {
  @override
  void initState() {
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<ProjectBloc>().add(
      AllProjectsByStatusList(userId: userId, status: PStatus.pending),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectBloc, ProjectState>(
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
          // Filtered list shown on screen
          final pendingProjects = state.projects;
          return ListView.builder(
            itemCount: pendingProjects.length,
            itemBuilder: (context, index) {
              final project = pendingProjects[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: Text(
                              // project.projectName,
                              'Project Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            //proj_details
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios),
                            iconSize: 20,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Start Date:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            // project.startDate.toString(),
                            '12-12-21',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Est. Completion: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '12-12-21',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Client\'s Name: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'ABC Client',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Amount: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Chip(
                            label: Text(
                              // project.ammount.toString(),
                              '\$400',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppPallete.darkBackgroundColor,
                              ),
                            ),
                            color: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final totalDuration = project.deadline
                              .difference(project.startDate)
                              .inDays; // total days
                          final elapsedDuration = DateTime.now()
                              .difference(project.startDate)
                              .inDays; // days passed

                          // Clamp between 0 and 1 to avoid overflow or negative values
                          final progressPercent =
                              (elapsedDuration / totalDuration).clamp(0.0, 1.0);

                          final remainingDays = project.deadline
                              .difference(DateTime.now())
                              .inDays; // days left
                          return LinearPercentIndicator(
                            width:
                                constraints.maxWidth, // safe width from parent
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: progressPercent,

                            center: Text(
                              remainingDays > 0
                                  ? '$remainingDays days left'
                                  : 'Deadline reached',

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            barRadius: Radius.circular(10),
                            progressColor: progressPercent < 0.75
                                ? Colors.green
                                : progressPercent < 1.0
                                ? Colors.orange
                                : Colors.red,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(),
                          );
                        },
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
