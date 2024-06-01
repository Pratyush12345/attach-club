import 'dart:developer';

import 'package:attach_club/bloc/connections/connection_provider.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'connection_card.dart';

class SentConnections extends StatefulWidget {
  final List<ConnectionRequest> list;

  const SentConnections({
    super.key,
    required this.list,
  });

  @override
  State<SentConnections> createState() => _SentConnectionsState();
}

class _SentConnectionsState extends State<SentConnections> {
  
    ScrollController scrollController = ScrollController();
  
   @override
  void dispose() {
     scrollController.removeListener(_scrollListener);
     scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       scrollController.addListener(_scrollListener);
    });
    super.initState();
  }

  void _scrollListener() {

    if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
       animationController.reverse();
      });
    } else if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
       animationController.forward();
      });
     }
  }

  
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
      itemCount: widget.list.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return ConnectionCard(
          page: "Request Sent",
          request: widget.list[index],
          actions: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<ConnectionsBloc>()
                    .add(RequestRemoved(widget.list[index]));
                 Provider.of<ChangeSearchScreenProvider>(context, listen: false).changeSearchScreenIndex("");    
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
