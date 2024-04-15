import 'dart:developer';
import 'dart:io';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImageRepository {
  final CoreRepository _repository;

  ProfileImageRepository(this._repository);
  Future<void> _uploadPhoto(String name, File file) async {
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
  }

  Future<void> uploadProfilePhoto(File file) async {
    await _uploadPhoto("profileImage", file);
  }

  Future<void> uploadBanner(File file) async {
    await _uploadPhoto("bannerImage", file);
  }


  Future<File> _downloadImage(String name) async {
    final storageRef = FirebaseStorage.instance.ref();
    final currentUser = _repository.getCurrentUser();

    final profilePhotoRef =
    storageRef.child("users/${currentUser.uid}/$name.jpg");
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.path}/images/$name.jpg";
    final file = File(filePath);

    await profilePhotoRef.writeToFile(file);
    return file;
  }

  Future<File> getProfileImage() async {
    return await _downloadImage("profileImage");
  }

  Future<File> getBannerImage() async {
    return await _downloadImage("bannerImage");
  }

}
