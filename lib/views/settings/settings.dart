import 'package:attach_club/constants.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/views/settings/info_card.dart';
import 'package:attach_club/views/settings/other_pages.dart';
import 'package:attach_club/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  final controller = TextEditingController();
  
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
     scrollController.removeListener(_scrollListener);
     scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       scrollController.addListener(_scrollListener);
    });
    super.initState();
  }

  void _scrollListener() {

    if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
       animationController.reverse();
      });
    } else if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
       animationController.forward();
      });
     }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Consumer<ChangeSettingScreenProvider>(
                  builder: (context, model, child) {
                    print("builddddddd");
                    return InfoCard();
                  }
                ),
              ),
              SizedBox(
                height: 0.02575 * height,
              ),
              const OtherPages(),
              const SizedBox(
                height: paddingDueToNav,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
