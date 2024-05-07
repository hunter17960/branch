import 'package:branch/core/widgets/components.dart';
import 'package:branch/features/home/data/models/branch.dart';
import 'package:branch/features/home/logic/cubit.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:branch/core/helpers/spacing.dart';
import 'package:branch/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageMobile extends StatelessWidget {
  MainPageMobile({super.key});
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
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddBranchSuccess || state is UpdateBranchSuccess) {
          HomeCubit.get(context).getBranches();
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (cubit.branches.isNotEmpty) {
          customNoController.text =
              cubit.branches[cubit.currentIndex].customNo.toString();
          arabicNameController.text =
              cubit.branches[cubit.currentIndex].arabicName;
          arabicDescriptionController.text =
              cubit.branches[cubit.currentIndex].arabicDescription;
          englishNameController.text =
              cubit.branches[cubit.currentIndex].englishName;
          englishDescriptionController.text =
              cubit.branches[cubit.currentIndex].englishDescription;
          noteController.text = cubit.branches[cubit.currentIndex].note;
          addressController.text = cubit.branches[cubit.currentIndex].address;
        }
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
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
                            verticalSpace(20),
                            SizedBox(
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
                            verticalSpace(20),
                            SizedBox(
                              height: 65.h,
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
                  Text(
                    'Arabic Name',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 65.h,
                    child: defaultFormField(
                      controller: arabicNameController,
                      type: TextInputType.name,
                    ),
                  ),
                  verticalSpace(30),
                  Text(
                    'Arabic Description',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 65.h,
                    child: defaultFormField(
                      controller: arabicDescriptionController,
                      type: TextInputType.name,
                    ),
                  ),
                  verticalSpace(30),
                  Text(
                    'English Name',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 65.h,
                    child: defaultFormField(
                      controller: englishNameController,
                      type: TextInputType.name,
                    ),
                  ),
                  verticalSpace(30),
                  Text(
                    'English Description',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 65.h,
                    child: defaultFormField(
                      controller: englishDescriptionController,
                      type: TextInputType.name,
                    ),
                  ),
                  verticalSpace(30),
                  Text(
                    'Note',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 130.h,
                    child: defaultFormField(
                      expands: true,
                      maxLines: null,
                      controller: noteController,
                      type: TextInputType.multiline,
                    ),
                  ),
                  verticalSpace(30),
                  Text(
                    'Address',
                    style: TextStyles.font22BlackMedium,
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 130.h,
                    child: defaultFormField(
                      expands: true,
                      maxLines: null,
                      controller: addressController,
                      type: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
