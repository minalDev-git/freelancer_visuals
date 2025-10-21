import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/common/widgets/loader.dart';
import 'package:freelancer_visuals/core/utils/show_snackbar.dart';

import 'package:freelancer_visuals/features/projects/domain/entities/client.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/client/client_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/client_details_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/edit_client.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/show_listview.dart';
import 'package:freelancer_visuals/features/projects/presentation/widgets/text_editor.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<ClientBloc>().add(AllClientsList(userId: userId));
  }

  void _onSearchChanged(String value, BuildContext context) {
    context.read<ClientBloc>().add(ClientSearch(clientName: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/home/', (route) => false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextEditor(
                  controller: searchController,
                  hintText: 'Search Client',
                  onChanged: (value) => _onSearchChanged(value, context),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Client',
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
                  child: BlocConsumer<ClientBloc, ClientState>(
                    listener: (context, state) {
                      if (state is ClientFailure) {
                        showSnackBar(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is ClientLoading) {
                        return const Center(child: Loader());
                      }
                      if (state is ClientDisplaySuccess) {
                        if (state.clients.isEmpty) {
                          return const Center(child: Text('No clients found.'));
                        }
                        return ShowListview<Client>(
                          itemcount: state.clients.length,
                          items: state.clients,
                          status: null,
                          itemBuilder: (client) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(client.clientName),
                              subtitle: Text(client.createdAt.toString()),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ClientDetailsPage(client: client),
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
                          onEditPressed: (context, client) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditClientPage(client: client),
                              ),
                            );
                          },
                          onDeletePressed: (context, client) {
                            context.read<ClientBloc>().add(
                              ClientDelete(clientId: client.clientId),
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
          Navigator.of(context).pushReplacementNamed('/addclient/');
        },
        heroTag: 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
