import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeRepository {
  final CoreRepository _repository;

  HomeRepository(this._repository);

  Future<UserData> getUserData()async{
    return await _repository.getUserData();
  }

  Future<bool> checkActiveStatus() async {
    return await _repository.checkActiveStatus();
  }

  Future<String> getWebUrl() async {
    final db = FirebaseDatabase.instance;
    final data = await db.ref().child("MetaData").child('webURL').get();
    if(data.exists){
      return data.value.toString();
    }
    throw Exception("Web URL not found");
  }
}