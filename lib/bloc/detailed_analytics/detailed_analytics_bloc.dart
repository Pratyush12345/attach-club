import 'package:attach_club/bloc/detailed_analytics/detailed_analytics_repository.dart';
import 'package:attach_club/models/review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detailed_analytics_event.dart';
part 'detailed_analytics_state.dart';

class DetailedAnalyticsBloc extends Bloc<DetailedAnalyticsEvent, DetailedAnalyticsState> {
  final DetailedAnalyticsRepository _repository;
  int connections = 0;
  List<Review> reviews = [];
  int rating = 0;
  DetailedAnalyticsBloc(this._repository) : super(DetailedAnalyticsInitial()) {
    on<GetData>((event, emit) async {
      emit(DetailedAnalyticsLoading());
      connections = await _repository.getConnections();
      reviews = await _repository.getReviews();
      if(reviews.length==0){
        rating = 0;
      }
      else {
        double ans = 0;
        for (int i = 0; i < reviews.length; i++) {
          ans += reviews[i].review;
        }
        rating = (ans / reviews.length).round();
      }
      emit(DetailedAnalyticsLoaded());
    });
  }
}
