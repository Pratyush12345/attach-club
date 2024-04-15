import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/views/connections/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectedConnections extends StatelessWidget {
  final List<ConnectionRequest> list;

  const ConnectedConnections({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getListView(),
          const SizedBox(
            height: paddingDueToNav,
          ),
        ],
      ),
    );
  }

  _getListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return ConnectionCard(
          request: list[index],
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xFF26293B), shape: BoxShape.circle),
                child: SvgPicture.asset("assets/svg/whatsapp_connections.svg"),
              ),
            ),
            GestureDetector(
              onTap: () {},
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
