import 'package:attach_club/bloc/home/home_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/nav_tab_data.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/connections/connections.dart';
import 'package:attach_club/views/connections/connections_app_bar.dart';
import 'package:attach_club/views/dashboard/dashboard.dart';
import 'package:attach_club/views/dashboard/dashboard_app_bar.dart';
import 'package:attach_club/views/search_connections/search_connections.dart';
import 'package:attach_club/views/settings/settings.dart';
import 'package:attach_club/views/settings/settings_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'views/search_connections/search_connections_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final tabs = <NavTabData>[
    NavTabData(
      label: "Home",
      assetName: "assets/svg/home.svg",
      child: const Dashboard(),
      appBar: getDashboardAppBar,
    ),
    NavTabData(
      label: "Search",
      assetName: "assets/svg/fire.svg",
      child: const SearchConnections(),
      appBar: getSearchConnectionsAppBar,
    ),
    NavTabData(
      label: "Connections",
      assetName: "assets/svg/chat_bubble_left_right.svg",
      child: const Connections(),
      appBar: getConnectionsAppBar,
    ),
    NavTabData(
      label: "Settings",
      assetName: "assets/svg/settings_6_tooth.svg",
      child: const SettingsPage(),
      appBar: getSettingsAppBar,
    ),
  ];
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  late Animation<double> maxWidthAnimation;
  UserData userData = UserData(
    username: '',
    firstLoginDate: Timestamp.now(),
    lastLoginDate: Timestamp.now(),
    lastPaymentDate: Timestamp.now(),
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    offsetAnimation = Tween<Offset>(
      begin: const Offset(-10, 0),
      end: const Offset(0, 0),
    ).animate(controller);
    controller.forward();
    context.read<HomeBloc>().add(GetUserData());

    final notifier = context.read<UserDataNotifier>();
    notifier.addListener(() {
      if (!mounted) return;
      setState(() {
        final notifier = context.read<UserDataNotifier>();
        userData = notifier.userData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    //remove notifier listener
    // context.read<UserDataNotifier>().removeListener(_handleUserDataChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    maxWidthAnimation = Tween<double>(
      begin: 52,
      end: width - (2 * horizontalPadding) - ((tabs.length - 1) * (52)),
    ).animate(controller);

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is UserDataUpdated) {
          context.read<UserDataNotifier>().updateUserData(state.userData);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: tabs[_selectedIndex].appBar(context, height),
        // appBar: getAppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: tabs[_selectedIndex].child,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: Container(
                    width: width - (2 * horizontalPadding),
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D4CF9),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: AnimatedBuilder(
                      animation: maxWidthAnimation,
                      builder: (context, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var i = 0; i < tabs.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = i;
                                    controller.reset();
                                    controller.forward();
                                  });
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: (i == _selectedIndex)
                                        ? Colors.black.withOpacity(0.34)
                                        : Colors.transparent,
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: maxWidthAnimation.value,
                                    minWidth: 52,
                                  ),
                                  height: 36,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      SvgPicture.asset(
                                        tabs[i].assetName,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        width: 24,
                                        height: 24,
                                      ),
                                      if (i == _selectedIndex)
                                        const SizedBox(width: 4),
                                      if (i == _selectedIndex)
                                        Flexible(
                                          child: Transform.translate(
                                            offset: offsetAnimation.value,
                                            child: Text(
                                              tabs[i].label,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
