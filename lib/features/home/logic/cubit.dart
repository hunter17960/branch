import 'package:branch/features/home/data/models/branch.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(AppInitial());

  Size designSize = const Size(843, 1197);
  Size designSizePortrait = const Size(843, 1197);
  Size designSizeLandscape = const Size(1600, 747);
  static HomeCubit get(context) => BlocProvider.of(context);
  final TextEditingController customNoController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController arabicDescriptionController =
      TextEditingController();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController englishDescriptionController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  List<Branch> branches = [];
  int currentIndex = 0;

  setBranchControllers() {
    if (branches.isNotEmpty) {
      customNoController.text = branches[currentIndex].customNo.toString();
      arabicNameController.text = branches[currentIndex].arabicName;
      arabicDescriptionController.text =
          branches[currentIndex].arabicDescription;
      englishNameController.text = branches[currentIndex].englishName;
      englishDescriptionController.text =
          branches[currentIndex].englishDescription;
      noteController.text = branches[currentIndex].note;
      addressController.text = branches[currentIndex].address;
    }
  }

  void getDesignSize({required Orientation orientation}) {
    if (orientation == Orientation.landscape ||
        orientation == Orientation.portrait) {
      // Toggle design size based on orientation
      if ((orientation == Orientation.landscape &&
              designSize != designSizeLandscape) ||
          (orientation == Orientation.portrait &&
              designSize != designSizePortrait)) {
        designSize = designSize == designSizePortrait
            ? designSizeLandscape
            : designSizePortrait;
        emit(DesignSizeChanged());
        print("${designSize.width} /// ${designSize.height}");
      }
    }
  }

  void changeIndex(int index) {
    if (branches.length - 1 >= index && index >= 0) {
      currentIndex = index;
      setBranchControllers();
      emit(AppChangeBottomNavBar());
    }
  }

  void getBranches() {
    emit(GetBranchesLoading());
    branches = [];
    FirebaseFirestore.instance
        .collection('branches')
        .orderBy('branch id')
        .get()
        .then((value) {
      for (var element in value.docs) {
        Branch branch = Branch.fromJson(element.data());
        branch.docId = element.id;
        branches.add(branch);
      }
      setBranchControllers();
      emit(GetBranchesSuccess());
    }).catchError((error) {
      emit(GetBranchesError());
    });
  }

  void addBranch() async {
    emit(AddBranchLoading());
    Branch branch = Branch.empty();
    int latestBranchId = await _fetchLastBranchId();
    branch.branchId = latestBranchId + 1;
    FirebaseFirestore.instance
        .collection('branches')
        .add(branch.toJson())
        .then((value) {
      emit(AddBranchSuccess());
    }).catchError((error) {
      emit(AddBranchError());
    });
  }

  void updateBranch() async {
    Branch newBranch = Branch(
      branchId: branches[currentIndex].branchId,
      customNo: int.parse(customNoController.text),
      arabicName: arabicNameController.text,
      arabicDescription: arabicDescriptionController.text,
      englishName: englishNameController.text,
      englishDescription: englishDescriptionController.text,
      note: noteController.text,
      address: addressController.text,
    );
    newBranch.docId = branches[currentIndex].docId;
    emit(UpdateBranchLoading());
    FirebaseFirestore.instance
        .collection('branches')
        .doc(newBranch.docId)
        .update(newBranch.toJson())
        .then((value) {
      emit(UpdateBranchSuccess());
    }).catchError((error) {
      emit(UpdateBranchError());
    });
  }
}

Future<int> _fetchLastBranchId() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('branches')
      .orderBy('branch id', descending: true)
      .limit(1)
      .get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first['branch id'];
  } else {
    return -1;
  }
}
