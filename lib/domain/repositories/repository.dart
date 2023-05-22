import 'package:advanced_flutter/domain/entities/home_object.dart';
import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../../data/requestes/login_request.dart';
import '../entities/auth.dart';

abstract class Repository {
  Future<Either<Failure, HomeObject>> getHomeData();

  Future<Either<Failure, Auth>> login(
    LoginRequest loginRequest,
  );
  Future<Either<Failure, String>> forgotPassword(
    String email,
  );
  Future<Either<Failure, Auth>> register(
    RegisterRequest registerRequest,
  );
}
