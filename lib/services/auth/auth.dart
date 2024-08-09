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
        "password": user.password
      });
      return const Right(true);
    } catch (e) {
      log("Failed to create user: $e");
      return const Left("Failed to create user");
      // TODO
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    try {
      await _firestore
          .collection('users')
          .doc(email)
          .update({'password': password});
      return true;
    } catch (e) {
      // TODO
      return true;
    }
  }
}
