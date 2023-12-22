import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../commons/common_widgets/show_toast.dart';
import '../../../models/user_model.dart';
import '../../../routes/route_manager.dart';
import '../data/auth_apis/auth_apis.dart';
import '../data/auth_apis/database_apis.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

final userStateStreamProvider = StreamProvider((ref) {
  final authProvider = ref.watch(authControllerProvider.notifier);
  return authProvider.getSigninStatusOfUser();
});

final currentUserAuthProvider = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.currentUser();
});
final currentUserModelData = FutureProvider((ref) {
  final authCtr = ref.watch(authControllerProvider.notifier);
  return authCtr.getCurrentUserInfo();
});

final fetchUserByIdProvider = StreamProvider.family((ref, String uid) {
  final profileController = ref.watch(authControllerProvider.notifier);
  return profileController.getUserInfoByUid(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  AuthController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<User?> currentUser() async {
    return _authApis.getCurrentUser();
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.registerWithEmailPassword(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {

      UserModel model = UserModel(
          uid: r.uid,
          name: email.split('@')[0],
          email: email,
          createdAt: DateTime.now()
      );
      final result2 = await _databaseApis.saveUserInfo(userModel: model);
      result2.fold((l) {
        state = false;
        showToast(msg: l.message);
      }, (r) async {
        state = false;
        Navigator.pushNamed(context, AppRoutes.signInScreen);
        showToast(msg: 'Account Created Successfully!');
      });
    });
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.signInWithEmailAndPass(
        email: email, password: password);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      Navigator.pushNamed(context, AppRoutes.mainMenuScreen);
      state = false;
    });
  }


  Future<UserModel> getCurrentUserInfo() async {
    final userId = await _authApis.getCurrentUser();
    final result = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<UserModel> getUserInfoByUidFuture(String uid) async {
    final result = await _databaseApis.getCurrentUserInfo(uid:  uid);
    UserModel userModel =
    UserModel.fromMap(result.data() as Map<String, dynamic>);
    return userModel;
  }

  Stream<UserModel> getUserInfoByUid(String userId) {
    return _databaseApis.getUserInfoByUid(userId);
  }

  // LogOut User
  Future<void> logout({
    required BuildContext context,
  }) async {
    state = true;
    final result = await _authApis.logout();
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.signInScreen, (route) => false);
    });
  }



  Stream<User?> getSigninStatusOfUser() {
    return _authApis.getSigninStatusOfUser();
  }
}

