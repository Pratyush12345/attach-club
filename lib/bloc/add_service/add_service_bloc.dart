import 'dart:developer';

import 'package:attach_club/bloc/add_service/add_service_repository.dart';
import 'package:attach_club/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../models/user_data.dart';

part 'add_service_event.dart';

part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  List<Product> list = [];
  DateTime? lastUpdated;

  final AddServiceRepository _repository;

  AddServiceBloc(this._repository) : super(AddServiceInitial()) {
    on<ProductAdded>((event, emit) async {
      try {
        if(event.userData.accountType=="normal" && list.length>=3){
          emit(const ShowSnackBar("Please Upgrade Plan to add more products"));
          return emit(NavigateToBuyPlan());
        }
        emit(ShowLoading());
        final product = await _repository.addProduct(event.product);
        list.add(product);
        lastUpdated = DateTime.now();
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(AddServiceInitial());
      }
    });
    on<EditProduct>((event, emit) async {
      try {
        emit(ShowLoading());
        // await _repository.deleteProduct(event.oldProduct);
        final newProduct = await _repository.editProduct(event.newProduct);
        list.remove(event.oldProduct);
        list.add(newProduct);
        lastUpdated = DateTime.now();
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(AddServiceInitial());
      }
    });
    on<DeleteProduct>((event, emit) async {
      try {
        emit(ShowLoading());
        list.remove(event.product);
        await _repository.deleteProduct(event.product);
        lastUpdated = DateTime.now();
        emit(ListUpdated());
        emit(AddServiceInitial());
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(AddServiceInitial());
      }
    });
    on<FetchAllProducts>((event, emit) async {
      try {
        emit(ShowLoading());
        list = await _repository.getAllProducts();
        lastUpdated = DateTime.now();
        emit(ListUpdated());
        emit(AddServiceInitial());
        // await _repository.downloadImageOfProducts(
        //   list: list,
        //   onListUpdated: (newList) {
        //     list = newList;
        //     emit(ListUpdated());
        //     emit(AddServiceInitial());
        //   },
        // );
      } on Exception catch (e) {
        emit(ShowSnackBar(e.toString()));
        emit(AddServiceInitial());
      }
    });
  }
}
