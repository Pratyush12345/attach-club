import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/views/connections/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/connections/connections_bloc.dart';

class ConnectedConnections extends StatelessWidget {
  final List<ConnectionRequest> list;

  const ConnectedConnections({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (list.isEmpty) {
      return const Center(
        child: Text(
          "No Connections to show",
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          _getListView(width),
          const SizedBox(
            height: paddingDueToNav,
          ),
        ],
      ),
    );
  }

  _getListView(double width) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return ConnectionCard(
          page: "Disconnect",
          request: list[index],
          actions: [
            GestureDetector(
              onTap: () {
                context
                    .read<ConnectionsBloc>()
                    .add(WhatsappIconClicked(list[index].phoneNo));
              },
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xFF26293B), shape: BoxShape.circle),
                child: SvgPicture.asset("assets/svg/whatsapp_connections.svg"),
              ),
            ),
            SizedBox(
              width: 0.03720930233 * width,
            ),
            GestureDetector(
              onTap: () async {
                context
                    .read<ConnectionsBloc>()
                    .add(PhoneIconClicked(list[index].phoneNo));
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    color: Color(0xFF2D4CF9), shape: BoxShape.circle),
                child: const Icon(
                  Icons.phone,
                ),
              ),
            )
          ],
        );
      },
      itemCount: list.length,
    );
  }
}
