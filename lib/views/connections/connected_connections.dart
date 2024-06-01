import 'package:attach_club/constants.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/views/connections/connection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/connections/connections_bloc.dart';

class ConnectedConnections extends StatefulWidget {
  final List<ConnectionRequest> list;

  const ConnectedConnections({
    super.key,
    required this.list,
  });

  @override
  State<ConnectedConnections> createState() => _ConnectedConnectionsState();
}

class _ConnectedConnectionsState extends State<ConnectedConnections> {
 
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
    final width = MediaQuery.of(context).size.width;
    if (widget.list.isEmpty) {
      return const Center(
        child: Text(
          "No Connections to show",
        ),
      );
    }
    return SingleChildScrollView(
      controller: scrollController,
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
          request: widget.list[index],
          actions: [
            GestureDetector(
              onTap: () {
                context
                    .read<ConnectionsBloc>()
                    .add(WhatsappIconClicked(widget.list[index].phoneNo));
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
                    .add(PhoneIconClicked(widget.list[index].phoneNo));
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
      itemCount: widget.list.length,
    );
  }
}
