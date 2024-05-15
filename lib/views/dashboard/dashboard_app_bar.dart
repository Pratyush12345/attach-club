import 'package:attach_club/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/repository/user_data_notifier.dart';

AppBar getDashboardAppBar(BuildContext context, double height) {
  final top = MediaQuery.of(context).viewInsets.top;
  final userData = context.read<UserDataNotifier>().userData;
  return AppBar(
    toolbarHeight: top + 0.080083691 * height,
    flexibleSpace: Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 0.080083691 * height,
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: _getProfileImage(userData.profileImageURL),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: primaryTextColor,
                      ),
                    ),
                    const Text(
                      "Good morning!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: primaryTextColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 48,
                child: SvgPicture.asset(
                  "assets/svg/bell.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const Icon(Icons.qr_code),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/qr');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_getProfileImage(String url) {
  const person = Icon(
    Icons.person,
    color: Colors.black,
    size: 48,
  );
  if(url.isEmpty){
    return person;
  }
  return Image.network(
    url,
    fit: BoxFit.fill,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return person;
      }
    },
    errorBuilder: (context, error, stackTrace) {
      return person;
    },
  );
}
