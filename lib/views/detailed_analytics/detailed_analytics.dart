import 'dart:math';

import 'package:attach_club/bloc/detailed_analytics/detailed_analytics_bloc.dart';
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
  void initState() {
    super.initState();
    context.read<DetailedAnalyticsBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Detailed Analytics'),
      ),
      body: BlocBuilder<DetailedAnalyticsBloc, DetailedAnalyticsState>(
        builder: (context, state) {
          if (state is DetailedAnalyticsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = context.read<UserDataNotifier>().userData;
          final bloc = context.read<DetailedAnalyticsBloc>();
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: horizontalPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnalyticsCard(
                        title: "Connections",
                        number: bloc.connections.toString(),
                        numberColor: Colors.yellow,
                        assetPath:
                            "assets/svg/connections_analytics_vector.svg",
                      ),
                      AnalyticsCard(
                        title: "Profile Clicks",
                        number: userData.profileClickCount.toString(),
                        assetPath: "assets/svg/profile_analytics_vector.svg",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LongAnalyticCard(
                    title: "Your ratings",
                    number: "${bloc.rating} Star",
                  ),
                  const SizedBox(height: 16),
                  LongAnalyticCard(
                    title: "Reviews",
                    number: bloc.reviews.length.toString(),
                  ),
                  const SizedBox(height: 24),
                  if (bloc.reviews.isNotEmpty)
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
                      itemCount: min(5, bloc.reviews.length),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bloc.reviews[index].name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Rating(
                                              selected:
                                                  bloc.reviews[index].review),
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
                                      text: bloc.reviews[index].feedback,
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
          );
        },
      ),
    );
  }
}
