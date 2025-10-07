import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/services_data/domain/usecases/seller_usecase.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_event.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_state.dart';

class SellerInfoBloc extends Bloc<SellerInfoEvent, SellerInfoState> {
  final GetSellerUsecase _getSellerUsecase;
  final AddUpdateSellerUsecase _addUpdateSellerUsecase;
  SellerInfoBloc(
      {required GetSellerUsecase getSellerUsecase,
      required AddUpdateSellerUsecase addUpdateSellerUsecase})
      : _getSellerUsecase = getSellerUsecase,
        _addUpdateSellerUsecase = addUpdateSellerUsecase,
        super(SellerInitial()) {
    on<GetSellerInfoEvent>(_onGetSeller);
    on<AddUpdateSellerInfoEvent>(_onAddEditSeller);
  }

  Future<void> _onGetSeller(
      GetSellerInfoEvent event, Emitter<SellerInfoState> emit) async {
    try {
      emit(SellerLoading());
      final response = await _getSellerUsecase(event.id);
      response.fold(
        (failure) => emit(SellerFailure(failure.exception)),
        (success) => emit(GetSellerInfoSuccess(success)),
      );
    } catch (e) {
      emit(SellerFailure(e.toString()));
    }
  }

  Future<void> _onAddEditSeller(
      AddUpdateSellerInfoEvent event, Emitter<SellerInfoState> emit) async {
    try {
      emit(SellerLoading());
      final response = await _addUpdateSellerUsecase(event.model);
      response.fold(
        (failure) => emit(SellerFailure(failure.exception)),
        (success) => emit(AddUpdateSellerInfoSuccess(success)),
      );
    } catch (e) {
      emit(SellerFailure(e.toString()));
    }
  }
}
