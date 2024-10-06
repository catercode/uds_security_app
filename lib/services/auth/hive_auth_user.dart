import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:uds_security_app/models/userModel/user.model.dart';

class HiveAuthServices {
  Future<bool> saveCurrentUser({required UserModel user}) async {
    try {
      final userData = user.toJson();

      // Open the box
      var box = await Hive.openBox('loginUser');

      // Save the current user data
      await box.put('currentUser', userData);

      // Close the box
      await box.close();

      return true;
    } catch (e) {
      log("Error saving user info: $e");
      return false;
    }
  }

  Future<Either<bool, UserModel>> hasUserLogin() async {
    try {
      var box = await Hive.openBox('loginUser');

      var data = box.get('currentUser');

      if (data != null) {
        final userData = Map<String, dynamic>.from(data);

        final currentUser = UserModel.fromJson(userData);

        await box.close();

        return Right(currentUser);
      } else {
        await box.close();
        return const Left(false);
      }
    } catch (e) {
      log("Error checking user login: $e");
      return const Left(false);
    }
  }

  clearHive() async {
    var box = await Hive.openBox('loginUser');
    box.clear();
  }
}
