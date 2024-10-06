import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class StaffServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String?, bool>> addNewStaff({required UserModel user}) async {
    try {
      await _firestore.collection("users").add({
        "userId": user.userId ?? "",
        "firstName": user.firstName ?? "",
        "lastName": user.lastName ?? "",
        "phone": user.phone ?? "",
        "email": user.email ?? "",
        "unitId": user.unitId ?? "",
        "role": user.role ?? "",
        "address": user.address ?? "",
        "date": DateTime.now().toString(),
        "status": "Active",
        "hostile": user.hostile ?? "",
        "department": user.department ?? "",
        "faculty": user.faculty ?? "",
        "gender": user.gender ?? "",
        "middleName": user.middleName ?? "",
        "password": "USDS@123",
        "rank": user.rank ?? "",
        "unitAssigned": "Not Assigned",
      });
      log("Guard created successfully");
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
  Future<Either<String, List<UserModel>>> getAllGaurdNotAssigned(
      {required String status}) async {
    try {
      final QuerySnapshot? querySnapshot;

      final List<UserModel> listOfUsers = [];

      if (status == "All") {
        querySnapshot = await _firestore.collection('users').get();
      } else {
        querySnapshot = await _firestore
            .collection('users')
            .where('role', isEqualTo: status)
            .where('unitAssigned', isEqualTo: "Not Assigned")
            .get();
      }

      for (var item in querySnapshot.docs) {
        final staffData = item.data() as Map<String, dynamic>;

        final userModel = UserModel(
          id: item.id,
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

        listOfUsers.add(userModel);
      }

      // Return a success message or appropriate data
      return Right(listOfUsers);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }

  Future<Either<String, UserModel>> getGuardById({required String id}) async {
    log(id);
    try {
      // Fetch the document with the provided id.
      final querySnapshot = await _firestore
          .collection('users')
          .where("userId", isEqualTo: id)
          .get();

      final staffData = querySnapshot.docs.first.data();

      final userModel = UserModel(
        id: staffData["id"],
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
      log("Exception occurred: $e");
      //  return const Left("User not found");
      return const Left("Something went wrong");
    }
  }

  Future<Either<String, List<UserModel>>> getAllStaff(
      {required String status}) async {
    try {
      final QuerySnapshot? querySnapshot;

      if (status == "All") {
        querySnapshot = await _firestore.collection('users').get();
      } else {
        querySnapshot = await _firestore
            .collection('users')
            .where('role', isEqualTo: status)
            .get();
      }

      final List<UserModel> listOfUsers = [];

      for (var item in querySnapshot.docs) {
        final staffData = item.data() as Map<String, dynamic>;

        final userModel = UserModel(
          id: item.id,
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

        listOfUsers.add(userModel);
      }

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
        return Right(userid);
      } else {
        return Right(userid);
      }
    } catch (e) {
      log("====Error==$e");
      return const Left("");
    }
  }

  Future<Either<String, int>> getStaffByGender(
      {required String gender}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('gender', isEqualTo: gender)
          .where('role', isEqualTo: 'staff')
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

  Future<Either<String, int>> getStaffByRole({required String role}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: role)
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

  Future<Either<String, int>> getStudentByGender(
      {required String gender, required String role}) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('gender', isEqualTo: gender)
          .where('role', isEqualTo: role)
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

  Future<Either<String?, bool>> reportCase({required CaseModel issues}) async {
    try {
      await _firestore.collection("cases").add({
        "level": issues.level,
        "securityAssign": "Not Assigned",
        "statement": issues.statement,
        "status": issues.status,
        "studentId": issues.studentId,
        "date": DateTime.now().toString(),
      });

      return const Right(true);
    } catch (e) {
      log("Failed to create case: $e");
      return const Left("Failed to create user");
      // TODO
    }
  }

  Stream<DocumentSnapshot>? studentNiotification({required String newPost}) {
    try {
      final data = _firestore
          .collection('users')
          .where('securityAssign', isNotEqualTo: newPost)
          .snapshots()
          .map((snapshot) => snapshot.docs.first);
      return data;
    } catch (e) {
      log("====================$e");
      return null;
    }
  }
}
