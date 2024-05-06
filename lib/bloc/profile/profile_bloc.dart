import 'package:attach_club/bloc/profile/profile_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:attach_club/models/review.dart';
import 'package:attach_club/models/social_link.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<SocialLink> socialLinksList = [];
  List<Product> productList = [];
  int rating = 0;
  int reviewCount = 0;
  String? uid;
  DateTime? lastUpdated;
  UserData userData = UserData(username: "");
  List<Review> reviewsList = [];
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<GetUserData>((event, emit) async {
      if(event.uid!=null){
        await _repository.incrementProfileCount(event.uid!);
      }
      userData = await _repository.getUserData(event.uid);
      socialLinksList = await _repository.getSocialLinksList(event.uid);
      productList = await _repository.getAllProducts(event.uid);
      reviewsList = await _repository.getReviewsList(event.uid);
      reviewCount = reviewsList.length;
      rating = _calculateRating(reviewsList);
      lastUpdated = DateTime.now();
      if(event.uid==null){
        emit(UserDataUpdated(userData));
        emit(ProfileInitial());
      }else{
        emit(const OtherUserDataUpdated());
        emit(ProfileInitial());
      }
      lastUpdated = DateTime.now();
      uid = event.uid;
      await _repository.downloadImageOfProducts(
        list: productList,
        onListUpdated: (list) {
          productList = list;
          if(event.uid==null){
            emit(UserDataUpdated(userData));
            emit(ProfileInitial());
          }else{
            emit(const OtherUserDataUpdated());
            emit(ProfileInitial());
          }
        },
        uid: event.uid,
      );
    });
    on<ReviewSubmitted>((event, emit) async {
      final review = Review(
        feedback: event.feedback,
        review: event.selectedStars,
        name: event.userData.name,
        mobileNo: event.userData.phoneNo,
      );
      await _repository.addReview(review, event.profileUid);
    });
  }

  int _calculateRating(List<Review> list) {
    if(list.isEmpty){
      return 0;
    }
    int sum = 0;
    for (var i in list) {
      sum += i.review;
    }
    double ans = sum / list.length;
    return int.parse(ans.toStringAsFixed(0));
  }
}
