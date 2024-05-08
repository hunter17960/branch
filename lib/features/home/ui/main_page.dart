import 'package:branch/core/helpers/spacing.dart';
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
      final width = MediaQuery.of(context).size.width;
      final orientation = MediaQuery.of(context).orientation;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Branch /Store /Cashier',
            style: TextStyles.font25WhiteMedium,
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
        bottomNavigationBar: SizedBox(
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          physics: const BouncingScrollPhysics(),
          child: width > 850 || orientation == Orientation.landscape
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Branch',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  isClickable: false,
                                  controller: TextEditingController(
                                      text: cubit.branches.isNotEmpty
                                          ? cubit.branches[cubit.currentIndex]
                                              .branchId
                                              .toString()
                                          : '0'),
                                  type: TextInputType.number,
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
                              Text(
                                'Custom No.',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  controller: cubit.customNoController,
                                  type: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Arabic Name',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  textAlign: TextAlign.right,
                                  controller: cubit.arabicNameController,
                                  type: TextInputType.name,
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
                              Text(
                                'Arabic Description',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  textAlign: TextAlign.right,
                                  controller: cubit.arabicDescriptionController,
                                  type: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'English Name',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  controller: cubit.englishNameController,
                                  type: TextInputType.name,
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
                              Text(
                                'English Description',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 65.h,
                                width: 220.w,
                                child: defaultFormField(
                                  controller:
                                      cubit.englishDescriptionController,
                                  type: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Note',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 130.h,
                                width: 220.w,
                                child: defaultFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: cubit.noteController,
                                  type: TextInputType.name,
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
                              Text(
                                'Address',
                                style: TextStyles.font12BlackMedium,
                              ),
                              SizedBox(
                                height: 130.h,
                                width: 220.w,
                                child: defaultFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: cubit.addressController,
                                  type: TextInputType.name,
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
                                style: TextStyles.font22BlackMedium,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: SizedBox(
                                  height: 65.h,
                                  child: defaultFormField(
                                    isClickable: false,
                                    controller: TextEditingController(
                                        text: cubit.branches.isNotEmpty
                                            ? cubit.branches[cubit.currentIndex]
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
                        horizontalSpace(30),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom No.',
                                style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'Arabic Name',
                      style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'Arabic Description',
                      style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'English Name',
                      style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'English Description',
                      style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'Note',
                      style: TextStyles.font22BlackMedium,
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
                    verticalSpace(30),
                    Text(
                      'Address',
                      style: TextStyles.font22BlackMedium,
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
      );
    });
  }
}
