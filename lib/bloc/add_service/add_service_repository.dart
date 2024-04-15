import 'dart:io';

import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class AddServiceRepository {
  final CoreRepository _repository;

  AddServiceRepository(this._repository);

  Future<void> uploadProduct(Product product, bool overwriteAllowed) async {
    final currentUser = _repository.getCurrentUser();
    final storageRef = FirebaseStorage.instance.ref();
    final db = FirebaseFirestore.instance;

    if (!overwriteAllowed) {
      final doc = await db
          .collection("users")
          .doc(currentUser.uid)
          .collection("products")
          .doc(product.title)
          .get();
      if(doc.exists){
        throw Exception("This product title already exists");
      }
    }

    final imageRef = storageRef
        .child("users/${currentUser.uid}/products/${product.title}/image.jpg");
    await imageRef.putFile(product.image);
    final url = await imageRef.getDownloadURL();
    final check = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("products")
        .doc(product.title)
        .set(product.toMap(url));
  }

  Future<void> addProduct(Product product) async {
    await uploadProduct(product, false);
  }

  Future<void> editProduct(Product product) async {
    await uploadProduct(product, true);
  }

  Future<void> deleteProduct(Product product) async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("products")
        .doc(product.title)
        .delete();
    final storageRef = FirebaseStorage.instance.ref();
    await storageRef.child(
        "users/${currentUser.uid}/products/${product.title}/image.jpg").delete();
  }

  Future<List<Product>> getAllProducts() async {
    final currentUser = _repository.getCurrentUser();
    final db = FirebaseFirestore.instance;
    final storageRef = FirebaseStorage.instance.ref();
    final data = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("products")
        .get();
    final list = <Product>[];
    for (var i in data.docs) {
      if (i.exists) {
        final map = i.data();
        final imageRef = storageRef.child(
            "users/${currentUser.uid}/products/${map["title"]}/image.jpg");
        final appDocDir = await getApplicationDocumentsDirectory();
        final directory = Directory("${appDocDir.path}/images/products/${map["title"]}/");
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
        final filePath =
            "${appDocDir.path}/images/products/${map["title"]}/image.jpg";
        final file = File(filePath);
        await imageRef.writeToFile(file);
        list.add(Product.fromMap(
          map: map,
          image: file,
          docId: i.id,
        ));
      }
    }
    return list;
  }
}
