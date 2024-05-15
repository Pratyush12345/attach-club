part of 'add_service_bloc.dart';

abstract class AddServiceState extends Equatable {
  const AddServiceState();
}

class AddServiceInitial extends AddServiceState {
  @override
  List<Object> get props => [];
}

class ListUpdated extends AddServiceState {
  @override
  List<Object?> get props => [];
}

class AddToList extends AddServiceState {
  final Product product;

  const AddToList(this.product);

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

class ShowSnackBar extends AddServiceState {
  final String message;

  const ShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}

class ShowLoading extends AddServiceState {
  @override
  List<Object?> get props => [];
}