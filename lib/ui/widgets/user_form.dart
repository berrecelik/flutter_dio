// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dio/ui/controller.dart';

class UserForm extends StatelessWidget {
  const UserForm({
    Key? key,
    required this.homeController,
    this.isUpdate = false,
    required this.onSubmit,
  }) : super(key: key);

  final HomeController homeController;
  final bool? isUpdate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: homeController.nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: homeController.jobController,
            decoration: InputDecoration(labelText: "Job"),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: onSubmit, child: Text(isUpdate! ? "Update" : "Add"))
        ],
      ),
    );
  }
}
