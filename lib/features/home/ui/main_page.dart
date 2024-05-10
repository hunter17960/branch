import 'package:branch/core/helpers/spacing.dart';
import 'package:branch/core/helpers/text_scale_factor.dart';
import 'package:branch/core/themes/styles.dart';
import 'package:branch/core/widgets/components.dart';
import 'package:branch/features/home/logic/cubit.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is AddBranchSuccess || state is UpdateBranchSuccess) {
        HomeCubit.get(context).getBranches();
      }
    }, builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      final orientation = MediaQuery.of(context).orientation;
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Branch /Store /Cashier',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                cubit.addBranch();
              },
              icon: const Icon(Icons.add_circle),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                cubit.updateBranch();
              },
              icon: const Icon(Icons.save_rounded),
            ),
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                cubit.changeIndex(0);
              },
              icon: const Icon(
                Icons.keyboard_double_arrow_left_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.changeIndex(cubit.currentIndex - 1);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
              ),
            ),
            Text("${cubit.currentIndex + 1}/${cubit.branches.length}"),
            IconButton(
              onPressed: () {
                cubit.changeIndex(cubit.currentIndex + 1);
              },
              icon: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.changeIndex(cubit.branches.length - 1);
              },
              icon: const Icon(
                Icons.keyboard_double_arrow_right_rounded,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            child: orientation == Orientation.landscape
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Branch',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      isClickable: false,
                                      controller: TextEditingController(
                                          text: cubit.branches.isNotEmpty
                                              ? cubit
                                                  .branches[cubit.currentIndex]
                                                  .branchId
                                                  .toString()
                                              : '0'),
                                      type: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Custom No.',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      controller: cubit.customNoController,
                                      type: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Arabic Name',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      textAlign: TextAlign.right,
                                      controller: cubit.arabicNameController,
                                      type: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Arabic Description',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      textAlign: TextAlign.right,
                                      controller:
                                          cubit.arabicDescriptionController,
                                      type: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'English Name',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      controller: cubit.englishNameController,
                                      type: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'English Description',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 30.h,
                                    child: defaultFormField(
                                      controller:
                                          cubit.englishDescriptionController,
                                      type: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Note',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 80.h,
                                    child: defaultFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: cubit.noteController,
                                      type: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Address',
                                    style: TextStyles.font22BlackRegular,
                                    textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactorLandscape(
                                          context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 80.h,
                                    child: defaultFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: cubit.addressController,
                                      type: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Branch',
                                  style: TextStyles.font25BlackRegular,
                                  textScaler: TextScaler.linear(
                                    ScaleSize.textScaleFactorPortrait(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: defaultFormField(
                                      isClickable: false,
                                      controller: TextEditingController(
                                          text: cubit.branches.isNotEmpty
                                              ? cubit
                                                  .branches[cubit.currentIndex]
                                                  .branchId
                                                  .toString()
                                              : '0'),
                                      type: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(20),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Custom No.',
                                  style: TextStyles.font25BlackRegular,
                                  textScaler: TextScaler.linear(
                                    ScaleSize.textScaleFactorPortrait(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: SizedBox(
                                    height: 65.h,
                                    child: defaultFormField(
                                      controller: cubit.customNoController,
                                      type: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      Text(
                        'Arabic Name',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 65.h,
                          child: defaultFormField(
                            textAlign: TextAlign.right,
                            controller: cubit.arabicNameController,
                            type: TextInputType.name,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'Arabic Description',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 65.h,
                          child: defaultFormField(
                            textAlign: TextAlign.right,
                            controller: cubit.arabicDescriptionController,
                            type: TextInputType.name,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'English Name',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 65.h,
                          child: defaultFormField(
                            controller: cubit.englishNameController,
                            type: TextInputType.name,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'English Description',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 65.h,
                          child: defaultFormField(
                            controller: cubit.englishDescriptionController,
                            type: TextInputType.name,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'Note',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 130.h,
                          child: defaultFormField(
                            expands: true,
                            maxLines: null,
                            controller: cubit.noteController,
                            type: TextInputType.multiline,
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        'Address',
                        style: TextStyles.font25BlackRegular,
                        textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactorPortrait(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: SizedBox(
                          height: 130.h,
                          child: defaultFormField(
                            expands: true,
                            maxLines: null,
                            controller: cubit.addressController,
                            type: TextInputType.multiline,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
