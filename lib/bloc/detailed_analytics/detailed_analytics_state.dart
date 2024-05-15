part of 'detailed_analytics_bloc.dart';

sealed class DetailedAnalyticsState extends Equatable {
  const DetailedAnalyticsState();
}

final class DetailedAnalyticsInitial extends DetailedAnalyticsState {
  @override
  List<Object> get props => [];
}
