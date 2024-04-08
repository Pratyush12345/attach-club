import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';

import 'connection_card.dart';

class SentConnections extends StatelessWidget {
  const SentConnections({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getListView(),
          const SizedBox(height: paddingDueToNav,),
        ],
      ),
    );
  }

  _getListView(){
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (
          BuildContext context,
          int index,
          ) {
        return ConnectionCard(
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
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
