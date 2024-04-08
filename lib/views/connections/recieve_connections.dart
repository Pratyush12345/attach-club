import 'package:attach_club/constants.dart';
import 'package:attach_club/views/connections/connection_card.dart';
import 'package:flutter/material.dart';

class ReceiveConnections extends StatelessWidget {
  const ReceiveConnections({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          _getListView(width),
          const SizedBox(height: paddingDueToNav,),
        ],
      ),
    );
  }

  _getListView(double width){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (
          BuildContext context,
          int index,
          ) {
        return ConnectionCard(
          actions: [
            GestureDetector(
              onTap: (){},
              child: Container(
                width: 0.1860465116*width,
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
              onTap: (){},
              child: Container(
                width: 0.1860465116*width,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Connect",
                    style: TextStyle(
                      color: Colors.white,
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
      itemCount: 10,
    );
  }
}
