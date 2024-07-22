import 'dart:math';
import 'package:attach_club/bloc/connections/connections_bloc.dart' as cbloc;
import 'package:attach_club/bloc/dashboard/dashboard_bloc.dart';
import 'package:attach_club/bloc/greetings/greetings_bloc.dart' as gbloc;
import 'package:attach_club/bloc/home/home_bloc.dart';
import 'package:attach_club/bloc/search_connections/Search_provider.dart';
import 'package:attach_club/bloc/search_connections/search_connections_bloc.dart' as searchbloc;
import 'package:attach_club/bloc/profile/profile_bloc.dart' as profileBloc;
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/home.dart';
import 'package:attach_club/main.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/dashboard/dashboard_app_bar.dart';
import 'package:attach_club/views/dashboard/dashboard_shimmer.dart';
import 'package:attach_club/views/dashboard/link_card.dart';
import 'package:attach_club/views/settings/settings_provider.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:attach_club/views/social_greeting/greeting_dashboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'profile_card.dart';

class Dashboard extends StatefulWidget {
  // static const analyticsData = [
  //   {
  //     "no": "200",
  //     "title": "Connections",
  //   },
  //   {
  //     "no": "187",
  //     "title": "Profile Clicks",
  //   },
  //   {
  //     "no": "287",
  //     "title": "Enquiries",
  //   }
  // ];
  static const connectData = [
    {
      "asset": "assets/svg/share-whatsapp.svg",
      "title": "Share your profile on whatsapp",
    },
    {
      "asset": "assets/svg/otherPlatforms.svg",
      "title": "Share on other platforms",
    }
  ];

  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  ScrollController scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  void initState() {
    print("-----------------dashboard initalized---------------");
    super.initState();
    final userData = context.read<UserDataNotifier>().userData;
    context.read<DashboardBloc>().add(GetData(userData));
    context.read<gbloc.GreetingsBloc>().add(const gbloc.GetGreetings());
    context.read<cbloc.ConnectionsBloc>().add(cbloc.FetchConnections());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       scrollController.addListener(_scrollListener);
       Future.delayed(const Duration(milliseconds: 4000),(){
      initFirestore();  
       Provider.of<ChangeSettingScreenProvider>(context, listen: false).changeSettingScreenIndex("Settings");
       } );
      
    });
    context
        .read<profileBloc.ProfileBloc>()
        .add(const profileBloc.GetUserData());
      
  }
  
  initFirestore(){
    _firestore.collection('users').doc('${GlobalVariable.userData.uid}').snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          if(context.read<UserDataNotifier>().userData.accountType != snapshot.data()?['accountType']){
          context.read<UserDataNotifier>().userData.accountType = snapshot.data()?['accountType'];
          print(context.read<UserDataNotifier>().userData.accountType);
          }
        });
      }
    });  
  }

  @override
  void dispose() {
    super.dispose();
     scrollController.removeListener(_scrollListener);
     scrollController.dispose();

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is ShowSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if(state is GreetingsCountIncremented){
          final temp = context.read<UserDataNotifier>();
          final userData = temp.userData;
          userData.greetingsCount = 1;
          temp.updateUserData(userData);
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading && !GlobalVariable.isDashboardBuildOnce) {
          GlobalVariable.isDashboardBuildOnce = true;
          return const DashboardShimmer();
        }
        final bloc = context.read<DashboardBloc>();
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(GetUserData());
            final userData = context.read<UserDataNotifier>().userData;
            context.read<DashboardBloc>().add(GetData(userData));
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.02575107296 * height),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 0.160944206 * height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GlobalVariable.metaData.appBannerLink! == ""?  Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              ) : CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ));
                          },
                          imageUrl: GlobalVariable.metaData.appBannerLink!,
                          errorWidget: (context, error, stackTrace) {
                            return Image.asset(
                            "assets/images/dashboard.png",
                            fit: BoxFit.fill,
                            );
                          },
                          fit: BoxFit.fill,
                            placeholder : (context, url) {
                              return Shimmer.fromColors(
                                direction: ShimmerDirection.ltr,
                                  baseColor:  Colors.grey[800]!,
                                  highlightColor: Colors.grey[600]!,

                                child: Container(
                                  color: Colors.white,
                                ),
                              );

                          } ,
                         ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.02575107296 * height),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Text(
                      "Analytics",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01931330472 * height),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 16,
                      children: [
                        // for (var i in analyticsData)
                        const SizedBox(
                          width: horizontalPadding - 16,
                        ),
                        LinkCard(
                          grp: "ANALYTICS",
                          prefix: Text(
                            bloc.connectionsCount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          title: "Connections",
                        ),
                        LinkCard(
                          grp: "ANALYTICS",
                          prefix: Text(
                            context
                                .read<UserDataNotifier>()
                                .userData
                                .profileViewCount
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          title: "Profile Clicks",
                        ),
                        LinkCard(
                          grp: "ANALYTICS",
                          prefix: Text(
                            bloc.reviewCount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          title: "Review",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.02575107296 * height),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Text(
                      "Connect with people",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01931330472 * height),
                  Padding(
                    padding: const EdgeInsets.only(
                     left: horizontalPadding, right: horizontalPadding
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i in Dashboard.connectData)
                          LinkCard(
                            grp: "CONNECTED USER",
                            prefix: SvgPicture.asset(
                              i["asset"]!,
                              width: 30,
                              height: 30,
                            ),
                            title: i["title"] ?? "title",
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.02575107296 * height),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Suggested Profiles",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        if (bloc.suggestedProfile.length > 5)
                          GestureDetector(
                            onTap: () {
                             Provider.of<ChangeScreenProvider>(context, listen: false).changeScreenIndex(1);
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF4285F4),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.01716738197 * height),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 12,
                      children: [
                        const SizedBox(width: horizontalPadding - 12),
                        for (var i = 0;
                            i < min(5, bloc.suggestedProfile.length);
                            i++)
                          if (bloc.suggestedProfile[i].userData.uid != null)
                            ProfileCard(
                              accountType: bloc.suggestedProfile[i].userData.accountType ,
                              name: bloc.suggestedProfile[i].userData.name,
                              description: bloc.suggestedProfile[i].userData.description,
                              asset: bloc.suggestedProfile[i].userData.profileImageURL,
                              selected: 3,
                              uid: bloc.suggestedProfile[i].userData.uid!,
                            ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.02575107296 * height),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Social Greetings",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: primaryTextColor,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFB743),
                              borderRadius: BorderRadius.circular(15)),
                          height: 30,
                          width: 0.2209302326 * width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/premium.png",
                                width: 12,
                                height: 12,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Premium",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryTextColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 0.01716738197 * height),
                  GreetingDashboard( imagelink:  context.read<gbloc.GreetingsBloc>().filteredList.isEmpty? "link" : context.read<gbloc.GreetingsBloc>().filteredList[0].templates[0].link, 
                  fileName :context.read<gbloc.GreetingsBloc>().filteredList.isEmpty? "greeting" : context.read<gbloc.GreetingsBloc>().filteredList[0].templates[0].name
                  ),
                  const SizedBox(height: paddingDueToNav)
                ],
              ),
            ),

        );
      },
    );
  }
}
