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

class AllClients extends StatefulWidget {
  const AllClients({super.key});

  @override
  State<AllClients> createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<ClientBloc>().add(AllClientsList(userId: userId));
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
      context.read<ClientBloc>().add(
        AllClientsList(userId: userId),
      ); // show all
    } else {
      context.read<ClientBloc>().add(ClientSearch(clientName: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home/');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
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
