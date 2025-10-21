import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/utils/format_date.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/add_new_project.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_projects.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/card_widget.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/create_button.dart';

class ClientDetailsPage extends StatefulWidget {
  final Client client;
  const ClientDetailsPage({super.key, required this.client});

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  @override
  void initState() {
    context.read<ProjectBloc>().add(
      ProjectSearchByStatus(
        clientId: widget.client.clientId,
        status: PStatus.pending,
      ),
    );
    context.read<ProjectBloc>().add(
      ProjectSearchByStatus(
        clientId: widget.client.clientId,
        status: PStatus.complete,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Client Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/allclients/');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ─── Client Basic Info Card ────────────────────────────────────────
            CardWidget(
              showChip: false,
              title: widget.client.clientName,
              desc: '',
              status: '',
              onPressed: null,
              color: colorScheme.tertiary,
              smallCard: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(
                        'Created At ${formatDateddMMMYYYY(widget.client.createdAt)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ─── Contact Information ───────────────────────────────────────────
            const SectionHeader(title: 'Contact Information'),
            const SizedBox(height: 10),
            InfoTile(
              icon: Icons.email,
              label: 'Email',
              value: widget.client.clientEmail,
            ),
            InfoTile(
              icon: Icons.location_on_outlined,
              label: 'Company',
              value: widget.client.companyName,
            ),

            const SizedBox(height: 30),

            /// ─── Active (Pending) Projects ─────────────────────────────────
            const SectionHeader(title: 'Active Projects'),
            const SizedBox(height: 10),

            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProjectDisplaySuccess) {
                  final pending = state.projects
                      .where((p) => p.status == PStatus.pending)
                      .toList();

                  if (pending.isEmpty) {
                    return const Text('No pending projects.');
                  }

                  return Column(
                    children: pending.map((project) {
                      return ProjectCard(
                        title: project.projectName,
                        status: 'In Progress',
                        color: Colors.orange,
                      );
                    }).toList(),
                  );
                } else if (state is ProjectFailure) {
                  return Text('Error: ${state.error}');
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 10),

            /// ─── Completed Projects ───────────────────────────────────────
            const SectionHeader(title: 'Completed Projects'),
            const SizedBox(height: 10),

            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProjectDisplaySuccess) {
                  final completed = state.projects
                      .where((p) => p.status == PStatus.complete)
                      .toList();

                  if (completed.isEmpty) {
                    return const Text('No completed projects.');
                  }

                  return Column(
                    children: completed.map((project) {
                      return ProjectCard(
                        title: project.projectName,
                        status: 'Completed',
                        color: Colors.green,
                      );
                    }).toList(),
                  );
                } else if (state is ProjectFailure) {
                  return Text('Error: ${state.error}');
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 30),
            CreateButton(
              text: 'Add Project',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AddNewProjectsPage(client: widget.client),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            CreateButton(
              text: 'View Projects',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllProjects(client: widget.client),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ─── Section Header Widget ─────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

/// ─── InfoTile Widget ───────────────────────────────────────────────────────
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}

/// ─── Project Card Widget ───────────────────────────────────────────────────
class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final Color color;
  const ProjectCard({
    super.key,
    required this.title,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
