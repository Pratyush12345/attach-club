import 'dart:convert';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/user_data.dart';
import 'package:http/http.dart';

class SearchConnectionsRepository {
  final CoreRepository _repository;
  final Client client;

  SearchConnectionsRepository(this._repository, this.client);

  Future<List<UserData>> getSearchResult(String query) async {
    final user = _repository.getCurrentUser();
    final url =
        "https://us-central1-attach-club.cloudfunctions.net/restApis/searchUser?searchText=${query}&uid=${user.uid}";
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<UserData> list = [];
      for (var i in data.entries) {
        list.add(UserData.fromMap(map: i.value, uid: i.key));
      }
      return list;
    }
    throw Exception("Failed to load data");
  }
}
