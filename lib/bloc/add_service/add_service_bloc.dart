import 'package:attach_club/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_service_event.dart';

part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(OnBoard4Initial()) {
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
