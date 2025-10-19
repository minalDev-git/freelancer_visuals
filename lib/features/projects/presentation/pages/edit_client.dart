import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';

import 'package:freelancer_visuals/core/utils/show_snackbar.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';

import 'package:freelancer_visuals/features/projects/presentation/bloc/client/client_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/create_button.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/text_editor.dart';

class EditClientPage extends StatefulWidget {
  final Client client; // Existing client to edit
  const EditClientPage({super.key, required this.client});

  @override
  State<EditClientPage> createState() => _EditClientPageState();
}

class _EditClientPageState extends State<EditClientPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController clientNameController;
  late TextEditingController companyController;
  late TextEditingController clientEmailController;

  @override
  void initState() {
    super.initState();
    clientNameController = TextEditingController(
      text: widget.client.clientName,
    );
    companyController = TextEditingController(text: widget.client.companyName);
    clientEmailController = TextEditingController(
      text: widget.client.clientEmail,
    );
  }

  @override
  void dispose() {
    clientNameController.dispose();
    companyController.dispose();
    clientEmailController.dispose();
    super.dispose();
  }

  void updateClient() {
    if (formKey.currentState!.validate()) {
      context.read<ClientBloc>().add(
        ClientUpdate(
          clientId: widget.client.clientId,
          userId: widget.client.userId,
          clientName: clientNameController.text.trim(),
          companyName: companyController.text.trim(),
          clientEmail: clientEmailController.text.trim(),
          createdAt: widget.client.createdAt,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/allclients/', (route) => false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is ClientFailure) {
            showSnackBar(context, state.error);
          } else if (state is ClientUploadSuccess) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/allclients/', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is ClientLoading) {
            return const Center(child: Loader());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.edit, size: 40),
                    const Text(
                      'Edit Client',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Client Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextEditor(
                      controller: clientNameController,
                      hintText: 'Client\'s Full Name',
                      onChanged: null,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Client Email',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextEditor(
                      controller: clientEmailController,
                      hintText: 'Client\'s Email',
                      onChanged: null,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Company Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextEditor(
                      controller: companyController,
                      hintText: 'Company Name',
                      onChanged: null,
                    ),
                    const SizedBox(height: 20),
                    CreateButton(
                      text: 'Update',
                      onPressed: () => updateClient(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
