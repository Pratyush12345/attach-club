import 'dart:math';

import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/models/notification_data.dart';
import 'package:flutter/material.dart';

class RequestAlertList extends StatelessWidget {
  final List<ConnectionRequest> list;

  const RequestAlertList({super.key, required this.list,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(2, list.length),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF26293B),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Text(
                          "${list[index].status}: ${list[index].name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6.0,),
                      Text(
                        "${list[index].status} to ${list[index].name}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                //calculate time ago from Timestamp and DateTime.now
               Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.3 ,
                    child: Text(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12.0),
                      _calculateTimeDiff(
                        list[index].updateTime.toDate(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _calculateTimeDiff(DateTime creationDate) {
    //calculate whether to show min ago/hour ago/day ago/month ago/year ago
    // return DateTime.now().difference(creationDate).inMinutes.toString();
    final diff = DateTime.now().difference(creationDate);
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 365) {
      return "${(diff.inDays / 30).toStringAsFixed(0)} months ago";
    } else {
      return "${(diff.inDays / 365).toStringAsFixed(0)} years ago";
    }
  }

}
