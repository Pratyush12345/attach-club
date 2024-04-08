part of 'add_service_bloc.dart';

abstract class AddServiceState extends Equatable {
  const AddServiceState();
}

class OnBoard4Initial extends AddServiceState {
  @override
  List<Object> get props => [];
}

class AddToList extends AddServiceState {
  final Product product;

  AddToList(this.product);

  @override
  List<Object?> get props => [product];
}

class EditList extends AddServiceState {
  final Product oldProduct;
  final Product newProduct;

  const EditList({required this.oldProduct, required this.newProduct});

  @override
  List<Object?> get props => [oldProduct, newProduct];
}

class DeleteFromList extends AddServiceState {
  final Product product;

  const DeleteFromList(this.product);

  @override
  List<Object?> get props => [product];
}