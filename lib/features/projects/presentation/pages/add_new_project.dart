import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';

import 'package:freelancer_visuals/features/projects/presentation/widgets/text_editor.dart';

class AddNewProjectsPage extends StatefulWidget {
  final Client client;
  const AddNewProjectsPage({super.key, required this.client});

  @override
  State<AddNewProjectsPage> createState() => _AddNewProjectsPageState();
}

class _AddNewProjectsPageState extends State<AddNewProjectsPage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> categories = [
    "Web Development",
    "App Development",
    "Emerging Tech",
    "AI / ML",
    "Game Development",
    "Graphic/Logo Design",
    "Illustration",
    "Content Marketing",
    "Anamation/Video Production",
    "Social Media",
    "SEO/SEM",
    "Analytics",
    "Data Entry",
    "Web Research and Posting",
  ];
  String? selectedCategory;

  @override
  void initState() {
    selectedCategory = categories[0];
    super.initState();
  }

  @override
  void dispose() {
    // rateController.dispose();
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/clientdetails/');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.folder_open, size: 40),
              const Text(
                'Add Project',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Link Project Details to this Client',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.greyColor,
                ),
              ),
              const SizedBox(height: 15),
              const Text('Project Title', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextEditor(
                controller: titleController,
                hintText: 'Project Name',
                onChanged: null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                hint: const Text("Select Category"),
                value: selectedCategory,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCategory = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 30,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(height: 45),
              ),
              const SizedBox(height: 10),
              TextEditor(
                controller: amountController,
                hintText: 'Amount \$',
                onChanged: null,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final userId =
                        (context.read<AppUserCubit>().state as AppUserLoggedIn)
                            .user
                            .id;

                    context.read<ProjectBloc>().add(
                      ProjectUpload(
                        clientId: widget.client.clientId,
                        userId: userId,
                        projectName: titleController.text.trim(),
                        category: selectedCategory!,
                        startDate: DateTime.now(),
                        deadline: DateTime.now(),
                        status: PStatus.pending,
                        ammount:
                            double.tryParse(amountController.text.trim()) ??
                            0.0,
                      ),
                    );
                  }
                },
                style: ButtonStyle(),
                child: const Text('Add New Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
