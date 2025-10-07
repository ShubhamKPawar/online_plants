import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/hive_data/product_color.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_event.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_state.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductImageBloc extends Bloc<ProductImageEvent, ProductImageState> {
  final HivePref hivePref;
  ProductImageBloc(this.hivePref) : super(InitState()) {
    on<UpgrageImageBackgroundEvent>(_upgradeSingleImageBg);
    on<UpgrageImageBackgroundListEvent>(_upgrageMultipleImageBg);
    on<AddProductColorEvent>(_addProductColor);
    on<GetListProductColorEvent>(_getProductColorList);
    on<GetProductColorEvent>(_getProductColor);
    on<AddMultipleProductColorEvent>(_addMultipleProductColor);
    on<RemoveAllProductColorEvent>(_removeAllProductColor);
    on<RemoveSingleProductColorEvent>(_removeSingleProductColor);
  }

  Future<void> _upgradeSingleImageBg(UpgrageImageBackgroundEvent event,
      Emitter<ProductImageState> emit) async {
    try {
      ProductColor color =
          await _upgrageImageBackground(event.imageProvider, event.imageUrl);
      add(AddProductColorEvent(color: color));
    } catch (e, stack) {
      print(
          '_upgrageMultipleImageBg error ${e.toString()} .. ${stack.toString()}');
      emit(FailureState());
    }
  }

  Future<void> _upgrageMultipleImageBg(UpgrageImageBackgroundListEvent event,
      Emitter<ProductImageState> emit) async {
    try {
      List<ProductColor> productColorList = [];
      if (event.imageProviderList.length == event.imageUrlList.length) {
        for (int index = 0; index < event.imageProviderList.length; index++) {
          ProductColor color = await _upgrageImageBackground(
              event.imageProviderList[index], event.imageUrlList[index]);
          productColorList.add(color);
        }
        add(AddMultipleProductColorEvent(colors: productColorList));
      }
    } catch (e, stack) {
      print(
          '_upgrageMultipleImageBg error ${e.toString()} .. ${stack.toString()}');
      emit(FailureState());
    }
  }

  Future<ProductColor> _upgrageImageBackground(
      ImageProvider<Object> imageProvider, String imageUrl) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    Color? dominantColor =
        paletteGenerator.dominantColor?.color ?? AppColor.skBlack;

    // Convert to HSLColor to adjust lightness
    final hslColor = HSLColor.fromColor(dominantColor);

    // If the color is very light (close to white), make it a bit darker
    Color adjustedColor = (hslColor.lightness > 0.8)
        ? const Color(0xFFEEEEEE) // Darken if light
        : dominantColor.withOpacity(0.6); // Use default opacity otherwise
    ProductColor model =
        ProductColor(url: imageUrl, color: adjustedColor.value);
    return model;
  }

  Future<void> _addProductColor(
      AddProductColorEvent event, Emitter<ProductImageState> emit) async {
    try {
      ProductColor color = event.color;
      await hivePref.addProductColor(color);
      emit(AddProductColorState());
    } catch (e, stack) {
      print('_addProductColor errr ${e.toString()} .. ${stack.toString()}');
      emit(FailureAddProductState());
    }
  }

  Future<void> _getProductColorList(
      GetListProductColorEvent event, Emitter<ProductImageState> emit) async {
    try {
      List<ProductColor> productColorList =
          await hivePref.getAllProductColors();
      Map<String, int> colorMap = {
        for (var product in productColorList)
          product.url ?? 'color': product.color ?? 0
      };
      emit(GetListProductColorState(colorsMap: colorMap));
    } catch (e, stack) {
      print('_getProductColorList errr ${e.toString()} .. ${stack.toString()}');
      emit(FailureGetListProductState());
    }
  }

  Future<void> _getProductColor(
      GetProductColorEvent event, Emitter<ProductImageState> emit) async {
    try {
      String url = event.url;
      ProductColor? productColor = await hivePref.getProudctColor(url: url);
      print('get value : ${productColor?.url} ${productColor?.color}');
      emit(GetProductColorState(
          color: productColor?.color ?? const Color(0xff2b2b2b).value));
    } catch (e, stack) {
      print('_getProductColor errr ${e.toString()} .. ${stack.toString()}');
      emit(FailureGetProductState());
    }
  }

  Future<void> _addMultipleProductColor(AddMultipleProductColorEvent event,
      Emitter<ProductImageState> emit) async {
    try {
      await hivePref.addMultipleProductColor(event.colors);
      emit(AddMultipleProductColorState());
    } catch (e, stack) {
      print(
          '_addMultipleProductColor error ${e.toString()} .. ${stack.toString()}');
      emit(FailureAddMultipleProductState());
    }
  }

  Future<void> _removeAllProductColor(
      RemoveAllProductColorEvent event, Emitter<ProductImageState> emit) async {
    try {
      await hivePref.removeAllProductColor();
      emit(RemoveAllProductColorState());
    } catch (e, stack) {
      print(
          '_removeAllProductColor error ${e.toString()} .. ${stack.toString()}');
      emit(FailureRemoveAllProductState());
    }
  }

  Future<void> _removeSingleProductColor(RemoveSingleProductColorEvent event,
      Emitter<ProductImageState> emit) async {
    try {
      await hivePref.removeProductColor(url: event.url);
      emit(RemoveSingleProductColorState());
    } catch (e, stack) {
      print(
          '_removeSingleProductColor error ${e.toString()} .. ${stack.toString()}');
      emit(FailureRemoveSingleProductState());
    }
  }
}
