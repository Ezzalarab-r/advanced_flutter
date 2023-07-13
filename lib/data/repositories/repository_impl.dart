// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/auth.dart';
import '../../domain/entities/home_object.dart';
import '../../domain/entities/store_details.dart';
import '../../domain/repositories/repository.dart';
import '../../presentation/resources/strings_manager.dart';
import '../data_sources/local_ds.dart';
import '../data_sources/remote_ds.dart';
import '../failures/error_handler.dart';
import '../failures/failure.dart';
import '../mappers/mapper.dart';
import '../network/network_info.dart';
import '../requestes/login_request.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDS _remoteDS;
  final LocalDS _localDS;

  RepositoryImpl(
    this._networkInfo,
    this._remoteDS,
    this._localDS,
  );

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    if (await _networkInfo.isConeected) {
      try {
        final homeLocalDataResponse = await _localDS.getHomeData();
        return Right(homeLocalDataResponse.toDomain());
      } catch (cacheError) {
        try {
          final homeRemoteDataResponse = await _remoteDS.getHomeData();
          if (homeRemoteDataResponse.status == ApiInternalStatus.success) {
            // Success
            _localDS.saveHomeToCache(homeRemoteDataResponse);
            return Right(homeRemoteDataResponse.toDomain());
          } else {
            return Left(Failure(
                code: ApiInternalStatus.failure,
                message:
                    homeRemoteDataResponse.message ?? AppStrings.unknown.tr()));
          }
        } catch (error) {
          if (kDebugMode) {
            print("getHomeData catch error");
            print(error);
          }
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      if (kDebugMode) {
        print("no internet");
      }
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConeected) {
      try {
        final authResponse = await _remoteDS.login(loginRequest);
        if (authResponse.status == ApiInternalStatus.success) {
          return Right(authResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message: authResponse.message ?? AppStrings.unknown.tr()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConeected) {
      try {
        final resetPasswordResponse = await _remoteDS.forgotPassword(email);
        if (resetPasswordResponse.status == ApiInternalStatus.success) {
          return Right(resetPasswordResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message:
                  resetPasswordResponse.message ?? AppStrings.unknown.tr()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> register(RegisterRequest register) async {
    if (await _networkInfo.isConeected) {
      try {
        final authResponse = await _remoteDS.register(register);
        if (authResponse.status == ApiInternalStatus.success) {
          return Right(authResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message: authResponse.message ?? AppStrings.unknown.tr()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails(int storeId) async {
    if (await _networkInfo.isConeected) {
      // try {
      //   final homeLocalDataResponse = await _localDS.getStoreDetails(storeId);
      //   return Right(homeLocalDataResponse.toDomain());
      // } catch (cacheError) {
      try {
        final storeDetailsRemoteResponse =
            await _remoteDS.getStoreDetails(storeId);
        if (storeDetailsRemoteResponse.status == ApiInternalStatus.success) {
          // Success
          // _localDS.saveStoreDetailsToCache(storeDetailsRemoteResponse);
          return Right(storeDetailsRemoteResponse.toDomain());
        } else {
          return Left(Failure(
              code: ApiInternalStatus.failure,
              message: storeDetailsRemoteResponse.message ??
                  AppStrings.unknown.tr()));
        }
      } catch (error, s) {
        if (kDebugMode) {
          print("getStoreDetails $storeId error");
          print(error);
          print(s);
        }
        return Left(ErrorHandler.handle(error).failure);
      }
      // }
    } else {
      if (kDebugMode) {
        print("no internet");
      }
      return Left(ErrorSource.noInternetConnection.getFailure());
    }
  }
}
