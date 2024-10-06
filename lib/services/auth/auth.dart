import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, UserModel>> login({
    required String sid,
    required String password,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: sid)
          .where('password', isEqualTo: password)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isEmpty) {
        return const Left("Invalid Credentials");
      }

      // Get the first matching document data
      final staffData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      log("----login--------$staffData");
      final userModel = UserModel(
        id: querySnapshot.docs.first.id,
        firstName: staffData['firstName'],
        middleName: staffData['middleName'],
        lastName: staffData['lastName'],
        phone: staffData['phone'],
        email: staffData['email'],
        role: staffData['role'],
        department: staffData['department'],
        faculty: staffData['faculty'],
        address: staffData['address'],
        hostile: staffData['hostile'],
        date: staffData['date'],
        status: staffData['status'],
        gender: staffData['gender'],
        userId: staffData['userId'],
        password: staffData['password'],
        rank: staffData['rank'],
        unitAssigned: staffData['unitAssigned'],
      );

      return Right(userModel);
    } catch (e) {
      log("Failed to login: $e");
      return const Left(
          "Please check your internet connection or try again later");
    }
  }

  Future<bool> logout() async {
    return true;
  }

  Future<Either<String?, bool>> register({required UserModel user}) async {
    try {
     await _firestore.collection("users").add({
        "userId": user.userId ?? "",
        "firstName": user.firstName ?? "",
        "lastName": user.lastName ?? "",
        "phone": user.phone ?? "",
        "email": user.email ?? "",
        "role": user.role ?? "",
        "address": user.address ?? "",
        "unitId": user.unitId ?? "",
        "date": DateTime.now().toString(),
        "status": "Active",
        "hostile": user.hostile ?? "",
        "department": user.department ?? "",
        "faculty": user.faculty ?? "",
        "gender": user.gender ?? "",
        "middleName": user.middleName ?? "",
        "password": user.password,
        "rank": user.rank ?? "",
        "unitAssigned": "Not Assigned",
      });
      log("Guard created successfully");
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
