import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePrivacyRepository {
  final CoreRepository _repository;

  ProfilePrivacyRepository(this._repository);

  Future<void> updateValue(String key, bool value) async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db.collection("users").doc(currentUser.uid).update({key: value});
  }

  Future<void> updateBasicDetails(bool value) async {
    await updateValue("isBasicDetailEnabled", value);
  }

  Future<void> updateSocialLink(bool value) async {
    await updateValue("isLinkEnabled", value);
  }

  Future<void> updateProduct(bool value) async {
    await updateValue("isProductEnabled", value);
  }

  Future<void> updateReview(bool value) async {
    await updateValue("isReviewEnabled", value);
  }
  
  Future<UserData> fetchAllStatus()async{
    final currentUser = _repository.getCurrentUser();

    final db = FirebaseFirestore.instance;
    final data = await db.collection("users").doc(currentUser.uid).get();
    if(data.exists){
      final userData = UserData.fromMap(map: data.data()!);
      return userData;
    }
    throw Exception("Data not found");
  }


  
}
