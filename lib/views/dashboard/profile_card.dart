import 'dart:developer';

import 'package:attach_club/bloc/connections/connections_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/rating.dart';
import '../profile/profile.dart';

class ProfileCard extends StatelessWidget {
  final int selected;
  final String name;
  final String description;
  final String asset;
  final String uid;

  const ProfileCard({
    super.key,
    required this.selected,
    required this.name,
    required this.description,
    required this.asset,
    required this.uid,
  });

  _getImage(height) {

    final staticImage = SizedBox(
      height: 0.1942060086 * height,
      width: double.infinity,
      child: Icon(
        Icons.person, 
        size: 0.1242060086 * height,
      ),
    );
    
    if(asset.isEmpty){
      return staticImage;
    }
    return  SizedBox(
      height: 0.1942060086 * height,
      width: double.infinity,
      child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return const SizedBox(
                                  height: 10.0,
                                  width: 10.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
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
        
        int index1 = context.read<ConnectionsBloc>().connectedList.indexWhere((element) => element.uid == uid);
        
        if(index1 !=-1){
         title = "Connected";
        }
        else{
          title = context.read<ConnectionsBloc>().sentList.indexWhere((element) => element.uid == uid)!=-1 ? "Request Sent" : 
          context.read<ConnectionsBloc>().receivedList.indexWhere((element) => element.uid == uid)!=-1 ? "Received" : "Connect";
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
