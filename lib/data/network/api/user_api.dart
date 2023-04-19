//We are going to define different API request methods
//which will directly call the client's method
//and will return the RAW data.

import 'package:dio/dio.dart';
import 'package:flutter_dio/data/network/api/constant/endpoints.dart';
import 'package:flutter_dio/data/network/dio_client.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

//For the POST method the required data is passed in Map format.
  Future<Response> addUserApi(String name, String job) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          "name": name,
          "job": job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUserApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.users);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//For the PUT method we need an Id,
//which is used to update only the user that contains that Id.
  Future<Response> updateUserApi(int id, String name, String job) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.users + "/$id",
        data: {"name": name, "job": job},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserApi(int id) async {
    try {
      await dioClient.delete(Endpoints.users + '/$id');
    } catch (e) {
      rethrow;
    }
  }
}
