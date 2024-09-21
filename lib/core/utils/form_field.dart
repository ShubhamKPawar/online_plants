import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';

InputDecoration formFieldDecoration({
  String? labelText,
  Widget? label,
  bool isEdit = true,
  String? hinText,
  String? suffixText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? prefixText,
}) {
  return InputDecoration(
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      isDense: false,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      fillColor: AppColor.skGreenColor.withOpacity(isEdit ? 0.2 : 0.03),
      filled: true,
      hintText: hinText,
      labelStyle: const TextStyle(
        color: AppColor.skGreenColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelText: labelText,
      label: label,
      prefixIcon: prefixIcon,
      prefixText: prefixText,
      prefixStyle: const TextStyle(
        color: AppColor.skGreenColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: AppColor.skGreenColor,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      suffixStyle: const TextStyle(
        color: AppColor.skGreenColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      suffixIconColor: AppColor.skGreenColor,
      hintStyle: const TextStyle(
        color: AppColor.skGreenColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        fontSize: 9,
      ));
}
