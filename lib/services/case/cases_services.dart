import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';

class CaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String?, bool>> reportCase({required CaseModel issues}) async {
    try {
      await _firestore.collection("cases").add({
        "level": issues.level,
        "securityAssign": "Not Assigned",
        "statement": issues.statement,
        "status": "false",
        "quickReport": issues.quickReport,
        "studentId": issues.studentId,
        "date": DateTime.now().toString(),
      });

      log("Case created successfully");
      return const Right(true);
    } catch (e) {
      log("Failed to create case: $e");
      return const Left("Failed to create user");
      // TODO
    }
  }

  Future<Either<String, List<CaseModel>>> getAllCases(
      {required String status}) async {
    try {
      final QuerySnapshot? querySnapshot;
      final List<CaseModel> listOfUsers = [];

      if (status == "All") {
        querySnapshot = await _firestore.collection('cases').get();
      } else {
        querySnapshot = await _firestore
            .collection('cases')
            .where("status", isEqualTo: status)
            .get();
      }
      for (var casedata in querySnapshot.docs) {
        final caseItem = casedata.data() as Map<String, dynamic>;

        final caseModel = CaseModel(
          id: casedata.id,
          level: caseItem['level'],
          securityAssign: caseItem['securityAssign'],
          statement: caseItem['statement'],
          studentId: caseItem['studentId'],
          date: caseItem['date'],
          quickReport: caseItem['quickReport'],
          status: caseItem['status'],
        );
        listOfUsers.add(caseModel);
      }

      // Return a success message or appropriate data
      return Right(listOfUsers);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }

  Future<Either<String, List<CaseModel>>> getAllCasesByStudentId(
      {required String studentId}) async {
    try {
      final QuerySnapshot? querySnapshot;
      final List<CaseModel> listOfUsers = [];

      querySnapshot = await _firestore
          .collection('cases')
          .where('studentId', isEqualTo: studentId)
          .get();
      for (var casedata in querySnapshot.docs) {
        final caseItem = casedata.data() as Map<String, dynamic>;

        final caseModel = CaseModel(
          id: casedata.id,
          level: caseItem['level'],
          securityAssign: caseItem['securityAssign'],
          statement: caseItem['statement'],
          studentId: caseItem['studentId'],
          date: caseItem['date'],
          quickReport: caseItem['quickReport'],
          status: caseItem['status'],
        );
        listOfUsers.add(caseModel);
      }

      // Return a success message or appropriate data
      return Right(listOfUsers);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }

  Future<Either<String, List<CaseModel>>> getAllCasesByGuardId(
      {required String guardId}) async {
    log("message : $guardId");
    try {
      final QuerySnapshot? querySnapshot;
      final List<CaseModel> listOfUsers = [];
      log(guardId);
      querySnapshot = await _firestore
          .collection('cases')
          .where('securityAssign', isEqualTo: guardId)
          .get();
      for (var casedata in querySnapshot.docs) {
        final caseItem = casedata.data() as Map<String, dynamic>;

        final caseModel = CaseModel(
          id: casedata.id,
          level: caseItem['level'],
          securityAssign: caseItem['securityAssign'],
          statement: caseItem['statement'],
          studentId: caseItem['studentId'],
          date: caseItem['date'],
          quickReport: caseItem['quickReport'],
          status: caseItem['status'],
        );
        listOfUsers.add(caseModel);
      }

      // Return a success message or appropriate data
      return Right(listOfUsers);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }

  Future<Either<String, int>> getCasesCount(
      {required String status, String? userId}) async {
    try {
      final QuerySnapshot? querySnapshot;
      log(status);

      if (status != "All") {
        querySnapshot = await _firestore
            .collection('cases')
            .where('status', isEqualTo: status)
            .get();
      } else {
        querySnapshot = await _firestore
            .collection('cases')
            .where("securityAssign", isEqualTo: userId)
            .where('status', isEqualTo: status)
            .get();
      }

      // Return a success message or appropriate data
      return Right(querySnapshot.docs.length);
    } catch (e) {
      log("====Error==$e");
      return const Left("Failed to retrieve user data.");
    }
  }
  Future<Either<String, bool>> markCaseCompleted({
    required String caseid,
  
  }) async {
    log(caseid);
    try {
      await _firestore
          .collection('cases')
          .doc(caseid)
          .update({'status': "true"});

      return const Right(true);
    } catch (e) {
      log("Failed to assigned ------: $e");
      return Left(e.toString());
    }
  }
  Future<Either<String, bool>> assignAgentToCase({
    required String caseid,
    required String gaurdName,
  }) async {
    log(caseid);
    try {
      await _firestore
          .collection('cases')
          .doc(caseid)
          .update({'securityAssign': gaurdName});

      return const Right(true);
    } catch (e) {
      log("Failed to assigned ------: $e");
      return Left(e.toString());
    }
  }

  Stream<DocumentSnapshot>? adminNiotification({required String reporterId}) {
    try {
      final data = _firestore
          .collection('cases')
          .where('securityAssign', isEqualTo: 'Not Assigned')
          .where('status', isEqualTo: "false")
          .snapshots()
          .map((snapshot) => snapshot.docs.first);

      return data;
      //   .map((snapshot) {
      // if (snapshot.docs.isNotEmpty) {
      //   return snapshot.docs.first;
      // } else {
      //   // Return null if no documents are found
      //   return null;
      // }
      // });
      // log("=======2=============$data");
    } catch (e) {
      log("====================$e");
      return null;
    }
    // return null;
  }

  Stream<DocumentSnapshot>? gaurdNiotification({
    required String guardId,
  }) {
    try {
      final data = _firestore
          .collection('cases')
          .where('securityAssign', isEqualTo: guardId)
          .where('status', isEqualTo: "false")
          .snapshots()
          .map((snapshot) => snapshot.docs.first);

      return data;
    } catch (e) {
      log("====================$e");
      return null;
    }
  }

  Stream<DocumentSnapshot>? gaurdAssignPositionNiotification(
      {required String unitName, required String id}) {
    try {
      log("==========7777777777777$unitName==========$id");
      final data = _firestore
          .collection('users')
          .where('userId', isEqualTo: id)
          // .where("unitAssigned", isNotEqualTo: unitName)
          .snapshots()
          .map((snapshot) => snapshot.docs.first);

      return data;
    } catch (e) {
      log("====================$e");
      return null;
    }
  }
}
