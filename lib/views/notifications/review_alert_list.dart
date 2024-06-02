import 'dart:math';

import 'package:attach_club/models/notification_data.dart';
import 'package:attach_club/models/review.dart';
import 'package:flutter/material.dart';

class ReviewAlertList extends StatelessWidget {
  final List<Review> list;

  const ReviewAlertList({super.key, required this.list,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(2, list.length),
      padding: EdgeInsets.zero,
      // itemExtent: 100,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF26293B),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                          "You got a review from ${list[index].name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 6.0,),
                      Text(
                        list[index].feedback,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
