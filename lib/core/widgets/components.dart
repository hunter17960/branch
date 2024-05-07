import 'package:branch/core/themes/colors.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  final FormFieldValidator<String>? validator,
  String? label,
  int? minLines,
  int? maxLines,
  bool isClickable = true,
  bool? expands,
}) =>
    TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      expands: expands ?? false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.lightGray,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.lightGray,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.lightGray,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.mainBlue,
          ),
        ),
      ),
    );
