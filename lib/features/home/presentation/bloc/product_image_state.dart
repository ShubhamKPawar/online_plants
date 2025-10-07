abstract class ProductImageState {}

final class InitState extends ProductImageState {}

final class AddProductColorState extends ProductImageState {
  AddProductColorState();
}

final class FailureState extends ProductImageState {}

final class FailureAddProductState extends ProductImageState {}

final class GetListProductColorState extends ProductImageState {
  Map<String, int> colorsMap;
  GetListProductColorState({required this.colorsMap});
}

final class FailureGetListProductState extends ProductImageState {}

final class GetProductColorState extends ProductImageState {
  int color;
  GetProductColorState({required this.color});
}

final class FailureGetProductState extends ProductImageState {}

final class AddMultipleProductColorState extends ProductImageState {
  AddMultipleProductColorState();
}

final class FailureAddMultipleProductState extends ProductImageState {}

final class RemoveAllProductColorState extends ProductImageState {}

final class FailureRemoveAllProductState extends ProductImageState {}

final class RemoveSingleProductColorState extends ProductImageState {
  RemoveSingleProductColorState();
}

final class FailureRemoveSingleProductState extends ProductImageState {}
