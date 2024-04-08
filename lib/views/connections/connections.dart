import 'package:attach_club/constants.dart';
import 'package:attach_club/views/connections/connected_connections.dart';
import 'package:attach_club/views/connections/recieve_connections.dart';
import 'package:attach_club/views/connections/sent_connections.dart';
import 'package:flutter/material.dart';

import '../../core/text_field.dart';

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
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF26293B),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.white,
            tabs: const [
              Tab(text: "Connected"),
              Tab(text: "Sent"),
              Tab(text: "Receive"),
            ],
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
              prefixWidget: const Icon(Icons.search),
              hintText: "Search name...",
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
              children: const [
                ConnectedConnections(),
                SentConnections(),
                ReceiveConnections(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
