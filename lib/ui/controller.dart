import 'package:flutter/widgets.dart';
import 'package:flutter_dio/data/network/models/new_user.dart';
import 'package:flutter_dio/data/network/models/user.dart';
import 'package:flutter_dio/data/network/repository/user_repository.dart';
import 'package:flutter_dio/di/service.locator.dart';

//The reason for creating the controller is to separate the business logic from the UI.

class HomeController {
  //REPOSITORY
  final userRepository = getIt.get<UserRepository>();

  final nameController = TextEditingController();
  final jobController = TextEditingController();

  final List<NewUser> newUsers = [];

  //METHODS
  Future<List<UserModel>> getUsers() async {
    final users = await userRepository.getUserRequested();
    return users;
  }

  Future<NewUser> addNewUser() async {
    final newAddedUser = await userRepository.addNewUserRequested(
        nameController.text, jobController.text);
    newUsers.add(newAddedUser);
    return newAddedUser;
  }

  Future<NewUser> updateUser(int id, String name, String job) async {
    final updatedUser = await userRepository.updateUserRequested(id, name, job);
    newUsers[id] = updatedUser;
    return updatedUser;
  }

  Future<void> deleteNewUser(int id) async {
    await userRepository.deleteNewUserRequested(id);
    newUsers.removeAt(id);
  }
}
