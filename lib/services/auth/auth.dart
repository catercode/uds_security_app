import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either<bool, UserModel>> login(
      String email, String password, String role) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: false)
          .where('password', isEqualTo: "Business")
          .where('role', isEqualTo: role)
          .get();
      final data = querySnapshot.docs;
      if (data.isNotEmpty) {
        final user = UserModel.fromJson(data as Map<String, dynamic>);

        return Right(user);
      } else {
        return const Left(false);
      }
    } catch (e) {
      return const Left(false);
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
        "date": user.date,
        "status": user.status,
        "password": user.password
      });
      return const Right(true);
    } catch (e) {
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
