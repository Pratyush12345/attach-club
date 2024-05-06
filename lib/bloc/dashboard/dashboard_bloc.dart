import 'dart:io';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final CoreRepository _coreRepository;
  int connectionsCount = 0;
  int reviewCount = 0;

  DashboardBloc(this._coreRepository) : super(DashboardInitial()) {
    on<GetData>((event, emit) async {
      final user = _coreRepository.getCurrentUser();
      final db = FirebaseFirestore.instance;
      final docs = await db
          .collection("users")
          .doc(user.uid)
          .collection("requests")
          .get();
      int count = 0;
      for (var i in docs.docs) {
        if (i.exists && i.data()["status"] == "Connected") {
          count++;
        }
      }
      connectionsCount = count;

      final reviewDocs =
          await db.collection("users").doc(user.uid).collection("review").get();
      reviewCount = reviewDocs.size;
      emit(DataUpdated());
      emit(DashboardInitial());
    });
    on<SendWhatsappMessage>((event, emit) async {
      try {
        var androidUrl = "whatsapp://send?phone=${event.phoneNo}&text=Hi, I need some help";
        var iosUrl = "https://wa.me/${event.phoneNo}?text=${Uri.parse('Hi, I need some help')}";
        if(Platform.isIOS){
          await launchUrl(Uri.parse(iosUrl));
        } else {
          await launchUrl(Uri.parse(androidUrl));
        }
      } on Exception catch (e) {
        emit(const ShowSnackBar("Error launching whatsapp"));
        emit(DashboardInitial());
      }
    });
  }
}
