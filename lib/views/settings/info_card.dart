import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userData = context.read<UserDataNotifier>().userData;
    return Padding(
      padding: EdgeInsets.only(top: 0.0268 * height),
      child: SizedBox(
        width: 0.888372093 * width,
        // height: 0.1030042918 * height,
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(
              left: 0.04186 * width,
              top: 0.01716 * height,
              bottom: 0.01716 * height,
            ),
            child: Row(
              children: [
                Container(
                  width: 0.1488372093 * width,
                  height: 0.1488372093 * width,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                      child: _getProfileImage(userData.profileImageURL),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                      Text(
                        //TODO: Not visible
                        userData.phoneNo,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryTextColor,
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
  }

  Widget _getProfileImage(String profileImageURL) {
    const person = Icon(
      Icons.person,
      size: 64,
      color: Colors.black,
    );
    if(profileImageURL.isEmpty){
      return person;
    }
    return Image.network(profileImageURL, fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return person;
      }
    }, errorBuilder: (context, error, stackTrace) {
      return person;
    });
  }
}
