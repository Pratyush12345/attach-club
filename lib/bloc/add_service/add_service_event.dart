part of 'add_service_bloc.dart';

abstract class AddServiceEvent extends Equatable {
  const AddServiceEvent();
}

class ProductAdded extends AddServiceEvent {
  final Product product;
  final UserData userData;

  const ProductAdded(this.product, this.userData);

  @override
  List<Object?> get props => [];
}

class EditProduct extends AddServiceEvent {
  final Product oldProduct;
  final Product newProduct;

  const EditProduct({required this.oldProduct, required this.newProduct});

  @override
  List<Object?> get props => [oldProduct, newProduct];
}

class DeleteProduct extends AddServiceEvent {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class FetchAllProducts extends AddServiceEvent {
  @override
  List<Object?> get props => [];
}
