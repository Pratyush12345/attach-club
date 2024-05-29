import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Card(
              color: Color(0xFF26293B),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Notification Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Notification Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Text("2 min ago"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
}
