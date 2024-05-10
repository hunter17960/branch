import 'package:branch/core/themes/colors.dart';
import 'package:branch/core/themes/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font25WhiteMedium = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeightHelper.medium,
    color: Colors.white,
  );
  static TextStyle font22BlackRegular = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.black,
  );
  static TextStyle font25BlackRegular = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.black,
  );
}
