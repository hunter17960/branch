import 'package:branch/features/home/data/models/branch.dart';
import 'package:branch/features/home/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(AppInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Branch> branches = [];
  int currentIndex = 0;
  void changeIndex(int index) {
    if (branches.length - 1 >= index && index >= 0) {
      currentIndex = index;
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
      emit(GetBranchesSuccess());
    }).catchError((error) {
      emit(GetBranchesError());
    });
  }

  void addBranch({
    required Branch branch,
  }) async {
    emit(AddBranchLoading());
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

  void updateBranch({
    required Branch branch,
  }) async {
    emit(UpdateBranchLoading());
    FirebaseFirestore.instance
        .collection('branches')
        .doc(branch.docId)
        .update(branch.toJson())
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
    // If no branches exist yet, return -1 as the last branch ID
    return -1;
  }
}
