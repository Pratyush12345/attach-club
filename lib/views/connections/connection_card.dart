import 'package:attach_club/models/connection_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectionCard extends StatelessWidget {
  final List<Widget> actions;
  final ConnectionRequest request;

  const ConnectionCard({
    super.key,
    required this.request,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                request.uid,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          request.phoneNo,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: actions,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
        )
      ],
    );
  }
}
