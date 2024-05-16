import 'package:attach_club/constants.dart';
import 'package:attach_club/core/components/rating.dart';
import 'package:attach_club/core/repository/user_data_notifier.dart';
import 'package:attach_club/views/detailed_analytics/analytics_card.dart';
import 'package:attach_club/views/detailed_analytics/long_analytic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedAnalytics extends StatefulWidget {
  const DetailedAnalytics({super.key});

  @override
  State<DetailedAnalytics> createState() => _DetailedAnalyticsState();
}

class _DetailedAnalyticsState extends State<DetailedAnalytics> {
  @override
  Widget build(BuildContext context) {
    final userData = context.read<UserDataNotifier>().userData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Detailed Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: horizontalPadding),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnalyticsCard(
                    title: "Connections",
                    number: "200",
                    numberColor: Colors.yellow,
                    assetPath: "assets/svg/connections_analytics_vector.svg",
                  ),
                  AnalyticsCard(
                    title: "Profile Clicks",
                    number: "200",
                    assetPath: "assets/svg/profile_analytics_vector.svg",
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const LongAnalyticCard(
                title: "Your ratings",
                number: 4,
              ),
              const SizedBox(height: 16),
              const LongAnalyticCard(
                title: "Reviews",
                number: 4,
              ),
              const SizedBox(height: 24),
              const Text(
                "My Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Rating(selected: 3),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.withOpacity(0.2),
                                    ),
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                text: TextSpan(
                                  text: lorem,
                                  style: TextStyle(
                                    color: paragraphTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
