import 'package:attach_club/core/repository/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detailed_analytics_event.dart';
part 'detailed_analytics_state.dart';

class DetailedAnalyticsBloc extends Bloc<DetailedAnalyticsEvent, DetailedAnalyticsState> {
  final CoreRepository coreRepository;
  DetailedAnalyticsBloc(this.coreRepository) : super(DetailedAnalyticsInitial()) {
    on<GetData>((event, emit) {
      final user = coreRepository.getCurrentUser();
      final db = FirebaseFirestore.instance;
      // db.collection("users").doc(user.uid).collection("")
    });
  }
}
