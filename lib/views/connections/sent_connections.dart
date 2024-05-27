import 'dart:developer';

import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connection_card.dart';

class SentConnections extends StatelessWidget {
  final List<ConnectionRequest> list;

  const SentConnections({
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
      itemCount: list.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return ConnectionCard(
          page: "Request Sent",
          request: list[index],
          actions: [
            ElevatedButton(
              onPressed: () {
                log("clicked");
                context
                    .read<ConnectionsBloc>()
                    .add(RequestRemoved(list[index]));
              },
              child: const Text(
                "Unsend request",
                style: TextStyle(
                  color: primaryTextColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
