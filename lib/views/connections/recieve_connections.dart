import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/views/connections/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiveConnections extends StatelessWidget {
  final List<ConnectionRequest> list;

  const ReceiveConnections({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      itemCount: list.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return ConnectionCard(
          page: "Received",
          request: list[index],
          actions: [
            GestureDetector(
              onTap: () {
                context
                    .read<ConnectionsBloc>()
                    .add(RequestRejected(list[index]));
              },
              child: Container(
                width: 0.1860465116 * width,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Reject",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<ConnectionsBloc>().add(
                      RequestAccepted(
                        index,
                      ),
                    );
              },
              child: Container(
                width: 0.1860465116 * width,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Connect",
                    style: TextStyle(
                      color: primaryTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
