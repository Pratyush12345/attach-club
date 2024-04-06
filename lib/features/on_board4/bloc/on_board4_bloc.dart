import 'package:attach_club/features/on_board4/data/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_board4_event.dart';

part 'on_board4_state.dart';

class OnBoard4Bloc extends Bloc<OnBoard4Event, OnBoard4State> {
  OnBoard4Bloc() : super(OnBoard4Initial()) {
    on<ProductAdded>((event, emit) {
      emit(AddToList(event.product));
    });
    on<EditProduct>((event, emit) {
      emit(
        EditList(
          oldProduct: event.oldProduct,
          newProduct: event.newProduct,
        ),
      );
    });
    on<DeleteProduct>((event, emit) {
      emit(DeleteFromList(event.product));
    });
  }
}
