import 'dart:math';

import 'package:attach_club/constants.dart';
import 'package:attach_club/views/notifications/alerts_list.dart';
import 'package:attach_club/views/notifications/review_alert_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notifications/notifications_bloc.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart' as cBloc;
import '../../bloc/profile/profile_bloc.dart' as profileBloc;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    final connectedList = context.read<cBloc.ConnectionsBloc>().connectedList;
    final sentList = context.read<cBloc.ConnectionsBloc>().sentList;
    final receivedList = context.read<cBloc.ConnectionsBloc>().receivedList;

    context.read<NotificationsBloc>().add(GetNotifications(
          connectedList: connectedList,
          sentList: sentList,
          receivedList: receivedList,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: BlocConsumer<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            if (state is ShowSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final publicAlerts = context.read<NotificationsBloc>().publicAlerts;
            final privateAlerts =
                context.read<NotificationsBloc>().privateAlerts;
            final reviewList =
                context.read<profileBloc.ProfileBloc>().reviewsList;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // const Text(
                  //   "Alerts: ",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  AlertsList(list: publicAlerts),
                  AlertsList(list: privateAlerts),
                  // const Text(
                  //   "Reviews: ",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  ReviewAlertList(list: reviewList),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
