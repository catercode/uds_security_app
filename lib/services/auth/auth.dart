import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either<String, UserModel>> login(
      {required String sid, required String password}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: sid)
          .where('password', isEqualTo: password)
          .get();
      final data = querySnapshot.docs;

      if (data.isNotEmpty) {
        final user =
            UserModel.fromJson(data.first.data() as Map<String, dynamic>);

        return Right(user);
      } else {
        return const Left("Invalid Credentials");
      }
    } catch (e) {
      log("Failed to login: $e");
      return const Left("Please check your internet connection");
      // TODO
    }
  }

  Future<bool> logout() async {
    return true;
  }

  Future<Either<String?, bool>> register({required UserModel user}) async {
    try {
      await _firestore.collection("users").add({
        "userId": user.userId,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "phone": user.phone,
        "email": user.email,
        "role": user.role,
        "address": user.address,
        "date": DateTime.now().toString(),
        "status": "Active",
        "hostile": user.hostile,
        "department": user.department,
        "faculty": user.faculty,
        "middleName": user.middleName,
        "password": user.password
      });
      return const Right(true);
    } catch (e) {
      log("Failed to create user: $e");
      return const Left("Failed to create user");
      // TODO
    }
  }

  Future<Either<String, bool>> updateGuard({
    required String userid,
    required String unit,
  }) async {
    try {
      log("8------------- : $userid");
      await _firestore
          .collection('users')
          .doc(userid)
          .update({'unitAssigned': unit});

      return const Right(true);
    } catch (e) {
      log("Failed to update password : $e");
      return const Right(false);
    }
  }

  Future<Either<String, bool>> resetPassword({
    required String userid,
    required String password,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userid)
          .update({'password': password});
      log("Password updated successfully");
      return const Right(true);
    } catch (e) {
      log("Failed to update password : $e");
      return const Right(false);
    }
  }

  Future<Either<String, String>> verifyEmail({required String email}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      final data = querySnapshot.docs;

      if (data.isNotEmpty) {
        log("====data==${data.first.id}");
        final userid = data.first.id;

        return Right(userid);
      } else {
        final userid = data.first.id;
        return Right(userid);
      }
    } catch (e) {
      log("====Error==$e");
      return const Left("");
    }
  }
}
