import 'dart:io';
import 'package:attach_club/core/repository/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImageRepository {
  final CoreRepository _repository;

  ProfileImageRepository(this._repository);

  Future<String> _uploadPhoto(String name, File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final currentUser = _repository.getCurrentUser();

    final profilePhotoRef =
        storageRef.child("users/${currentUser.uid}/$name.jpg");
    await profilePhotoRef.putFile(file);
    final url = await profilePhotoRef.getDownloadURL();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .update({"${name}URL": url});
    return url;
  }

  Future<String> uploadProfilePhoto(File file) async {
    return await _uploadPhoto("profileImage", file);
  }

  Future<String> uploadBanner(File file) async {
    return await _uploadPhoto("bannerImage", file);
  }

  Future<bool> checkIfImageExists(String name) async {
    final userData = await _repository.getUserData();
    if (name == "bannerImage" && userData.bannerImageURL.isNotEmpty) {
      return true;
    }
    if (name == "profileImage" && userData.profileImageURL.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<File?> _downloadImage(String name) async {
    if (await checkIfImageExists(name)) {
      final storageRef = FirebaseStorage.instance.ref();
      final currentUser = _repository.getCurrentUser();

      final profilePhotoRef =
          storageRef.child("users/${currentUser.uid}/$name.jpg");
      final appDocDir = await getApplicationCacheDirectory();
      final directory = Directory("${appDocDir.path}/images/");
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      final filePath = "${appDocDir.path}/images/$name.jpg";
      final file = File(filePath);

      await profilePhotoRef.writeToFile(file);
      return file;
    } else {
      return null;
    }
  }

  Future<String> getProfileImage() async {
    // return await _downloadImage("profileImage");
    final userData = await _repository.getUserData();
    return userData.profileImageURL;
  }

  Future<String> getBannerImage() async {
    // return await _downloadImage("bannerImage");
    final userData = await _repository.getUserData();
    return userData.bannerImageURL;
  }

  Future<void> deleteProfileImage() async {
    final db = FirebaseFirestore.instance;
    final currentUser = _repository.getCurrentUser();
    await db.collection("users").doc(currentUser.uid).update({"profileImageURL": ""});
  }

  Future<void> deleteBannerImage() async {
    final db = FirebaseFirestore.instance;
    final currentUser = _repository.getCurrentUser();
    await db.collection("users").doc(currentUser.uid).update({"bannerImageURL": ""});
  }
}