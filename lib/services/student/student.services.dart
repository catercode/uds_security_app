import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/caseModel/case.model.dart';
import 'package:uds_security_app/models/unitModel/unit.model.dart';

class StudentServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, List<CaseModel>>> getAllCasesByGuardId(
      {required String studentId}) async {
    try {
      final QuerySnapshot? querySnapshot;
      final List<CaseModel> listOfUsers = [];
      log(studentId);
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

  Future<Either<String, int>> getCasesCount(
      {required String status, String? userId}) async {
    try {
      final QuerySnapshot? querySnapshot;

      if (userId == null) {
        querySnapshot = await _firestore
            .collection('cases')
            .where('status', isEqualTo: status)
            .get();
      } else {
        querySnapshot = await _firestore
            .collection('cases')
            .where('studentId', isEqualTo: userId)
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

  Stream<DocumentSnapshot>? studentNiotification({required String reporterId}) {
     
    try {
        final data = _firestore
          .collection('cases')
          .where('securityAssign', isNotEqualTo: 'Not Assigned')
          .where('status', isEqualTo: "false")
          .snapshots()
          .map((snapshot) => snapshot.docs.first);
       return data; 
    } catch (e) {
      log("====================$e");
      return null;
    }
   
  }
}
