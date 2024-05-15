import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/text_field.dart';
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
    return BlocBuilder<ConnectionsBloc, ConnectionsState>(
      builder: (context, state) {
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
                            "Connected",
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
                            "Sent",
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
                            "Received",
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
