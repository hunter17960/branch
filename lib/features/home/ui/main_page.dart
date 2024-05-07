import 'package:branch/core/helpers/spacing.dart';
import 'package:branch/core/themes/styles.dart';
import 'package:branch/core/widgets/components.dart';
import 'package:branch/features/home/data/models/branch.dart';
import 'package:branch/features/home/logic/cubit.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final TextEditingController customNoController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController arabicDescriptionController =
      TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController englishDescriptionController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (HomeCubit.get(context).branches.isNotEmpty) {
      customNoController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .customNo
          .toString();
      arabicNameController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .arabicName;
      arabicDescriptionController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .arabicDescription;
      englishNameController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .englishName;
      englishDescriptionController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .englishDescription;
      noteController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .note;
      addressController.text = HomeCubit.get(context)
          .branches[HomeCubit.get(context).currentIndex]
          .address;
    }
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
                cubit.addBranch(branch: Branch.empty());
              },
              icon: const Icon(Icons.add_circle),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                Branch newBranch = Branch(
                  branchId: cubit.branches[cubit.currentIndex].branchId,
                  customNo: int.parse(customNoController.text),
                  arabicName: arabicNameController.text,
                  arabicDescription: arabicDescriptionController.text,
                  englishName: englishNameController.text,
                  englishDescription: englishDescriptionController.text,
                  note: noteController.text,
                  address: addressController.text,
                );
                newBranch.docId = cubit.branches[cubit.currentIndex].docId;
                cubit.updateBranch(branch: newBranch);
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
                                  controller: customNoController,
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
                                  controller: arabicNameController,
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
                                  controller: arabicDescriptionController,
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
                                  controller: englishNameController,
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
                                  controller: englishDescriptionController,
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
                                  controller: noteController,
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
                                  controller: addressController,
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
                                    controller: customNoController,
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
                          controller: arabicNameController,
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
                          controller: arabicDescriptionController,
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
                          controller: englishNameController,
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
                          controller: englishDescriptionController,
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
                          controller: noteController,
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
                          controller: addressController,
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
