import 'package:attach_club/core/repository/core_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddServiceRepository {
  final CoreRepository _repository;

  AddServiceRepository(this._repository);

  Future<Product> uploadProduct(Product product, bool overwriteAllowed) async {
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
      if (doc.exists) {
        throw Exception("This product title already exists");
      }
    }

    final imageRef = storageRef
        .child("users/${currentUser.uid}/products/${product.title}/image.jpg");
    await imageRef.putFile(product.image!);
    final url = await imageRef.getDownloadURL();
    product.imageUrl = url;
    final check = await db
        .collection("users")
        .doc(currentUser.uid)
        .collection("products")
        .doc(product.title)
        .set(product.toMap());
    return product;
  }

  Future<Product> addProduct(Product product) async {
    return await uploadProduct(product, false);
  }

  Future<Product> editProduct(Product product) async {
    return await uploadProduct(product, true);
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
    await storageRef
        .child("users/${currentUser.uid}/products/${product.title}/image.jpg")
        .delete();
  }

  Future<List<Product>> getAllProducts() async {
    return await _repository.getAllProducts();
  }

  Future<void> downloadImageOfProducts({
    required List<Product> list,
    required void Function(List<Product>) onListUpdated,
  }) async {
    return await _repository.downloadImageOfProducts(
      list: list,
      onListUpdated: onListUpdated,
    );
  }
}
