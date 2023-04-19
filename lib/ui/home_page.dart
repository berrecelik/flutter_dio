import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dio/data/network/models/user.dart';
import 'package:flutter_dio/ui/controller.dart';

import 'package:flutter_dio/ui/widgets/add_user.dart';
import 'package:flutter_dio/ui/widgets/base_appbar.dart';

import '../di/service.locator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homeController = getIt<HomeController>();

  //we created a controller
  //we will request data from the UI by triggering method defined in the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      floatingActionButton: AddUser(),
      body: FutureBuilder<List<UserModel>>(
        future: homeController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: " + error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    leading: user.avatar != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              user.avatar!,
                              height: 50,
                              width: 50,
                            ),
                          )
                        : null,
                    title: Text(user.email ?? ""),
                    subtitle: Text(user.firstName ?? ""),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
