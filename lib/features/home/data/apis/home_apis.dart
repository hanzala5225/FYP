import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rental_app/features/home/data/models/home_category_model.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_providers/global_providers.dart';
import '../../../../core/constants/firebase_constants.dart';


final homeApis = Provider<HomeApis>((ref) {
  final firestoreProvider = ref.watch(firebaseDatabaseProvider);
  return HomeApis(firestore: firestoreProvider);
});


abstract class IHomeApis {
  FutureEitherVoid uploadCategories({required HomeCategoryModel homeCategoryModel});
  Stream<QuerySnapshot>  fetchAllCategories();
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllItems();
  Stream<QuerySnapshot<Map<String, dynamic>>> getSearchedItems() ;
}

class HomeApis implements IHomeApis {
  FirebaseFirestore _firestore;
  HomeApis({required FirebaseFirestore firestore}) : _firestore = firestore;


  @override
  FutureEitherVoid uploadCategories({required HomeCategoryModel homeCategoryModel})async {
    try{
      await _firestore.collection(FirebaseConstants.categoriesCollection).
      doc(homeCategoryModel.categoryId).
      set(homeCategoryModel.toMap());

      return Right(null);
    }on FirebaseException catch(e, stackTrace){
      return Left(Failure(e.message ?? 'Firebase Error Occurred', stackTrace));
    }catch (e, stackTrace){
      return Left(Failure(e.toString(), stackTrace));
    }
  }


  @override
  Stream<QuerySnapshot> fetchAllCategories(){
    return _firestore.collection(FirebaseConstants.categoriesCollection).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllItems(){
    return _firestore.collection(FirebaseConstants.categoriesCollection).
    snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getSearchedItems() {
    return _firestore
        .collection(FirebaseConstants.categoriesCollection).
        // orderBy("itemPrice", descending: true).
        // orderBy("rating", descending: descendingRating).
        snapshots();
  }
}
