import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dio/ui/controller.dart';
import 'package:flutter_dio/ui/widgets/user_form.dart';

import '../../di/service.locator.dart';

import '../newuser_page.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});

  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return UserForm(
              homeController: homeController,
              onSubmit: () async {
                await homeController.addNewUser();
                Navigator.pop(context);
                homeController.nameController.clear();
                homeController.jobController.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewUserPage()));
              },
              isUpdate: false,
            );
          },
        );
      },
      child: Icon(Icons.add),
    );
  }
}
