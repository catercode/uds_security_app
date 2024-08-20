import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class StaffServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<Either<String, UserModel>> login(
  //     {required String sid, required String password}) async {
  //   try {
  //     final QuerySnapshot querySnapshot = await _firestore
  //         .collection('users')
  //         .where('userId', isEqualTo: sid)
  //         .where('password', isEqualTo: password)
  //         .get();
  //     final data = querySnapshot.docs;

  //     if (data.isNotEmpty) {
  //       final user =
  //           UserModel.fromJson(data.first.data() as Map<String, dynamic>);

  //       return Right(user);
  //     } else {
  //       return const Left("Invalid Credentials");
  //     }
  //   } catch (e) {
  //     log("Failed to login: $e");
  //     return const Left("Please check your internet connection");
  //     // TODO
  //   }
  // }

  // Future<bool> logout() async {
  //   return true;
  // }

  Future<Either<String?, bool>> addNewStaff({required UserModel user}) async {
    try {
      await _firestore.collection("users").add({
        "userId": user.userId,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "phone": user.phone,
        "email": user.email,
        "role": "staff",
        "address": user.address,
        "date": DateTime.now().toString(),
        "status": "Active",
        "hostile": user.hostile,
        "department": user.department,
        "faculty": user.faculty,
        "gender": user.gender,
        "middleName": user.middleName,
        "password": "USDS@123"
      });
      return const Right(true);
    } catch (e) {
      log("Failed to create staff: $e");
      return const Left("Failed to create user");
      // TODO
    }
  }

  // Future<Either<String, bool>> resetPassword({
  //   required String userid,
  //   required String password,
  // }) async {
  //   try {
  //     await _firestore
  //         .collection('users')
  //         .doc(userid)
  //         .update({'password': password});
  //     log("Password updated successfully");
  //     return const Right(true);
  //   } catch (e) {
  //     log("Failed to update password : $e");
  //     return const Right(false);
  //   }
  // }

  Future<Either<String, List<UserModel>>> getAllStaff() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('users').get();
      final List<UserModel> listOfUsers = [];

      for (var item in querySnapshot.docs) {
        final itemData = item.data() as Map<String, dynamic>;

        final userModel = UserModel(
          firstName: itemData['firstName'],
          middleName: itemData['middleName'],
          lastName: itemData['lastName'],
          phone: itemData['phone'],
          email: itemData['email'],
          role: itemData['role'],
          department: itemData['department'],
          faculty: itemData['faculty'],
          address: itemData['address'],
          hostile: itemData['hostile'],
          date: itemData['date'],
          status: itemData['status'],
          gender: itemData['gender'],
          userId: itemData['userId'],
          password: itemData['password'],
        );

        listOfUsers.add(userModel);
      }
      log("====dta==$listOfUsers");

      // Return a success message or appropriate data
      return Right(listOfUsers);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }

  Future<Either<String, String>> getStaffByUser(
      {required String userId}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();
      final data = querySnapshot.docs;
      final userid = data.first.id;

      if (userid.isNotEmpty) {
        log("====data==${data.first.id}");

        return Right(userid);
      } else {
        return Right(userid);
      }
    } catch (e) {
      log("====Error==$e");
      return const Left("");
    }
  }

  Future<Either<String, int>> getStaffByGender({required String gender}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('gender', isEqualTo: gender)
          .get();
      final data = querySnapshot.docs;

      if (data.isNotEmpty) {
        return Right(data.length);
      } else {
        return const Right(0);
      }
    } catch (e) {
      log("====Error==$e");
      return const Left("");
    }
  }
}
