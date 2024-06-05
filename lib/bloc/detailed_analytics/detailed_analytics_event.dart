part of 'detailed_analytics_bloc.dart';

sealed class DetailedAnalyticsEvent extends Equatable {
  const DetailedAnalyticsEvent();
}

class GetData extends DetailedAnalyticsEvent {
  const GetData();

  @override
  List<Object> get props => [];
}

class DeleteReview extends DetailedAnalyticsEvent {
  final int index;
  const DeleteReview(this.index);

  @override
  List<Object> get props => [index];
}