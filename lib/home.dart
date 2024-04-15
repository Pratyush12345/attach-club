import 'package:attach_club/constants.dart';
import 'package:attach_club/models/nav_tab_data.dart';
import 'package:attach_club/views/connections/connections.dart';
import 'package:attach_club/views/dashboard/dashboard.dart';
import 'package:attach_club/views/fire/fire.dart';
import 'package:attach_club/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
          centerTitle: false,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nishant Singh",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                "Good morning!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              )
            ],
          ),
          leadingWidth: 72,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const ClipOval(
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 48,
                ),
              ),
            ),
          ),
          actions: [
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
            const Padding(
              padding: EdgeInsets.only(right: 11.0),
              child: SizedBox(
                width: 48,
                child: Icon(
                  Icons.qr_code,
                  size: 24,
                ),
              ),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(24),
            child: SizedBox(
              height: 24,
            ),
          ),
      ),
    ),
    NavTabData(
      label: "Fire",
      assetName: "assets/svg/fire.svg",
      child: const Fire(),
      appBar: AppBar(
        title: const Text(
          "Fire",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    ),
    NavTabData(
      label: "Connections",
      assetName: "assets/svg/chat_bubble_left_right.svg",
      child: const Connections(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF26293B),
        title: const Text(
          "Connections",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    ),
    NavTabData(
      label: "Settings",
      assetName: "assets/svg/settings_6_tooth.svg",
      child: const Settings(),
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ];
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  late Animation<double> maxWidthAnimation;

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

    controller.addListener(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    maxWidthAnimation = Tween<double>(
      begin: 52,
      end: width - (2 * horizontalPadding) - ((tabs.length - 1) * (52)),
    ).animate(controller);

    return Scaffold(
      appBar: tabs[_selectedIndex].appBar,
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
    );
  }
}
