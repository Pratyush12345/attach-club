import 'dart:developer';

import 'package:attach_club/bloc/add_service/add_service_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_service_event.dart';

part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  List<Product> list = [];

  final AddServiceRepository _repository;

  AddServiceBloc(this._repository) : super(AddServiceInitial()) {
    on<ProductAdded>((event, emit)async {
      try {
        await _repository.addProduct(event.product);
        list.add(event.product);
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<EditProduct>((event, emit) async {
      try {
        list.remove(event.oldProduct);
        list.add(event.newProduct);
        await _repository.deleteProduct(event.oldProduct);
        await _repository.editProduct(event.newProduct);
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<DeleteProduct>((event, emit)async {
      try {
        list.remove(event.product);
        await _repository.deleteProduct(event.product);
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
    on<FetchAllProducts>((event, emit)async {
      try {
        final List<Product> newList = await  _repository.getAllProducts();
        list = newList;
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
      }
    });
  }
}
