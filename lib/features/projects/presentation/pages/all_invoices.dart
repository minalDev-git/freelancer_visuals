import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/core/utils/format_date.dart';
import 'package:freelancer_visuals/core/utils/show_snackbar.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/invoice.dart';

import 'package:freelancer_visuals/features/projects/presentation/bloc/invoice/invoice_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/add_invoice_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/invoice_details_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/show_listview.dart';

class AllInvoices extends StatefulWidget {
  final Client? client;
  // final Project? project;
  const AllInvoices({super.key, required this.client});

  @override
  State<AllInvoices> createState() => _AllInvoicesState();
}

class _AllInvoicesState extends State<AllInvoices> {
  final searchController = TextEditingController();
  @override
  void initState() {
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<InvoiceBloc>().add(AllInvoicesList(userId: userId));
    context.read<InvoiceBloc>().add(
      CountAllInvoicesByStatus(userId: userId, status: IStatus.paid),
    );
    context.read<InvoiceBloc>().add(
      CountAllInvoicesByStatus(userId: userId, status: IStatus.unpaid),
    );
    context.read<InvoiceBloc>().add(
      CountAllInvoicesByStatus(userId: userId, status: IStatus.late),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<InvoiceBloc, InvoiceState>(
              listener: (context, state) {
                if (state is InvoiceFailure) {
                  showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is InvoiceLoading) {
                  return const Center(child: Loader());
                }
                if (state is InvoiceDisplaySuccess) {
                  final invoices = state.invoices;
                  final paid = invoices
                      .where((inv) => inv.status == IStatus.paid)
                      .length;
                  final unpaid = invoices
                      .where((inv) => inv.status == IStatus.unpaid)
                      .length;
                  final overdue = invoices
                      .where((inv) => inv.status == IStatus.late)
                      .length;
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppPallete.darkEnabledBorder,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  paid.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                                const Text(
                                  'Paid',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  unpaid.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                                const Text(
                                  'Unpaid',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  overdue.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                                const Text(
                                  'Overdue',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invoice',
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
                        height: 400,
                        child: ShowListview<Invoice>(
                          itemcount: state.invoices.length,
                          items: state.invoices,
                          status: null,
                          itemBuilder: (invoice) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(invoice.clientId),
                              subtitle: Text(
                                formatDateddMMMYYYY(invoice.issueDate),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => InvoiceDetailsPage(
                                      projectName: 'ProjectName',
                                      invoiceNumber: 'Invoice#003',
                                      clientName: widget.client!.clientName,
                                      clientEmail: widget.client!.clientEmail,
                                      dueDate: invoice.issueDate.add(
                                        const Duration(days: 7),
                                      ),
                                      issueDate: invoice.issueDate,
                                      isPaid: invoice.status == IStatus.paid
                                          ? true
                                          : false,
                                    ),
                                  ),
                                );
                              },
                              tileColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              leading: const Icon(Icons.edit_document),
                            ),
                          ),
                          onEditPressed: (context, invoice) {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         EditInvoicePage(invoice: invoice),
                            //   ),
                            // );
                          },
                          onDeletePressed: (context, invoice) {
                            context.read<InvoiceBloc>().add(
                              InvoiceDelete(invoiceId: invoice.invoiceId),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
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
              builder: (context) => InvoicePage(client: widget.client),
            ),
          );
        },
        heroTag: 3,
        child: const Icon(Icons.add),
      ),
    );
  }
}
