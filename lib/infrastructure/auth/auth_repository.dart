import 'package:cubit/domain/auth/model/login_error_response.dart';
import 'package:cubit/domain/auth/model/login_request.dart';
import 'package:cubit/domain/auth/model/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final _dio = Dio();

  Future<Either<LoginErrorResponse, LoginResponse>>
      signInUserWithEmailandPassword(
          {required LoginRequest loginRequest}) async {
    Response _response;

    try {
      _response = await _dio.post(
        "https://reqres.in/api/login",
        data: loginRequest.toJson(),
      );

      LoginResponse loginResp = LoginResponse.fromJson(_response.data);

      return right(loginResp);
    } on DioException catch (e) {
      LoginErrorResponse loginResp =
          LoginErrorResponse.fromJson(e.response!.data);
      print(loginResp.error);
      return left(loginResp);
    }
  }
}
