import 'dart:math';
import 'package:attach_club/bloc/connections/connections_bloc.dart'as cbloc;
import 'package:attach_club/bloc/dashboard/dashboard_bloc.dart';
import 'package:attach_club/bloc/greetings/greetings_bloc.dart'  as gbloc;
import 'package:attach_club/bloc/home/home_bloc.dart';
import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/button.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/models/globalVariable.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:attach_club/views/dashboard/link_card.dart';
import 'package:attach_club/views/social_greeting/greeting_card.dart';
import 'package:attach_club/views/social_greeting/greeting_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    final userData = context.read<UserDataNotifier>().userData;
    context.read<DashboardBloc>().add(GetData(userData));
    context.read<gbloc.GreetingsBloc>().add(const gbloc.GetGreetings());
    context.read<cbloc.ConnectionsBloc>().add(cbloc.FetchConnections());
  }

  @override
  Widget build(BuildContext context) {
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
      },
      builder: (context, state) {
        if (state is DashboardLoading && !GlobalVariable.isDashboardBuildOnce ) {
          GlobalVariable.isDashboardBuildOnce = true;
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        }
        final bloc = context.read<DashboardBloc>();
        return RefreshIndicator(
          onRefresh: () async{
             context.read<HomeBloc>().add(GetUserData());
             final userData = context.read<UserDataNotifier>().userData;
             context.read<DashboardBloc>().add(GetData(userData));
             return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: SingleChildScrollView(
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
                      child: Image.network(GlobalVariable.metaData.appBannerLink!, fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              ),
                            );
                          }
                        }, errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                        "assets/images/dashboard.png",
                        fit: BoxFit.cover,
                        );
                        }
                        )

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 16,
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
                          onTap: () {},
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
                        if (bloc.suggestedProfile[i].uid != null)
                          ProfileCard(
                            name: bloc.suggestedProfile[i].name,
                            description: bloc.suggestedProfile[i].description,
                            asset: bloc.suggestedProfile[i].profileImageURL,
                            selected: 3,
                            uid: bloc.suggestedProfile[i].uid!,
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
                GreetingDashboard( imagelink:  context.read<gbloc.GreetingsBloc>().filteredList.isEmpty? "link" : context.read<gbloc.GreetingsBloc>().filteredList[0].templates[0].link),
                const SizedBox(height: paddingDueToNav)
              ],
            ),
          ),
        );
      },
    );
  }
}
