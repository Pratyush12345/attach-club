import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/text_field.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/views/connections/connected_connections.dart';
import 'package:attach_club/views/connections/recieve_connections.dart';
import 'package:attach_club/views/connections/sent_connections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Connections extends StatefulWidget {
  const Connections({super.key});

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    context.read<ConnectionsBloc>().add(FetchConnections());
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ConnectionsBloc, ConnectionsState>(
      listener: (context, state){
        if(state is ShowSnackBar){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if((state is ConnectionsLoading || state is ConnectionsInitial ) && !GlobalVariable.isConnectionsBuildOnce){
          GlobalVariable.isConnectionsBuildOnce = true;
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
        return Column(
          children: [
            Container(
              width: width,
              color: const Color(0xFF26293B),
              child: Center(
                child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.white,
                  tabAlignment: TabAlignment.center,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: (width - 48) / 3,
                        child: const Center(
                          child: Text(
                            CONNECTION_CONNECTED_STATUS,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: (width - 48) / 3,
                        child: const Center(
                          child: Text(
                            CONNECTION_SENT_STATUS,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: (width - 48) / 3,
                        child: const Center(
                          child: Text(
                            CONNECTION_RECEIVED_STATUS,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFF26293B),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 13),
                child: CustomTextField(
                  type: TextFieldType.RegularTextField,
                  controller: searchController,
                  color: const Color(0xFF181B2F),
                  prefixWidget: const Icon(
                    Icons.search,
                    color: Color(0xFF94969F),
                  ),
                  hintText: "Search name...",
                  height: 48,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ConnectedConnections(
                      list: context.read<ConnectionsBloc>().connectedList,
                    ),
                    SentConnections(
                      list: context.read<ConnectionsBloc>().sentList,
                    ),
                    ReceiveConnections(
                      list: context.read<ConnectionsBloc>().receivedList,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
