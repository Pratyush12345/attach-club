part of 'on_board4_bloc.dart';

abstract class OnBoard4Event extends Equatable {
  const OnBoard4Event();
}

class ProductAdded extends OnBoard4Event{
  final Product product;

  ProductAdded(this.product);

  @override
  List<Object?> get props => [];
}