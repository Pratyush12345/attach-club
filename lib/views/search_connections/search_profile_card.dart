import 'package:attach_club/bloc/connections/connection_provider.dart';
import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/bloc/search_connections/Search_provider.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/rating.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../bloc/search_connections/search_connections_bloc.dart';

class SearchProfileCard extends StatelessWidget {
  final UserData userData;

  const SearchProfileCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageRadius = 0.2162790698 * width;
    final check = context
        .read<SearchConnectionsBloc>()
        .requestsSent
        .contains(userData.uid);

    String buttonText = "";

    return Consumer<ChangeSearchScreenProvider>(
        builder: (context, model, child) {
      if (context
              .read<ConnectionsBloc>()
              .connectedList
              .indexWhere((element) => element.uid == userData.uid) ==
          -1) {
        if (context
                .read<ConnectionsBloc>()
                .receivedList
                .indexWhere((element) => element.uid == userData.uid) ==
            -1) {
          if (context
                  .read<ConnectionsBloc>()
                  .sentList
                  .indexWhere((element) => element.uid == userData.uid) ==
              -1) {
            buttonText = "Connect";
          } else {
            buttonText = "Request Sent";
          }
        } else {
          buttonText = "Received";
        }
      } else {
        buttonText = "Connected";
      }

      return GestureDetector(
        onTap: () {
          if (context.read<UserDataNotifier>().userData.profileClickCount < 3 || context.read<UserDataNotifier>().userData.accountType == "premium") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(
                  buttonTitle: buttonText,
                  uid: userData.uid,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "You have reached the maximum limit of profile views for the day. Upgrade to premium to view more profiles.",
                ),
              ),
            );
            Navigator.of(context).pushNamed("/buyPlan");
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: const Color(0xFF373A4B),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 0.1856223176 * height,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 0.05581395349 * width),
                              Container(
                                width: imageRadius,
                                height: imageRadius,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    imageRadius / 2,
                                  ),
                                  child: _getImage(width),
                                ),
                              ),
                              SizedBox(width: 0.03488372093 * width),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        userData.profession,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                right: 10,
                              ),
                              //TODO: Replace with SVG
                              child: (userData.accountType == "premium")
                                  ? Image.asset(
                                      "assets/images/premium_icon.png",
                                      width: 0.06279069767 * width,
                                      height: 0.06279069767 * width,
                                    )
                                  : null,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 0.05422746781 * height,
                    color: const Color(0xFF26293B),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 0.04418604651 * width),
                            Text(
                              "${userData.rating} out of 5 stars",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Rating(
                              selected: userData.rating,
                              width: 0.1465116279 * width,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 0.02325581395 * width,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: const Color(0xFF4285F4)),
                            onPressed: () {
                              if (buttonText == "Connect") {
                                context
                                    .read<SearchConnectionsBloc>()
                                    .add(ConnectButtonClicked(userData.uid!));

                                context.read<ConnectionsBloc>().sentList.add(
                                        ConnectionRequest.fromMap(
                                            connectionData: {
                                          "status": CONNECTION_SENT_STATUS,
                                          "updateTime": Timestamp.now()
                                        },
                                            uid: userData.uid!,
                                            userData: userData.toMap()));
                                Provider.of<ChangeConnectionScreenProvider>(
                                        context,
                                        listen: false)
                                    .changeScreenIndex("");
                                Provider.of<ChangeSearchScreenProvider>(context,
                                        listen: false)
                                    .changeSearchScreenIndex("");
                              }
                            },
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _getImage(double width) {
    final person = Icon(
      Icons.person,
      color: Colors.black,
      size: 0.2162790698 * width,
    );
    const loading = CircularProgressIndicator(
      color: Colors.grey,
    );
    return Image.network(
      userData.profileImageURL,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return loading;
        }
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return person;
      },
    );
  }
}
