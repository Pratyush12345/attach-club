import 'dart:developer';

import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/rating.dart';
import '../profile/profile.dart';

class ProfileCard extends StatelessWidget {
  final int selected;
  final String name;
  final String description;
  final String accountType;
  final String asset;
  final String uid;

  const ProfileCard({
    super.key,
    required this.selected,
    required this.name,
    required this.description,
    required this.accountType,
    required this.asset,
    required this.uid,
  });

  _getImage(height) {
    final staticImage = SizedBox(
      height: 0.1942060086 * height,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.person,
              size: 0.1242060086 * height,
            ),
          ),
          accountType.toLowerCase() == "premium"
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: Image.asset(
                        "assets/images/premium_icon.png",
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );

    if (asset.isEmpty) {
      return staticImage;
    }
    return SizedBox(
      height: 0.1942060086 * height,
      width: double.infinity,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
            child: accountType.toLowerCase() == "premium"
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: Image.asset(
                          "assets/images/premium_icon.png",
                        )),
                  )
                : const SizedBox(),
          );
        },
        placeholder: (context, url) {
          return Shimmer.fromColors(
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              color: Colors.white,
            ),
          );
        },
        imageUrl: asset,
        fit: BoxFit.fill,
        height: 0.1942060086 * height,
        errorWidget: (context, error, stackTrace) {
          return staticImage;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        String title = "Connect";

        int index1 = context
            .read<ConnectionsBloc>()
            .connectedList
            .indexWhere((element) => element.uid == uid);

        if (index1 != -1) {
          title = "Connected";
        } else {
          title = context
                      .read<ConnectionsBloc>()
                      .sentList
                      .indexWhere((element) => element.uid == uid) !=
                  -1
              ? "Request Sent"
              : context
                          .read<ConnectionsBloc>()
                          .receivedList
                          .indexWhere((element) => element.uid == uid) !=
                      -1
                  ? "Received"
                  : "Connect";
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              buttonTitle: title,
              uid: uid,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        color: const Color(0xFF181B2F),
        child: SizedBox(
          width: 0.39069 * width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _getImage(height),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.009656652361 * height,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Rating(selected: selected),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
