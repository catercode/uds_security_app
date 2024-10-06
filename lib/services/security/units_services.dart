import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';
import 'package:uds_security_app/services/auth/hive_auth_user.dart';

class UnitServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  HiveAuthServices hiveAuthServices = HiveAuthServices();
  Future<Either<String, List<UnitModel>>> getUnits() async {
    try {
      QuerySnapshot? querySnapshot;
      List<UnitModel> listOfUnits = [];
      querySnapshot = await _firestore.collection('units').get();

      for (var item in querySnapshot.docs) {
        final staffData = item.data() as Map<String, dynamic>;

        final unitModel = UnitModel(
          unitId: item.id,
          unitName: staffData['unitName'],
          location: staffData['location'],
          date: staffData['date'],
          status: staffData['status'],
        );
        listOfUnits.add(unitModel);
      }
      return Right(listOfUnits);
    } catch (e) {
      return const Left("Failed to retrieve units");
    }
  }

  Future<Either<String, Unit>> deleteUnitsGuardById(
      {required String id}) async {
    try {
      await _firestore.collection('units').doc(id).delete();

      return const Right(unit);
    } catch (e) {
      log("Failed to delete unit: $e");
      return const Left("Failed to delete units");
    }
  }

  Future<Either<String, UnitModel>> getUnitsGaurdById(
      {required String unitName}) async {
    try {
      QuerySnapshot? querySnapshot;

      querySnapshot = await _firestore
          .collection('units')
          .where("unitName", isEqualTo: unitName)
          .get();

      final unitData = querySnapshot.docs.first.data() as Map<String, dynamic>;

      final unitModel = UnitModel(
        unitId: unitData['unitId'],
        unitName: unitData['unitName'],
        location: unitData['location'],
        date: unitData['date'],
        status: unitData['status'],
      );

      return Right(unitModel);
    } catch (e) {
      log("=-----ee------=======$e");
      return const Left("Failed to retrieve units");
    }
  }

  Future<Either<String, UserModel>> getGuardById({required String id}) async {
    try {
      QuerySnapshot? querySnapshot;

      querySnapshot = await _firestore
          .collection('users')
          .where("userId", isEqualTo: id)
          .get();

      final staffData = querySnapshot.docs.first.data() as Map<String, dynamic>;

      final userModel = UserModel(
        id: staffData['id'],
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
      hiveAuthServices.saveCurrentUser(user: userModel);
      return Right(userModel);
    } catch (e) {
      log("=-----ee------=======$e");
      return const Left("Failed to retrieve units");
    }
  }

  Future<Either<String, List<UserModel>>> getUnitsGaurds(unitid) async {
    try {
      final snapshot = await _firestore
          .collection('units')
          .doc(unitid)
          .collection('guards')
          .get();

      final List<UserModel> listOfUsers = [];

      for (var item in snapshot.docs) {
        final staffData = item.data();

        final userModel = UserModel(
          id: staffData['id'],
          unitId: item.id,
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
      return const Left("Failed to retrieve units");
    }
  }

  Future<Either<String?, bool>> addNewUnit({required UnitModel unit}) async {
    try {
      await _firestore.collection("units").add({
        "unitId": unit.unitId,
        "unitName": unit.unitName,
        "date": DateTime.now().toString(),
        "location": unit.location,
        "status": "enable",
      });
      return const Right(true);
    } catch (e) {
      log("Failed to create unit: $e");
      return const Left("Failed to create unit");
      // TODO
    }
  }

  Future<Either<String, bool>> assignedGuard(
      {required UnitModel unit, required UserModel guard}) async {
    try {
      final user = guard.copyWith(unitAssigned: unit.unitName);

      await _firestore
          .collection('units')
          .doc(unit.unitId)
          .collection('guards')
          .add(user.toJson());

      return const Right(true);
    } on Exception catch (e) {
      log("=======Exception==========$e");
      return const Left("Failed to create unit");
    }
  }

  Future<Either<String, bool>> reasignGuard({
    required UnitModel oldUnit,
    required UnitModel newUnit,
    required UserModel guard, // Pass the guard's document ID here
  }) async {
    try {
      log("=======GuardID -- 1==========${guard.id}");
      await _firestore
          .collection('units')
          .doc(oldUnit.unitId)
          .collection('guards')
          .doc(guard.unitId) // Reference to the specific guard's document
          .delete();

      assignedGuard(guard: guard, unit: newUnit);

      return const Right(true);
    } on Exception catch (e) {
      log("=======Exception==========$e");
      return const Left("Failed to delete guard");
    }
  }
}
