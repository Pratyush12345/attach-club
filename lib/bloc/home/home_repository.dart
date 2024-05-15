import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';

class HomeRepository {
  final CoreRepository _repository;

  HomeRepository(this._repository);

  Future<UserData> getUserData()async{
    return await _repository.getUserData();
  }
}