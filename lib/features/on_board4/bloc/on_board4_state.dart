part of 'on_board4_bloc.dart';

abstract class OnBoard4State extends Equatable {
  const OnBoard4State();
}

class OnBoard4Initial extends OnBoard4State {
  @override
  List<Object> get props => [];
}

class AddToList extends OnBoard4State {
  final Product product;

  AddToList(this.product);

  @override
  List<Object?> get props => [product];
}

class EditList extends OnBoard4State {
  final Product oldProduct;
  final Product newProduct;

  const EditList({required this.oldProduct, required this.newProduct});

  @override
  List<Object?> get props => [oldProduct, newProduct];
}

class DeleteFromList extends OnBoard4State {
  final Product product;

  const DeleteFromList(this.product);

  @override
  List<Object?> get props => [product];
}