import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';
import 'package:freelancer_visuals/core/utils/show_snackbar.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/client/client_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/create_button.dart';

import 'package:freelancer_visuals/features/projects/presentation/widgets/text_editor.dart';

class AddNewClientPage extends StatefulWidget {
  const AddNewClientPage({super.key});

  @override
  State<AddNewClientPage> createState() => _AddNewClientPageState();
}

class _AddNewClientPageState extends State<AddNewClientPage> {
  final clientNameController = TextEditingController();
  final companyController = TextEditingController();
  final clientEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // rateController.dispose();
    clientNameController.dispose();
    companyController.dispose();
    clientEmailController.dispose();
    super.dispose();
  }

  void addClient() {
    formKey.currentState!.validate();
    if (formKey.currentState!.validate()) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<ClientBloc>().add(
        ClientUpload(
          userId: userId,
          clientName: clientNameController.text.trim(),
          companyName: companyController.text.trim(),
          clientEmail: clientEmailController.text.trim(),
          createdAt: DateTime.now(),
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
            Navigator.of(context).pushReplacementNamed('/allclients/');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<ClientBloc, ClientState>(
        listener: (context, state) {
          if (state is ClientFailure) {
            showSnackBar(context, state.error);
          } else if (state is ClientUploadSuccess) {
            Navigator.of(context).pushReplacementNamed('/allclients/');
          }
        },
        builder: (context, state) {
          if (state is ClientLoading) {
            return Center(child: const Loader());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.person, size: 40),
                    const Text(
                      'Add Client',
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
                    CreateButton(text: 'Create', onPressed: () => addClient()),
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
