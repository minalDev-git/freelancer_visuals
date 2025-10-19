import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/pdf_api.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/create_button.dart';

import 'package:signature/signature.dart';

class InvoicePage extends StatefulWidget {
  final Client client;
  final String projectId;
  final String userId;
  const InvoicePage({
    super.key,
    required this.client,
    required this.projectId,
    required this.userId,
  });
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController projectController = TextEditingController();
  final TextEditingController accountController = TextEditingController();

  DateTime? issueDate;
  DateTime? dueDate;
  String? selectedPaymentMethod;

  final List<String> paymentMethods = [
    'Bank Transfer',
    'PayPal',
    'Payooner',
    'GPay',
    'Visa',
    'Master Card',
    'Apple Pay',
    'Easypaisa',
    'JazzCash',
  ];
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> _pickDate(BuildContext context, bool isIssue) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isIssue) {
          issueDate = picked;
        } else {
          dueDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    context.read<ProjectBloc>().add(
      ProjectSearch(projectName: projectController.text.trim()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    invoiceController.dispose();
    projectController.dispose();
    accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Invoice"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Invoice #
              const Text(
                "Invoice #",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: invoiceController,
                decoration: InputDecoration(
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Dates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Issue Date", style: textStyle),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () => _pickDate(context, true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(
                                  issueDate == null
                                      ? 'Select date'
                                      : "${issueDate!.day}/${issueDate!.month}/${issueDate!.year}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Due Date", style: textStyle),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () => _pickDate(context, false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(
                                  dueDate == null
                                      ? 'Select date'
                                      : "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Project Details
              const Text(
                "Project Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: projectController,
                decoration: InputDecoration(
                  hintText: "Enter project name",
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Payment Method
              const Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPaymentMethod,
                    hint: const Text("Choose method"),
                    isExpanded: true,
                    items: paymentMethods
                        .map(
                          (method) => DropdownMenuItem(
                            value: method,
                            child: Text(method),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                        accountController.clear();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Account Number Field (conditional)
              if (selectedPaymentMethod != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account # (${selectedPaymentMethod!})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: accountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText:
                            "Enter ${selectedPaymentMethod!} account number",
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Signature(
                  controller: _signatureController,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _signatureController.clear(),
                child: const Text("Clear"),
              ),
              const SizedBox(height: 20),
              CreateButton(
                text: 'Export PDF',
                onPressed: () async {
                  final signature = await _signatureController.toPngBytes();
                  final pdfFile = PdfApi(
                    invoiceNum: invoiceController.text.trim(),
                    createdAt: DateTime.now(),
                    paymentMethod: selectedPaymentMethod,
                    projectName: projectController.text.trim(),
                    amount: 50,
                    client: widget.client,
                  );

                  PdfApi.openFile(
                    await pdfFile.generatePDFInvoice(signature, 'ivoice.pdf'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  
    // Preview or Share PDF
    // await Printing.layoutPdf(onLayout: (format) async => pdf.save());