part of 'on_board4_bloc.dart';

abstract class OnBoard4Event extends Equatable {
  const OnBoard4Event();
}

class ProductAdded extends OnBoard4Event {
  final Product product;

  ProductAdded(this.product);

  @override
  List<Object?> get props => [];
}

class EditProduct extends OnBoard4Event {
  final Product oldProduct;
  final Product newProduct;

  const EditProduct({required this.oldProduct, required this.newProduct});

  @override
  List<Object?> get props => [oldProduct, newProduct];
}

class DeleteProduct extends OnBoard4Event {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object?> get props => [product];
}
