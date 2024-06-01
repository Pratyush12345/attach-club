import 'package:attach_club/constants.dart';
import 'package:attach_club/models/connection_request.dart';
import 'package:attach_club/views/profile/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectionCard extends StatelessWidget {
  final List<Widget> actions;
  final ConnectionRequest request;
  final String page;
  
  const ConnectionCard({
    super.key,
    required this.request,
    required this.page,
    this.actions = const [],
  });
  
  _getProfileImage(String url) {
  const loading = CircularProgressIndicator(
    color: Colors.grey,
  );
  const person = Icon(
    Icons.person,
    color: Colors.black,
    size: 48,
  );
  if(url.isEmpty){
    return person;
  }
  return CachedNetworkImage(
    imageUrl:  url,
    imageBuilder: (context, imageProvider) {
                    return Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                         image: imageProvider,
                         fit: BoxFit.fill,
                        ),
                       ));
                     },
    fit: BoxFit.fill,
    placeholder: (context, child, ) {
      print("profile placholder-------------------");
        return loading;
    },
    errorWidget: (context, error, stackTrace) {
      return person;
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              buttonTitle: page ,
              uid: request.uid,
            ),
          ),

        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: _getProfileImage(request.url),
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
                                  request.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: primaryTextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            request.phoneNo,
                            style: const TextStyle(
                              color: primaryTextColor,
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
      ),
    );
  }
}
