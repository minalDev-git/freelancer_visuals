import 'package:flutter/material.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/add_invoice_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/create_button.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  final Client client;
  const ProjectDetailsPage({
    super.key,
    required this.project,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Column(
        children: [
          CreateButton(
            text: 'Generate Invoice',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InvoicePage(client: client),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
