part of 'detailed_analytics_bloc.dart';

sealed class DetailedAnalyticsEvent extends Equatable {
  const DetailedAnalyticsEvent();
}

class GetData extends DetailedAnalyticsEvent {
  const GetData();

  @override
  List<Object> get props => [];
}
