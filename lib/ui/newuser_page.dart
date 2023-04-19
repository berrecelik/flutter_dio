import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dio/data/network/models/new_user.dart';

import 'package:flutter_dio/ui/controller.dart';
import 'package:flutter_dio/ui/widgets/user_form.dart';
import 'package:intl/intl.dart';

import '../di/service.locator.dart';

//The setState() method is used after calling homeController.deleteNewUser() method
//and homeController.updateUser() method. This is because both of these methods are asynchronous,
//and the setState() method is called
//after the execution of these methods to rebuild the UI with the updated data

//When setState() is called, it triggers a rebuild of the widget tree,
//which causes the ListView to rebuild with the new data.
//Without calling setState(), the UI would not reflect the changes made to the homeController.newUsers list,
//and the user would not be able to see the updated list of users
//or the confirmation message that the user was successfully deleted or updated.

//Therefore, calling setState() is necessary to update the UI
//with the changes made to the homeController.newUsers list.**

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final homeController = getIt.get<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Added User"),
      ),
      body: ListView.builder(
          itemCount: homeController.newUsers.length,
          itemBuilder: (context, index) {
            final NewUser user = homeController.newUsers[index];
            return ListTile(
                onLongPress: () async {
                  await homeController.deleteNewUser(index).then((value) {
                    setState(() {});
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("User deleted succesfully"),
                      duration: Duration(seconds: 1),
                    ));
                  });
                },
                onTap: () {
                  homeController.nameController.text = user.name!;
                  homeController.jobController.text = user.job!;
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return UserForm(
                            homeController: homeController,
                            isUpdate: true,
                            onSubmit: () async {
                              await homeController
                                  .updateUser(
                                      index,
                                      homeController.nameController.text,
                                      homeController.jobController.text)
                                  .then((value) {
                                Navigator.pop(context);
                                setState(() {});
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("User updated successfully"),
                                  duration: Duration(seconds: 1),
                                ));
                              });
                            });
                      });
                },
                title: Text(user.name!),
                subtitle: Text(user.job!),
                trailing: user.updatedAt != null
                    ? Text(DateFormat().format(DateTime.parse(user.updatedAt!)))
                    : Text(
                        DateFormat().format(DateTime.parse(user.createdAt!))));
          }),
    );
  }
}
